Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVAJMmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVAJMmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 07:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAJMmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 07:42:42 -0500
Received: from tim.rpsys.net ([194.106.48.114]:7121 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262225AbVAJMmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 07:42:33 -0500
Message-ID: <019201c4f711$67237c20$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <007e01c4ef30$f23ba3c0$0f01a8c0@max> <1104674725.14712.50.camel@localhost.localdomain> <067d01c4f69b$cb9d8b80$0f01a8c0@max> <1105314226.12054.57.camel@localhost.localdomain>
Subject: Re: Flaw in ide_unregister()
Date: Mon, 10 Jan 2005 12:39:15 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> On Sul, 2005-01-09 at 22:37, Richard Purdie wrote:
>> I haven't investigated it yet but I suspect the usage count is held by
>> ide-disk as the CF card has a mounted filesystem. As previously mentioned
>> and for reference, this patch has the changes I had to make to get 
>> standard
>> 2.6.10 to work:
>
> Correct. This is intentional - what the -ac code allows you to do
> (although you probably need to move the final free up to a workqueue) is
> to free the hardware resources. The ide resources will then free later
> on the umount

Ok. I can see what you're saying and I can visualise a patch for ide-cs.c 
which will probably work using a workqueue as you suggest.

I'd like to question whether the driver or the ide code should be taking 
care of this freeing of resources though?

It all depends what a call to ide_unregister()  is supposed to mean. I'd 
have thought it should mean *remove this inferface by doing whatever is 
neccessary to do so*. If its busy and/or in use, wait until it isn't and 
then remove it by queueing some work to do so at a later date.

Offloading this responsibility onto each and every driver seems rather 
rather unwise and will result in a lot of code duplication. Are there any 
circumstances where we need ide_unregister to abort on busy? Even if there 
are would a flag to indicate what it should do with a busy drive be better?

Richard 

