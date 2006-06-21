Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWFUNyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWFUNyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWFUNyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:54:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40877 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbWFUNyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:54:06 -0400
Message-ID: <44994F77.5030301@fr.ibm.com>
Date: Wed, 21 Jun 2006 15:53:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org>	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>	 <20060621041758.4235dbc6.akpm@osdl.org> <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com>
In-Reply-To: <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------020904090103020806060503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904090103020806060503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michal Piotrowski wrote:

>> > usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
>> > or directory
>>
>> That one's probably just a parallel kbuild race.  Type `make' again.
>>
> 
> "make O=/dir" is culprit.
> 
> Regards,
> Michal
> 

That's how i fixed it. Is that the right way to do it ?

Thanks,

C.


--------------020904090103020806060503
Content-Type: text/x-patch;
 name="klibc-fix-kbuild-output-issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="klibc-fix-kbuild-output-issue.patch"

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: [KLIBC] fix compile issue when KBUILD_OUTPUT is used

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 scripts/Kbuild.klibc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.17-mm1/scripts/Kbuild.klibc
===================================================================
--- 2.6.17-mm1.orig/scripts/Kbuild.klibc
+++ 2.6.17-mm1/scripts/Kbuild.klibc
@@ -85,7 +85,7 @@ KLIBCCPPFLAGS    := -I$(KLIBCINC)/arch/$
 # kernel include paths
 KLIBCKERNELSRC	 ?= $(srctree)/
 KLIBCCPPFLAGS    += -I$(KLIBCKERNELSRC)include		\
-                     $(if $(KBUILD_SRC),-I$(KLIBCKERNELOBJ)include2 -I$(KLIBCKERNELOBJ)include -I$(srctree)/include)    \
+                     $(if $(KBUILD_SRC),-I$(KLIBCKERNELOBJ)include2 -I$(KLIBCKERNELOBJ)include -I$(srctree)/include -I$(srctree)/usr/klibc/syscalls)    \
 		     $(KLIBCARCHINCFLAGS)
 
 # klibc definitions

--------------020904090103020806060503--
