Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRHYPT1>; Sat, 25 Aug 2001 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHYPTS>; Sat, 25 Aug 2001 11:19:18 -0400
Received: from fungus.teststation.com ([212.32.186.211]:17672 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269412AbRHYPTC>; Sat, 25 Aug 2001 11:19:02 -0400
Date: Sat, 25 Aug 2001 17:19:06 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: smbmount problems
In-Reply-To: <17711481589.20010825175224@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10108251659580.13314-100000@ada.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, VDA wrote:

> Fixed smbmount problems by carefully reinstalling kernel and samba.

That's nice.

> The only thing left is this:
> mount -t smbfs -o noexec //server/e /mnt
> does not honor noexec! All files appear rwxr-xr-x.

smbmount does not understand all flags that mount understands (including
options that mount considers standard). To change permissions you need to
set them with the fmask/dmask options.

smbmount should understand noexec and pass it to the mount syscall as
MS_NOEXEC. But it doesn't, and that's a bug.

Note that noexec does not affect the permissions, it simply makes it
impossible to actually execute things. The files can still have execute
permissions.

/Urban

