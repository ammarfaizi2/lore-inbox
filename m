Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJNWiS>; Mon, 14 Oct 2002 18:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJNWiS>; Mon, 14 Oct 2002 18:38:18 -0400
Received: from gate.perex.cz ([194.212.165.105]:1294 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262215AbSJNWiR>;
	Mon, 14 Oct 2002 18:38:17 -0400
Date: Tue, 15 Oct 2002 00:43:53 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: "David S. Miller" <davem@redhat.com>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA update
In-Reply-To: <20021014.125829.01014301.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0210150013540.503-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, David S. Miller wrote:

> This breaks the build on sparc64:
> 
> sound/core/ioctl32/ioctl32.h:95: parse error before `if'
> sound/core/ioctl32/ioctl32.h:99: parse error before `sizeof'

Oops. Missing two backslashes. It should be corrected with this patch 
(already in linux-sound BK repository):

Index: ioctl32.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/ioctl32/ioctl32.h,v
retrieving revision 1.9
retrieving revision 1.10
diff -u -r1.9 -r1.10
--- ioctl32.h	12 Oct 2002 14:18:09 -0000	1.9
+++ ioctl32.h	14 Oct 2002 22:28:27 -0000	1.10
@@ -91,11 +91,11 @@
 	if (data32 == NULL || data == NULL) { \
 		err = -ENOMEM; \
 		goto __end; \
-	}
+	}\
 	if (copy_from_user(data32, (void*)arg, sizeof(*data32))) { \
 		err = -EFAULT; \
 		goto __end; \
-	}
+	}\
 	memset(data, 0, sizeof(*data));\
 	convert_from_32(type, data, data32);\
 	oldseg = get_fs();\

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



