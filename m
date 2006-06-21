Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWFUQpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWFUQpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWFUQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:45:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16018 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932259AbWFUQpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:45:09 -0400
Message-ID: <4499777C.7010505@zytor.com>
Date: Wed, 21 Jun 2006 09:44:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm1
References: <20060621034857.35cfe36f.akpm@osdl.org>	 <6bffcb0e0606210407y781b3d41nef533847f579520b@mail.gmail.com>	 <20060621041758.4235dbc6.akpm@osdl.org> <6bffcb0e0606210429t3e78e88dqd637718e4e22b3f0@mail.gmail.com> <44994F77.5030301@fr.ibm.com>
In-Reply-To: <44994F77.5030301@fr.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020500060409070403050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020500060409070403050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cedric Le Goater wrote:
> Michal Piotrowski wrote:
> 
>>>> usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file
>>>> or directory
>>> That one's probably just a parallel kbuild race.  Type `make' again.
>>>
>> "make O=/dir" is culprit.
>>
>> Regards,
>> Michal
>>
> 
> That's how i fixed it. Is that the right way to do it ?
> 

Probably not.  I suspect what's needed is the same EXTRA_KLIBCCFLAGS as 
in socketcalls/Kbuild.

	-hpa

--------------020500060409070403050805
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --git a/usr/klibc/syscalls/Kbuild b/usr/klibc/syscalls/Kbuild
index debcd16..e7ae1d2 100644
--- a/usr/klibc/syscalls/Kbuild
+++ b/usr/klibc/syscalls/Kbuild
@@ -28,6 +28,8 @@ clean-files += $(KLIBCINC)/klibc/havesys
 # All the syscall stubs
 clean-files += *.o *.S *.c *.list *.bin
 
+EXTRA_KLIBCCFLAGS := -I$(srctree)/$(src)
+
 quiet_cmd_makelist = LIST    $@
       cmd_makelist = echo '$(filter-out FORCE,$^)' > $@
 

--------------020500060409070403050805--
