Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWEZWFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWEZWFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWEZWFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:05:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750731AbWEZWFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:05:16 -0400
Date: Fri, 26 May 2006 15:08:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
Message-Id: <20060526150804.0ae11b1f.akpm@osdl.org>
In-Reply-To: <447778DA.8080507@gmail.com>
References: <20060526161129.557416000@gmail.com>
	<20060526162902.227348000@gmail.com>
	<20060526141603.054f0459.akpm@osdl.org>
	<44777340.7030905@gmail.com>
	<20060526144309.60469bcd.akpm@osdl.org>
	<447778DA.8080507@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> 
> >>>It would be much nicer all round if we could avoid renaming this file.
> >>
> >>Indeed... There are these 4 options as far as I see:
> >>
> >>1. Do this rename
> >>2. Put all the code in input-ff.c to input.c
> >>3. Make the input-ff a separate bool "module" and add
> >>EXPORT_SYMBOL_GPL() for input_ff_event() which is currently the only
> >>function in input-ff.c that is called from input.c
> >>4. Rename the input "module" to something else, it doesn't matter so
> >>much as almost everybody builds it as built-in anyway.
> >>
> >>WDYT is the best one?
> > 
> > 
> > I still don't know what problem you're trying to solve so I cannot say.
> 
> Maybe you know now.

yup, thanks.

I'd have thought that 3) is the path of least resistance.

But it does require that input.c "knows" that input-ff.c was included in
the build, which is not a thing we like to do.

Why should things in input.c call into input-ff.c, btw?  The way we
normally would handle that is to add a register_something() API to input.c
and input-ff.c would insert its callback via that interface.

