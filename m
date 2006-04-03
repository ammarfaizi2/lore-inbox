Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWDCQNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWDCQNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWDCQNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:13:12 -0400
Received: from rtr.ca ([64.26.128.89]:25269 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751756AbWDCQNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:13:10 -0400
Message-ID: <44314974.90907@rtr.ca>
Date: Mon, 03 Apr 2006 12:12:36 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060402 SeaMonkey/1.1a
MIME-Version: 1.0
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Problems with USB setup with Linux 2.6.16
References: <Pine.LNX.4.44L0.0604022155060.29134-100000@netrider.rowland.org> <44309821.1090600@triplehelix.org>
In-Reply-To: <44309821.1090600@triplehelix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:
> On 04/02/2006 07:09 PM, Alan Stern wrote:
>> If you were to continue looking farther down in the log, you would find
>> that ehci-hcd sees all those devices.  Those that can run at high speed
>> continue using the EHCI controller.  For those that can't, the switch is 
>> reset and they get reconnected to their UHCI controller.
> 
> That makes sense - that is indeed what happens when it DOES work (i.e.
> with 2.6.15), but the fact is that they don't come back in 2.6.16. I
> will try building ehci-hcd in and see what happens.

Around 2.6.13, I noticed that EHCI stopped working after a suspend/resume
(to/from RAM) cycle.  So I updated my suspend script to unload/reload EHCI
each time, which fixed the problem for me.  My script still does that.

Dunno if it's fixed in mainline or not.
Does unloading/reloading EHCI help you?

   rmmod ehci_hcd ; modprobe ehci_hcd

Cheers
