Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWJFRKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWJFRKN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWJFRKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:10:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:34037 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422758AbWJFRKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:10:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PmO4jC0u35UxIDOZO9V4qAqMe4HYkp7ZvdojoYDwRo6tPwIebGKjFBydla7T2QolCEIfISbhJoZ7blJF84ntk8ZGnILhZGoHVswZKTADOllu+nV5TmfVLiM9ml622WYHL45YFv+IPg4xuymkG+ZgoECrfOdrpE/ZdlJViorp8oA=
Message-ID: <513a5e60610061010k2fb0b8cex245f009d8d79de69@mail.gmail.com>
Date: Fri, 6 Oct 2006 12:10:09 -0500
From: "Madhu Saravana Sibi Govindan" <ssshayagriva@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Using "Asynchronous Notifications" within an interrupt handler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0610060741040.12702@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <513a5e60610051727t7f7c7b78u62410c4b8f8502a7@mail.gmail.com>
	 <513a5e60610051753o1dd828c4i52b8ba563601694a@mail.gmail.com>
	 <Pine.LNX.4.61.0610060741040.12702@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information.

I have another quick question: my device driver can expect up to 4
different interrupts (from 4 hardware devices). Can I send a posix
real-time signal (SIGRTMIN) using the kill_async interface and expect
the kernel to queue these signals for delievery to the sleeping
process? (Because if I use SIGIO it is possible that an incoming
interrupt is lost because the kernel doesn't queue up normal signals,
right?).

Thanks,
G.Sibi

On 10/6/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >
> > My question is: is it safe to use the asynchronous notification
> > mechanism within an interrupt handler? I see that this call acquires a
> > bunch of locks before sending the signal to the process. Would this
> > cause any deadlocking situations? Or should I resort to the top and
> > bottom half approach for interrupt handling and handle the
> > notification in the bottom half?
>
> It may be possible - I have an old driver for custom hardware lying
> around here, and it does this in the irq handler:
>
> kill_fasync(&global.fasync_ptr, SIGIO, POLL_IN);
>
>
>
>         -`J'
> --
>
