Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTBBNrL>; Sun, 2 Feb 2003 08:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTBBNrL>; Sun, 2 Feb 2003 08:47:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28559
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265255AbTBBNrL>; Sun, 2 Feb 2003 08:47:11 -0500
Subject: Re: Defect (Bug) Report
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030202133501.GA32041@arthur.ubicom.tudelft.nl>
References: <20030202011223.GC5432@morningstar.nowhere.lie>
	 <1044178961.16853.9.camel@irongate.swansea.linux.org.uk>
	 <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
	 <1044195694.16853.22.camel@irongate.swansea.linux.org.uk>
	 <20030202133501.GA32041@arthur.ubicom.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044197556.16853.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 02 Feb 2003 14:52:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-02 at 13:35, Erik Mouw wrote:
> I think I missed his patch, but a dirty trick I could think of would be
> to put a "reserved" entry in the e820 RAM map we got from the BIOS.

The problem is we can't detect AMD76x IDE and thus the prefetch into
I/O space bug until we've done memory setup. What probably should occur
is we grab the 636-640K page if it would otherwise be free, and then
free it after pci quirk handling.

Another approach would be to write a replacement ide_build_sglist for
the AMD76x which bounces the problem page.

