Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTJJDNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 23:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbTJJDNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 23:13:10 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:49283 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262337AbTJJDNH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 23:13:07 -0400
Message-ID: <3F862556.5080701@pacbell.net>
Date: Thu, 09 Oct 2003 20:19:50 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB APM suspend
References: <Pine.LNX.4.44L0.0309221606230.677-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0309221606230.677-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:

> 
> I tried the experiment of getting rid of the calls to pm_send_all().  
> Surprisingly enough, it worked.  That is, when I typed:
> 
> 	apm --suspend
> 
> everything was suspended, in the correct order; and when I pressed a key 
> everything awoke and seemed to be functioning properly.  

Just for the record:  I tried this on 2.6.0-test7, on a system where
APM has worked reliably forever, and it failed.  (That was without even
involving USB -- there are still non-USB PM problems.)

The device_suspend() logic did seem to call things in the right order,
on one machine I hacked with some printks, but when the moment came to
actually enter the APM suspend mode nothing happened ... except for a
delay of maybe a minute, before the system resumed itself.  (FWIW the
PCI suspend methods involved were for yenta_cardbus and agpgart-intel.
Both of those were called after "hda" spun itself down.)

What should happen of course is the APM BIOS takes over and blanks the
display, and the power indicator changes (in my case to a low-frequency
amber blink, no longer solid green).

- Dave



