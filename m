Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTEAEm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTEAEm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:42:58 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:10416 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262307AbTEAEm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:42:57 -0400
Date: Wed, 30 Apr 2003 21:55:13 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 2 potential passing kernel-pointer into copy_*_user errors
In-Reply-To: <Pine.GSO.4.44.0304302131150.22117-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0304302151250.22257-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Below are 2 more warnings where kernel pointer is passed into *_do_ioctl
(these functions are passed into video_usercopy). Please note that our
checker flags the dereferences as errors, where the actually errors should
be the copy_*_user calls.

Thanks a lot!

-Junfeng

---------------------------------------------------------
[BUG] pass kernel pointer into copy_*_user. bug is in VIDIOCGTUNER. Should
not call copy_to_user on arg since arg is already in kernel space.

/home/junfeng/linux-2.5.63/drivers/media/radio/radio-cadet.c:397:cadet_do_ioctl:
ERROR:TAINTED:397:397: dereferencing tainted ptr 'v' [Callstack: ]

	{
		case VIDIOCGCAP:
		{
			struct video_capability *v = arg;
			memset(v,0,sizeof(*v));

Error --->
			v->type=VID_TYPE_TUNER;
			v->channels=2;
			v->audios=1;
			strcpy(v->name, "ADS Cadet");
---------------------------------------------------------
[BUG] pass kernel pointer into copy_*_user. should not call copy_to_user
on case VIDIOCGCHAN

/home/junfeng/linux-2.5.63/drivers/media/video/bw-qcam.c:763:qcam_do_ioctl:
ERROR:TAINTED:763:763: dereferencing tainted ptr 'p' [Callstack: ]

			return 0;
		}
		case VIDIOCGPICT:
		{
			struct video_picture *p = arg;

Error --->
			p->colour=0x8000;
			p->hue=0x8000;
			p->brightness=qcam->brightness<<8;
			p->contrast=qcam->contrast<<8;


