Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTHSKHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbTHSKHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:07:07 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:35588 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S269621AbTHSKHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:07:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Simon Haynes <simon@baydel.com>
Reply-To: simon@baydel.com
Organization: Baydel Ltd.
To: root@chaos.analogic.com
Subject: Re: File access
Date: Tue, 19 Aug 2003 10:53:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <67597854DA5@baydel.com> <Pine.LNX.4.53.0308140803430.179@chaos>
In-Reply-To: <Pine.LNX.4.53.0308140803430.179@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <1FDBD34B76B1@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually had a character interface which I use for on the fly 
configuration. I have now implemented some code which uses a user process to 
pass the configuration to the driver. I have however run into problems trying 
to write files from the driver. I have tried implementing a user process 
which performs a blocking read. The user process is blocked with 
interruptible_sleep_on and is woken by the main part of the driver when it 
needs to write. The problem is I then need to stall the main part of the 
driver while the data gets written out. My problem is that this write needs 
to happen from an interrupt handler or a timer process. I cannot seem to 
block these with interruptible_sleep_on, the kernel crashes. I guess you 
cannot use this in these cases ? I have also tried semaphores without much 
success. I have looked for the howto but failed there also. 

Could you please tell me where I could find this FAQ.

Many Thanks

Simon.




On Thursday 14 Aug 2003 1:07 pm, Richard B. Johnson wrote:



> On Thu, 14 Aug 2003, Simon Haynes wrote:
> > I am currently developing a module which I would like to configure
> > via a simple text file.
> >
> > I cannot seem to find any information on accessing files via a kernel
> > module.
> >
> > Is this possible and if so how is it done ?
> >
> > Many Thanks
> >
> > Simon.
>
> This has become a FAQ. You make your module accept parameters
> from an ioctl(). Then you use a user-mode task to read file(s)
> and configure your module.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
