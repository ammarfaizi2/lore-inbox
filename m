Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318942AbSHUTFB>; Wed, 21 Aug 2002 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSHUTFB>; Wed, 21 Aug 2002 15:05:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16368 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318942AbSHUTFA>; Wed, 21 Aug 2002 15:05:00 -0400
Subject: Re: PROBLEM: kernel BUG in buffer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D63E0E8.1080202@POGGS.CO.UK>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 20:10:01 +0100
Message-Id: <1029957001.26845.120.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 19:50, Peter Hicks wrote:
> Hi everyone
> 
> I've come across a BUG() in buffer.c, line 2497. I'm running 2.4.19 on a 
> Pentium III, with no other problems. I'd finished making a backup of an 
> IRIX installation CD, was mounting the freshly burnt CD, and was greeted 
> with a hung 'mount' and the following in dmesg:

Well its definitely a kernel bug. We should never crash given a bad CD.
In this case I think the problem is a little deeper. Our efs code
doesn't appear to consider and error the case when its block size is 
below 2048 bytes.

An EFS block is 512 bytes so we tell a 2K sectored device to use 512byte
sectors. At this point the kernel rightfully realises that something
deeply wrong is happening and aborted.

I believe the fix is as follows

	Make EFS check its not asking for stupid block sizes
	
You can then use a loopback mount to buffer the device and mount the CD
that way. I'll fix the EFS code tomorrow

