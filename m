Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVCUX3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVCUX3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVCUX3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:29:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:26842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262180AbVCUX12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:27:28 -0500
Date: Mon, 21 Mar 2005 15:27:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Moore, Eric Dean" <emoore@lsil.com>
Subject: Re: Fusion-MPT much faster as module
Message-Id: <20050321152723.4b86dc3a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503081327560.28812@praktifix.dwd.de>
References: <Pine.LNX.4.61.0503081327560.28812@praktifix.dwd.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl <Holger.Kiehl@dwd.de> wrote:
>
> Hello
> 
> On a four CPU Opteron compiling the Fusion-MPT as module gives much better
> performance when compiling it in, here some bonnie++ results:
> 
> Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
>                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> compiled in  15872M 38366 71  65602  22 18348   4 53276 84  57947   7 905.4   2
> module       15872M 51246 96 204914  70 57236  14 59779 96 264171  33 923.0   2
> 
> This happens with 2.6.10, 2.6.11 and 2.6.11-bk2. Controller is a
> Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI.
> 
> Why is there such a large difference?
> 

Holger, this problem remains unresolved, does it not?  Have you done any
more experimentation?

I must say that something funny seems to be happening here.  I have two
MPT-based Dell machines, neither of which is using a modular driver:


akpm:/usr/src/25> 0 hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  5.00 seconds = 12.80 MB/sec

That's a bit disappointing.  Running 2.6.9-rc2-mm2(!) with a

 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)

controller on disks which shudl hit 50MB/sec.




And

bix:/home/akpm# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  114 MB in  3.03 seconds =  37.57 MB/sec

with 2.6.11-rc4-mm1 using

Fusion MPT SCSI Host driver 3.01.16
scsi0 : ioc0: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=222, IRQ=25
scsi1 : ioc1: LSI53C1030, FwRev=01030600h, Ports=1, MaxQ=222, IRQ=26
Vendor: SEAGATE   Model: ST3146807LW       Rev: DS09
Type:   Direct-Access                      ANSI SCSI revision: 03

Better, but again I'd expect >50MB/sec.
