Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130984AbRAEQDg>; Fri, 5 Jan 2001 11:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131859AbRAEQD0>; Fri, 5 Jan 2001 11:03:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12550 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130984AbRAEQDS>; Fri, 5 Jan 2001 11:03:18 -0500
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
To: bmayland@leoninedev.com (Bryan Mayland)
Date: Fri, 5 Jan 2001 16:05:11 +0000 (GMT)
Cc: kraxel@goldbach.in-berlin.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <3A55EE29.EBE9D348@leoninedev.com> from "Bryan Mayland" at Jan 05, 2001 10:54:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EZMf-0007vp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1)  The amount of video memory is being incorrectly reported my the VESA call
> used in arch/i386/video.S (INT 10h AX=4f00h).  My Dell Inspiron 3200 (NeoMagic
> video) returns that it has 31 64k blocks of video memory, instead of the
> correct 32.  This means that vesafb thinks that I've got 1984k of video ram,

You have 31. The last one is used for audio buffering

> 2)  When the vesafb goes to mtrr_add its range (with the incorrect 1984k size)
> mtrr_add fails with -EINVAL.  The code in vesafb_init then goes into a while
> loop with no exit, as each size mtrr fails.
>                  while (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB,
> 1)==-EINVAL) {
>                          temp_size >>= 1;
>                  }

Ok that one is the bug.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
