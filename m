Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSBJNJQ>; Sun, 10 Feb 2002 08:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289597AbSBJNJH>; Sun, 10 Feb 2002 08:09:07 -0500
Received: from smtp01.web.de ([194.45.170.210]:54276 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S289598AbSBJNI4>;
	Sun, 10 Feb 2002 08:08:56 -0500
Date: Sun, 10 Feb 2002 14:19:18 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: "Alex Scheele" <alex@packetstorm.nu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch][2.5.4-dj4] cleanup to use strsep for fs/fat/inode.c
Message-Id: <20020210141918.3552d0fc.l.s.r@web.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> This patch changes all use of strtok() to strsep().
> Strtok() isn't SMP/thread safe. strsep is considered safer.

OK, but ...

> -       for (this_char = strtok(options,","); this_char;
> -            this_char = strtok(NULL,",")) {

This _does not_ change the value of 'options'.

> +       while ((this_char = strsep(&options,",")) != NULL) {

This _does_ change the value of 'options'. Problem is, it's
used later. Same is true for your patch to fs/vfat/namei.c.

René
