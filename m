Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUDPMSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUDPMSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:18:55 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:64016 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262952AbUDPMSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:18:52 -0400
Date: Fri, 16 Apr 2004 13:18:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'jgarzik@pobox.com'" <jgarzik@pobox.com>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][RELEASE]: megaraid unified driver version 2.20.0.B1
Message-ID: <20040416131840.E5080@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	"'jgarzik@pobox.com'" <jgarzik@pobox.com>,
	"'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
	"'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
	"'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
	"'arjanv@redhat.com'" <arjanv@redhat.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E570230C7B4@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C7B4@exa-atlanta.se.lsil.com>; from sreenib@lsil.com on Wed, Apr 07, 2004 at 07:18:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kdep.h:
 - mraid_scsi_host_alloc/mraid_scsi_host_dealloc should go away, just
   define scsi_host_alloc/scsi_host_put wrappers for 2.4.
 - mraid_scsi_set_pdev should go away, it's not needed in 2.6 at all
   because scsi_add_host does all the work and for 2.4 just use
   scsi_set_pci_device directly.
 - all the SCP2FOO defines should go away, the 2.6 variants work for 2.4
   aswell
 - mraid_set_host_lock should go, just use scsi_assign_lock and define
   it for 2.4.

megaraid_clib.c:
  - why do you need the scb pool managment code at all?  You can dynamically
    allocate scbs in ->queuecommand
  - can you explain the need for all the mraid_pci_blk_pool?  I.e. why the
    generic dma pool routines don't work for megaraid

all files:
  - please avoid using scsi.h and hosts.h from drivers/scsi in favour of
    the include/scsi/ headers, especially get rid of all the Scsi_Foo
    typedefs
