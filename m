Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTALV5j>; Sun, 12 Jan 2003 16:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTALV5j>; Sun, 12 Jan 2003 16:57:39 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:51337 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267544AbTALV5h> convert rfc822-to-8bit; Sun, 12 Jan 2003 16:57:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net, Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: any chance of 2.6.0-test*?
Date: Sun, 12 Jan 2003 23:06:14 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301122306.14411.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've only compiled (and haven't tested this code), but it should be much
> faster than the original code.  Why?  Because we're eliminating an extra
> "jump" in several places in the code every time open would be called.
> Yes, it's more code, so the kernel is a little bigger, but it should be
> faster at the same time, and memory should be less of an issue nowadays.
>
> Here's the patch if you want to apply it (i have only compile tested it,
> I haven't booted with it).. This patch applied to the 2.5.56 kernel.
>
> --- open.c.orig	2003-01-12 16:17:01.000000000 -0500
> +++ open.c	2003-01-12 16:22:32.000000000 -0500
> @@ -100,44 +100,58 @@
>
>  	error = -EINVAL;
>  	if (length < 0)	/* sorry, but loff_t says... */
> -		goto out;
> +		return error;

Please don't do such things. The next time locking is changed and a lock
is needed here, some poor guy has to go through that and change all
back to goto.
This may not be applicable here, but as a general rule, don't do it.
I speak from experience.

As for efficiency, that is the compiler's job.

	Regards
		Oliver

