Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDPTNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDPTNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:13:21 -0400
Received: from mail0.lsil.com ([147.145.40.20]:30142 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261631AbUDPTNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:13:17 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC53D@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'jgarzik@pobox.com'" <jgarzik@pobox.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B
	1
Date: Fri, 16 Apr 2004 15:12:37 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kdep.h:
>  - mraid_scsi_host_alloc/mraid_scsi_host_dealloc should go away, just
>    define scsi_host_alloc/scsi_host_put wrappers for 2.4.
>  - mraid_scsi_set_pdev should go away, it's not needed in 2.6 at all
>    because scsi_add_host does all the work and for 2.4 just use
>    scsi_set_pci_device directly.
>  - all the SCP2FOO defines should go away, the 2.6 variants 
> work for 2.4
>    aswell
>  - mraid_set_host_lock should go, just use scsi_assign_lock and define
>    it for 2.4.
All of these taken and will be incorporated in B3, but not in B2 going out
today

> 
> megaraid_clib.c:
>   - why do you need the scb pool managment code at all?  You 
> can dynamically
>     allocate scbs in ->queuecommand
Will do. Please see the follow up question below

>   - can you explain the need for all the mraid_pci_blk_pool?  
> I.e. why the
>     generic dma pool routines don't work for megaraid
We did not want to use pci_alloc_consistent because it would give one page
even if we need 16 bytes (and we need a lot of these). Also, the
pci_poo_create and pci_pool_alloc would fail on some setups - maybe because
the driver requires lots of small chunks of DMAable buffers. So we decided
to write wrapper functions over pci_alloc_consistent..

> 
> all files:
>   - please avoid using scsi.h and hosts.h from drivers/scsi 
> in favour of
>     the include/scsi/ headers, especially get rid of all the Scsi_Foo
>     typedefs
ok
