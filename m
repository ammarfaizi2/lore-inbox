Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310360AbSCGOr5>; Thu, 7 Mar 2002 09:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310356AbSCGOrr>; Thu, 7 Mar 2002 09:47:47 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:26509 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S310170AbSCGOrd>;
	Thu, 7 Mar 2002 09:47:33 -0500
Subject: Re: [patch] delayed disk block allocation
From: Steve Lord <lord@sgi.com>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020307120609.85742.qmail@web11804.mail.yahoo.com>
In-Reply-To: <20020307120609.85742.qmail@web11804.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 08:47:24 -0600
Message-Id: <1015512444.1293.14.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-07 at 06:06, Etienne Lorrain wrote:
> > With "allocate on flush", (aka delayed allocation), file data is
> > assigned a disk mapping when the data is being written out, rather than
> > at write(2) time.  This has the following advantages:
> 
>   I do agree that this is a better solution than current one,
>  but (even if I did not had time to test the patch), I have
>  a question: How about bootloaders?
> 
>  IHMO all current bootloaders need to write to disk a "chain" of sector
>  to load for their own initialisation, i.e. loading the remainning
>  part of code stored on a file in one filesystem from the 512 bytes
>  bootcode. This "chain" of sector can only be known once the file
>  has been allocated to disk - and it has to be written on the same file,
>  at its allocated space.
> 
>   So can you upgrade LILO or GRUB with your patch installed?
>   It is not a so big problem (the solution being to install the
>  bootloader on an unmounted filesystem with tools like e2fsprogs),
>  but it seems incompatible with the current executables.

The interface used by lilo to read the kernel location needs to flush
data out to disk before returning results. It's not too hard to do.

Steve


