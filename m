Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbTAHNVK>; Wed, 8 Jan 2003 08:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTAHNVK>; Wed, 8 Jan 2003 08:21:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58505
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267413AbTAHNVJ>; Wed, 8 Jan 2003 08:21:09 -0500
Subject: Re: Fwd: File system corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: krushka@iprimus.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
In-Reply-To: <03010821353200.01198@paul.home.com.au>
References: <0301062138130A.01466@paul.home.com.au>
	 <1041865580.17472.17.camel@irongate.swansea.linux.org.uk>
	 <20030107130832.A4953@bitwizard.nl> <03010821353200.01198@paul.home.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042035305.24099.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 14:15:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 11:35, Paul wrote:
> What I have found is that just after the start of a sector, usually 43 to 45 
> bytes, 6 bytes are skipped and the sequence starts again.  This continues 
> until the next sector starts, where the sequence corrects.  This appears to 
> happen every 65536 bytes or some multiple of 65536.  It may skip three blocks 
> of 65536 and then corrupt on the next block of 65536 bytes.

Ok that I'm afraid bears no resemblance to anything the software side
does (we write in chunks but we do single PIO block transfers of each
sector). 

> I would greatly appreciate some other ideas to try, I'm not game to start 
> hacking the kernel code quite yet :)

Two things

1.  Tweak the code to write 1K, fsync, write 1K fsync
2.  Repeat the above in 512 byte chunks.

That tests the way the device responds to writes. You can then try different
bigger sizes. If the 512 byte one corrupts and the 1K one doesn't that is
the only thing I can think of that would fit the pattern

