Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVKBKzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKBKzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 05:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbVKBKzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 05:55:49 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:23225 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751574AbVKBKzs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 05:55:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aodeKxqnOfsRrePIG1jGzNO6VkFe9gm8tADIdd13huZrxYdDP+5S+v986o5sg+k+5CHiupyL9Eew1spTqzVMWz/5NdI9QtexOox4o/MNI1V7Fm1zHGfFOHzCYZELAcY7+pSMM/Jl0oNiNnF9mNyClQb02Td2iOkGT3RyniM0jCQ=
Message-ID: <4de7f8a60511020255h5c7bfb58s507798e9af93fa83@mail.gmail.com>
Date: Wed, 2 Nov 2005 11:55:46 +0100
From: Jan Blunck <jblunck@gmail.com>
Reply-To: j.blunck@tu-harburg.de
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Subject: Re: 2.6.9 VFS Issues
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4367F06B.2050209@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4367F06B.2050209@utah-nac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Jeff V. Merkey <jmerkey@utah-nac.org> wrote:
>
> I have noticed one change from 2.4 to 2.6 which although esoteric, is
> bothersome.  Did the dache assign static inode identities to
> the "." and ".." directories for 2.6 differnt than the behavior in 2.4?
> I notice that the root of ext based filesystems is now always "2"
> for the root (although readdir commands pass "0" during passes through
> the readdir function calls into the VFS).  I have noticed that
> the user space libs always fix "2" as the value of the inode for the
> root directory.  I am having trouble getting the . and .. entries to show
> up under 2.6, although, they seem to work just fine when you type cd ..
> and cd ., etc.
>
> Here's what dir.c outputs from user space for ext3 FS's:
>
> . type-4 len-16 ino-00000002 off-0000000C
> .. type-4 len-16 ino-00000002 off-00000018
> lost+found type-4 len-24 ino-0000000B off-0000002C
> grub type-4 len-16 ino-00000FC1 off-00000038
> initrd-2.6.5-1.358.img type-8 len-40 ino-0000001D off-00000058
> bzImage type-8 len-24 ino-00000010 off-00000078
> boot.b type-8 len-24 ino-00000011 off-00000088
> chain.b type-8 len-24 ino-0000000E off-00000098
> os2_d.b type-8 len-24 ino-0000000F off-000000A8
> vmlinuz-2.6.9 type-8 len-32 ino-00000012 off-00000150
> kernel.h type-8 len-24 ino-00000019 off-000001FC
> System.map-2.6.5-1.358 type-8 len-40 ino-0000000C off-0000021C
> config-2.6.5-1.358 type-8 len-32 ino-0000000D off-00000238
> vmlinuz-2.6.5-1.358 type-8 len-32 ino-0000001C off-00000400
>

As defined in include/linux/ext3_fs.h:

/*
 * Special inodes numbers
 */
#define EXT3_ROOT_INO            2      /* Root inode */

Cheers,
Jan
