Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWCMNYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWCMNYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWCMNYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:24:46 -0500
Received: from smtpauth00.csee.siteprotect.com ([64.41.126.131]:43179 "EHLO
	smtpauth00.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S1751054AbWCMNYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:24:45 -0500
From: "swapnil " <swapnil@spsoftindia.com>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Problem applying Patch to linux 2.6 kernel
Date: Mon, 13 Mar 2006 18:56:38 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Thread-Index: AcZGocHACzL89oKbROq2a13Oj9LDjw==
Message-Id: <20060313132439.9866A32C033@smtpauth00.csee.siteprotect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

Thanks for your quick reply.

I have followed the steps suggested by you as follows:

I have change into the kernel source directory:

[root@lustdevp 2.6.11-1.1369_FC4-i686]# pwd
/usr/src/kernels/2.6.11-1.1369_FC4-i686

My kernel patches are stored in /usr/src/kernels directory.

Now I apply the patch as follows:

[root@lustdevp 2.6.11-1.1369_FC4-i686]# patch -p1 < ../patch-2.6.12

But still I am getting the following error:

can't find file to patch at input line 4 Perhaps you used the wrong -p or
--strip option?
The text leading up to this was:
--------------------------
|diff --git a/CREDITS b/CREDITS
|--- a/CREDITS
|+++ b/CREDITS
--------------------------
File to patch:

Please suggest me to solve this patching problem.


-----Original Message-----
From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
Sent: Monday, March 13, 2006 4:32 PM
To: swapnil
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem applying Patch to linux 2.6 kernel

On 3/13/06, swapnil <swapnil@spsoftindia.com> wrote:
>
> hello,
> I am trying to apply the patch to linux 2.6 kernel on linux fedora core 4.
>
> As per Kernel-HOWTO I should do the following:
> i have downloaded the patch "patch-2.6.15.bz2" from www.linuxhq.com 
> site ,kept that patch in /usr/src.
> Changed dir using cd /usr/src and did a
> bzip2 -dc patch-2.6.15.bz2 | patch -p0.
>
> I followed the instructions mentioned, the following happens:
>
> # bzip2 -dc patch-2.6.15 | patch -p0
> can not find file to patch at input line 5 Perhaps you used the wrong 
> -p or

change into the dir holding the actual kernel source - like
~/download/linux-2.6.14/ or wherever you store your kernel source, then
apply the patch with  patch -p1

> --strip option?
> The text leading up to this was:
> --------------------------
> |diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87 
> |index

As you can see from the path, the diff was generated between two dirs named
"a" and "b", since your kernel is not stored in a dir called "b"
-p0 won't work, instead change into the root of the source dir and tell
patch to strip the first dir with -p1.

>
> What steps I am doing wrong while applying the kernel patch?
> Please let me know how can apply the above mentioned patch to mykernel...
> and why I am getting the above mentioned error message...
>
> My current kernel version is 2.6.11-1.1369_FC4 and I am trying to 
> apply
> 2.6.15 kernel patch.
> Is it necessary to apply patches such as 2.6.12,2.6.13,2.6.14 in-order 
> before I will have to apply 2.6.15 kernel patch or should I apply 
> 2.6.15 kernel patch directly without applying intermediate patches?
>
1) the 2.6.15 patch applies to 2.6.14, *not* to 2.6.11, to go from
2.6.11 to 2.6.15 you need to first apply the 2.6.12 patch, then the
2.6.13 patch, then 2.6.14 and finally 2.6.15.

2) don't apply patches for the vanilla kernel to vendor supplied kernel
sources. Vendors, such as RedHat, usually patch the vanilla kernel with
patches of their own, so the vanilla patches will no longer apply.
Either use vanilla kernels or vendor kernels - don't mix.

>
> Please suggest me to solve this patching problem.
>
It's documented in the kernel source :
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

