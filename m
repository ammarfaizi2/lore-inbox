Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264873AbSKJODg>; Sun, 10 Nov 2002 09:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbSKJODf>; Sun, 10 Nov 2002 09:03:35 -0500
Received: from maile.telia.com ([194.22.190.16]:16351 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S264873AbSKJODe>;
	Sun, 10 Nov 2002 09:03:34 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Marcelo Tosatti <marcelo@conectiva.com.br>, hch@lst.de
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5
References: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Nov 2002 15:10:12 +0100
In-Reply-To: <Pine.LNX.4.44.0208281946150.5234-100000@freak.distro.conectiva>
Message-ID: <m23cq9ikhn.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> <hch@lst.de>:
>   o update drm to XFree 4.2 version

This patch removes two lines from drm_vm.h that are not removed in the
XFree 4.2 tree. It looks like a merge error to me. Here is a patch for
2.4.20-rc1 to restore the missing lines.

--- linux/drivers/char/drm/drm_vm.h~	Tue Oct 29 19:01:06 2002
+++ linux/drivers/char/drm/drm_vm.h	Sun Nov 10 15:06:45 2002
@@ -471,10 +471,12 @@
 		vma->vm_private_data = (void *)map;
 				/* Don't let this area swap.  Change when
 				   DRM_KERNEL advisory is supported. */
+		vma->vm_flags |= VM_RESERVED;
 		break;
 	case _DRM_SCATTER_GATHER:
 		vma->vm_ops = &DRM(vm_sg_ops);
 		vma->vm_private_data = (void *)map;
+		vma->vm_flags |= VM_RESERVED;
                 break;
 	default:
 		return -EINVAL;	/* This should never happen. */

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
