Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWEEUFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWEEUFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEEUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:05:50 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:62107 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751212AbWEEUFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:05:49 -0400
Subject: Re: megaraid_mbox: garbage in file
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Vasily Averin <vvs@sw.ru>
Cc: linux-scsi@vger.kernel.org, Neela.Kolli@engenio.com,
       Atul Mukker <Atul.Mukker@lsil.com>, Seokmann.Ju@lsil.com,
       sreenib@lsil.com, devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <445B96B9.20100@sw.ru>
References: <445A4C8F.5030204@sw.ru>
	 <1146783568.22932.105.camel@mulgrave.il.steeleye.com>
	 <445AE4A5.8070202@sw.ru>
	 <1146844763.9848.17.camel@mulgrave.il.steeleye.com>  <445B96B9.20100@sw.ru>
Content-Type: text/plain
Date: Fri, 05 May 2006 15:05:09 -0500
Message-Id: <1146859509.9848.110.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-05 at 22:17 +0400, Vasily Averin wrote:
>  megaraid mailbox: status:0x0 cmd:0xa7 id:0x25 sec:0x1a
>                  lba:0x33f624ac addr:0xffffffff ld:128 sg:4
>  scsi cmnd: 0x28 0x00 0x33 0xf6 0x24 0xac 0x00 0x00 0x1a 0x00
>  mbox request_buffer eafde340 use_sg 4
>  mbox sg0: page 077a0474 off 0 addr 1fd575000 len 4096 virt ff15a000
>                  first 03020100 page->flags 40020101
>  mbox sg1: page 077b5738 off 0 addr 1fdede000 len 4096 virt ff141000
>                  first 03020100 page->flags 40020101
>  mbox sg2: page 077ad500 off 0 addr 1fdb40000 len 4096 virt ff056000
>                  first 03020100 page->flags 40020101
>  mbox sg3: page 030d46e8 off 1024 addr 5e6a400 len 1024 virt 07e6a400
>                  first 03020100 page->flags 20001004

The odd thing about this is that the highmem addresses shouldn't have a
virtual mapping (since nothing should have called kmap on them).

But the other tickles a suspicion about the card.  I know various LSI
chips that don't have a true 64 bit mode, but instead have programmable
windowed mappings in their descriptors  (i.e. all SG list elements have
to be in the same xGB region of physical memory), and since the last
descriptor is more than 4GB away from the other three, whether this
might be the problem here.  Unfortunately, only LSI can tell us this ...

James


