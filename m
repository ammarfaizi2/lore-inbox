Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276311AbTHSQ1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275383AbTHSQTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:19:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272323AbTHSQQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:16:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Simon Haynes <simon@baydel.com>
Reply-To: simon@baydel.com
Organization: Baydel Ltd.
To: root@chaos.analogic.com
Subject: Re: File access
Date: Tue, 19 Aug 2003 14:36:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <67597854DA5@baydel.com> <1FDBD34B76B1@baydel.com> <Pine.LNX.4.53.0308190814420.3760@chaos>
In-Reply-To: <Pine.LNX.4.53.0308190814420.3760@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <20A82354434A@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks I have looked at the attached file and I would really not like to 
access a file from the kernel but I cannot seem to get the user land app to 
work with writing. If you consider a kernel module which, in some event, 
needs to save some information in a file. The usr app is blocked in a read 
with interruptible_sleep_on. When the first write occurs the module calls 
wake_up_interruptible to write the data. Before the module can write the next 
chunk of data it needs to stall until the user process has finished. 
I can not find a method of stalling the module so it seems my only solution 
is to write the file from the kernel or dump the data somewhere manually.

Cheers

Simon.  

On Tuesday 19 Aug 2003 1:17 pm, Richard B. Johnson wrote:
> On Tue, 19 Aug 2003, Simon Haynes wrote:
> > I actually had a character interface which I use for on the fly
> > configuration. I have now implemented some code which uses a user process
> > to pass the configuration to the driver. I have however run into problems
> > trying to write files from the driver. I have tried implementing a user
> > process which performs a blocking read. The user process is blocked with
> > interruptible_sleep_on and is woken by the main part of the driver when
> > it needs to write. The problem is I then need to stall the main part of
> > the driver while the data gets written out. My problem is that this write
> > needs to happen from an interrupt handler or a timer process. I cannot
> > seem to block these with interruptible_sleep_on, the kernel crashes. I
> > guess you cannot use this in these cases ? I have also tried semaphores
> > without much success. I have looked for the howto but failed there also.
> >
> > Could you please tell me where I could find this FAQ.
> >
> > Many Thanks
> >
> > Simon.
>
> You may want to post this somewhere. I don't have a web-page.
> We are treated like prisoners here ;;;))   Just kidding, Thor
> (network spy).
>
> Cheers,
> Dick Johnson
>
>
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
