Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318897AbSIIXCe>; Mon, 9 Sep 2002 19:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318907AbSIIXCe>; Mon, 9 Sep 2002 19:02:34 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:753 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318897AbSIIXCd>; Mon, 9 Sep 2002 19:02:33 -0400
Subject: RE: Calculating kernel logical address ..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: imran.badr@cavium.com
Cc: root@chaos.analogic.com, "'David S. Miller'" <davem@redhat.com>,
       phillips@arcor.de, linux-kernel@vger.kernel.org
In-Reply-To: <01b901c25853$8a0f65f0$9e10a8c0@IMRANPC>
References: <01b901c25853$8a0f65f0$9e10a8c0@IMRANPC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 10 Sep 2002 00:09:53 +0100
Message-Id: <1031612993.31549.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 23:52, Imran Badr wrote:
> 
> But the buffer which I am concerned about was allocated my kmalloc() and
> mapped to the process space in mmap(). AFAIK, kmalloc'ed buffers are
> guaranteed to be mapped.

In which case its all nice and easy. You can safely use virt_to_bus on
the buffer in question (although for 2.5 you will need to use the pci
api). There is a nice clean worked example in each of the pci sound
drivers. Basically it goes

	addr = kmalloc(blah)
	phys_addr = virt_to_bus(addr)

and then use

	remap_page_range(vma->vm_start, phys_addr, size, vma->vm_page_prot)

in the mmap function

