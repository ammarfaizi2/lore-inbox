Return-Path: <linux-kernel-owner+w=401wt.eu-S965232AbXAGWbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbXAGWbV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbXAGWbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:31:21 -0500
Received: from mail.macqel.be ([194.78.208.39]:21754 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965232AbXAGWbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:31:21 -0500
Date: Sun, 7 Jan 2007 23:31:19 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: hugh@veritas.com, david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: RTC subsystem and fractions of seconds
Message-ID: <20070107223119.GA1423@ingate.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Jan 2007, Hugh Dickins wrote:
> Author: Matt Mackall <mpm@selenic.com>
> 
>     [PATCH] RTC: Remove RTC UIP synchronization on x86
>     
>     Reading the CMOS clock on x86 and some other arches currently takes up to one
>     second because it synchronizes with the CMOS second tick-over.  This delay
>     shows up at boot time as well a resume time.

That is true if kernel's idea of an RTC's precision is 1 second.  With better
RTC's (e.g. m41t81) this delay can be reduced to 0.01 second, which is
acceptable IMHO in the boot phase.  That needs however changes in the kernel
interface to RTC's :

    - read_time should take a new parameter *nsec (or struct rtc_time should
    contain a new nsec field, so that the RTC can report its complete time
    information to the kernel.

    - struct rtc_device (or rtc_class_ops with another name) should contain
    a new field giving the RTC's resolution in nsecs, if we want to avoid the
    loop, but do not want our 0.01 second precision be destructed by always
    adding 0.5 second in rtc_hctosys
    
Philippe
