Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315580AbSEWBjT>; Wed, 22 May 2002 21:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSEWBjS>; Wed, 22 May 2002 21:39:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1035 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315580AbSEWBjR>; Wed, 22 May 2002 21:39:17 -0400
Subject: Re: [PATCH] 2.5.17 /dev/port
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 23 May 2002 02:59:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ach9pk$ced$1@cesium.transmeta.com> from "H. Peter Anvin" at May 22, 2002 04:32:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Aht7-0003LH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On non-Intel platforms, with no dedicated IOIO opcodes, IOIO is
> usually implemented as a specific memory range.  In that case, the
> only way to allow user-space access to it would be to mmap() that
> range... which means iopl() inb() and outb() on those platforms might
> be implemented either as open, readp and writep, respectively, or by
> iopl() being open() followed by mmap().

mmap and some other logic in certain cases. An outb stalls until the I/O
hits the device even on PCI.  Either way thats really about what you
put into /dev/port (either the i/o logic or a map of /dev/mem with slightly
tweaked args)
