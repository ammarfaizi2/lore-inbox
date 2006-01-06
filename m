Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWAFXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWAFXVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWAFXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:21:23 -0500
Received: from xenotime.net ([66.160.160.81]:17336 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932645AbWAFXVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:21:22 -0500
Date: Fri, 6 Jan 2006 15:21:21 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?SGFucy1K/HJnZW4=?= Lange 
	<Hans-Juergen.Lange@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x on IBM thin client 8363
Message-Id: <20060106152121.18f2afe0.rdunlap@xenotime.net>
In-Reply-To: <43BE34BB.70309@gmx.de>
References: <43BD0E1C.9060705@gmx.de>
	<20060105191819.594767e0.rdunlap@xenotime.net>
	<43BE34BB.70309@gmx.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2006 10:13:31 +0100 Hans-Jürgen Lange wrote:

> Randy.Dunlap wrote:
> > On Thu, 05 Jan 2006 13:16:28 +0100 Hans-Jürgen Lange wrote:
> > 
> > 
> >>Hello,
> >>
> >>I would like to run a 2.6.x kernel on a IBM thin client 8363. There are 
> >>patches available for the 2.4 series of kernels.
> >>I had a look on these patches and the only thing they do is to expand 
> >>the kernel commandline size to 512 Bytes and a change in 
> >>arch/i386/kernel/head.S that changed the pointer to the commandline to a 
> >>fixed address.
> > 
> > 
> > Where are these 2.4 patches that you are referring to?
> >
> 
> O.K. this is the very important one. Because without it the 8363 wont start.

Sorry, I have no idea about this patch.
Where did you get these 2.4 patches?  are there others?

It looks a little like it may be dependent on your boot loader.
What boot loader are you using?


> --- linux/arch/i386/kernel/head.S.orig	Mon Jul 16 16:13:11 2001
> +++ linux/arch/i386/kernel/head.S	Mon Jul 16 16:14:26 2001
> @@ -158,7 +158,10 @@
>   	movl $512,%ecx
>   	rep
>   	stosl
> -	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi
> +/* NetVista */
> +/*	movl SYMBOL_NAME(empty_zero_page)+NEW_CL_POINTER,%esi */
> +	movl $0x98000, %esi
> +
>   	andl %esi,%esi
>   	jnz 2f			# New command line protocol
>   	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR


---
~Randy
