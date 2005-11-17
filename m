Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVKQRaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVKQRaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVKQRaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:30:00 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:26756 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932450AbVKQR37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:29:59 -0500
Subject: Re: A problem with ktimer
From: Steven Rostedt <rostedt@goodmis.org>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <200511171639.27565.cloud.of.andor@gmail.com>
References: <200511171639.27565.cloud.of.andor@gmail.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 12:28:08 -0500
Message-Id: <1132248488.10522.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 16:39 +0100, Claudio Scordino wrote:
> Hi,
> 
>    I know that ktimer is not yet part of the main tree of the Linux kernel.
> 
> However, maybe someone can help me to understand why the following code in a 
> module makes crash my x86_64.
> 
> Many thanks,
> 
>              Claudio
> 
> 
> 
> struct ktimer mytimer;
> 
> void myfunction()
> {
>         int i;
> }
> 
> 
> static int module_insert(void)
> {
>    ktime_t mytime = ktime_set(1,0);
>    mytimer.function = myfunction;
>    mytimer.data = NULL;
>    ktimer_init(&mytimer);
>    ktimer_start(&mytimer, &mytime, KTIMER_REL);
>    //...
> }

You must do the ktimer_init first!

So the order must be:

   ktimer_init(&mytimer);
   mytimer.function = myfunction;
   mytimer.data = NULL;
   //...

Think of ktimer_init like memset(...) (since it actually does a memset)

You wouldn't do;

struct myvar;

myvar.my_field = 1;
memset(&myvar, 0, sizeof(myvar));

Right ;-)

-- Steve


