Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbULCXTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbULCXTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbULCXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:19:46 -0500
Received: from gw.goop.org ([64.81.55.164]:61635 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262459AbULCXTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:19:44 -0500
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041203061520.GG31767@wotan.suse.de>
References: <1102004520.8707.10.camel@localhost>
	 <20041203061520.GG31767@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 03 Dec 2004 15:16:29 -0800
Message-Id: <1102115789.8707.122.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 07:15 +0100, Andi Kleen wrote:
> int 0x80 from 64bit will call 32bit syscalls.

Hm, that's not what I found.  If I run int 0x80 with [re]ax=1, I get
exit with a 32-bit process and write with a 64-bit one.

>  But some things
> will not work properly, e.g. signals because they test the 32bit
> flag in the task_struct. So you would still get 64bit signal frames.

OK, I can deal with that, since signals are never directly delivered to
the client.

> There are some other such tests, but they probably wont affect you.
> 
> There were some plans at one point to allow to toggle the flag 
> using personality or prctl, but so far it hasn't been implemented.
> There is also no way to do 64bit calls from a 32bit executable.

What about my idea of using distinct ranges of syscall numbers to
disambiguate them?

	J

