Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288975AbSANTPW>; Mon, 14 Jan 2002 14:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSANTN6>; Mon, 14 Jan 2002 14:13:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288801AbSANTMe>; Mon, 14 Jan 2002 14:12:34 -0500
Subject: Re: Hardwired drivers are going away?
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 14 Jan 2002 19:24:17 +0000 (GMT)
Cc: esr@thyrsus.com (Eric S. Raymond), alan@lxorguk.ukuu.org.uk (Alan Cox),
        babydr@baby-dragons.com (Mr. James W. Laferriere),
        cate@debian.org (Giacomo Catenazzi),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.GSO.4.21.0201141337580.224-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 14, 2002 02:09:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCiP-0002cc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	a) on some architecures modular code is slower (IIRC, the problem is
> with medium-range calls being faster than far ones and usable only in the
> kernel proper).  We probaly want to leave a gap after the .text and remap

Also with TLB mapping sizes (4Mb versus 4K)

> .text of module in there - if I understand the problem that should be
> enough, but that's really a question to folks dealing with these ports (PPC64
> and Itanic?)

For x86 you just need to leave a nice chunk of physical memory that is there
to copy the module text/data into as you insmod them during boot then give
the rest of the pool back to the paging system. This also solves the problem
with "can't be a module because I need 1Mb of linear space" drivers.

Alan
