Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSCOTfp>; Fri, 15 Mar 2002 14:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCOTff>; Fri, 15 Mar 2002 14:35:35 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:3076 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S293201AbSCOTfW>; Fri, 15 Mar 2002 14:35:22 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 15 Mar 2002 20:30:40 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.4] videodev.c oopses in video_exclusive_register
Message-ID: <20020315203040.A8518@bytesex.org>
In-Reply-To: <20020315110607.GG13625@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315110607.GG13625@come.alcove-fr>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The recent videodev.c backport doesn't initialise the 'lock' mutex
> which is used in video_exclusive_register.

Oops, good spotting.  While checking the 2.5 / 2.4 diff (again ...)
I've noticed I also forgot to delete the old, now unused mutex.
Patch below.

  Gerd

==============================[ cut here ]==============================
--- 2.4.19-pre3/drivers/media/video/videodev.c.fix	Fri Mar 15 20:03:33 2002
+++ 2.4.19-pre3/drivers/media/video/videodev.c	Fri Mar 15 20:04:43 2002
@@ -536,8 +536,6 @@
  *	%VFL_TYPE_RADIO - A radio card	
  */
 
-static DECLARE_MUTEX(videodev_register_lock);
-
 int video_register_device(struct video_device *vfd, int type, int nr)
 {
 	int i=0;
