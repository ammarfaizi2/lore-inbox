Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285035AbRLFH5Q>; Thu, 6 Dec 2001 02:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285041AbRLFH5G>; Thu, 6 Dec 2001 02:57:06 -0500
Received: from [195.66.192.167] ([195.66.192.167]:23556 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285035AbRLFH5C>; Thu, 6 Dec 2001 02:57:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
        "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: processes in uninteruptible state unkillable
Date: Thu, 6 Dec 2001 09:54:59 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <1007568949.7891.0.camel@ara>
In-Reply-To: <1007568949.7891.0.camel@ara>
MIME-Version: 1.0
Message-Id: <01120609545901.01020@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 December 2001 14:15, Juergen Sawinski wrote:
> I have a few processes that were started in a smb mount directory. Due
> to server reboot the connection broke. The processes are now in an
> uninterruptable state, waiting for IO, so, they cannot be killed nor the
> smbfs unmounted.
>
> Obviously, the only thing I can do is to reboot my computer.
> Any suggestions?

Well, technically speaking it's a bug, but this kind of bug
is not going to be fixed. Why?

Imagine that a page from text segment of one of those apps was discarded
due to VM pressure, and now it is needed again. Kernel tries to read it back
from SMB mounted fs which is no longer there. What kernel can do?
It can't signal app (what if signal handler isn't in RAM too?),
it can only kill this process. But the code to do it is not implemented.
(AFAIK. I may be wrong). Kernel is just not prepared for swap or text pages 
to become suddenly unavailable. It is hard to handle that too given VM 
complexity.

Typically swap is on a local hard disk and apps are started from there too 
and it is not expected to fail, so nobody seriously care.

Even NFS folks made hard,nointr mount options the default, which means you'll 
never ever will be able to kill your app if server crashed and not rebooted.
To this day I have no explanation why hard,intr isn't a default (it allows me 
to kill processes hung in NFS read()/write() syscall).
--
vda
