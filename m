Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVHUUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVHUUnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 16:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVHUUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 16:43:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63685 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751093AbVHUUn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 16:43:27 -0400
Message-ID: <20050821204020.80730.qmail@web51612.mail.yahoo.com>
X-RocketYMMF: ltuikov
Date: Sun, 21 Aug 2005 13:40:20 -0700 (PDT)
From: Luben Tuikov <luben_tuikov@adaptec.com>
Reply-To: luben_tuikov@adaptec.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
To: James Bottomley <James.Bottomley@SteelEye.com>, luben_tuikov@adaptec.com
Cc: Andrew Morton <akpm@osdl.org>, Jim Houston <jim.houston@ccur.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Luben Tuikov <luben_tuikov@adaptec.com> wrote:
> --- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > However, there is an infrastructure in the block layer called the
> > generic tag infrastructure which was designed precisely for this purpose
> > and which is designed to operate in IRQ context.
> 
> James, I'm sure you're well aware that,
>    - a request_queue is LU-bound,
>    - a SCSI _transport_ (*ANY*) can _only_ address domain devices, but
>      _not_ LUs.  LUs are *not* seen on the domain.

Another thing very important to mention is that the layering
infrastructure should _not_ be broken, whereby LLDD are required
to use block layer tags.

First, there may not be one to one correspondence accross layers.

Second, a tag on a layer identifies that particular _layer_ object.
It should not be used across layers or across several layers:
Block->Scsi Core->LLDD.

Third, although SCSI task tags are a SAM concept, they are defined
by the protocol in use and generated and assigned by the Initiator
port.  The block layer is _not_ an Initiator port.  SCSI Core is
also _not_ an Initiator port.

SCSI Core should be impervious to task tags, i.e. to the Q in
I_T_L_Q nexus.  The Q is never visible to it.

      Luben

