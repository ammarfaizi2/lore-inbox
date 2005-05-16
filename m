Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVEPOSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVEPOSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEPOSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:18:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12716 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261659AbVEPOS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:18:28 -0400
Subject: Re: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
In-Reply-To: <1116230776.6274.20.camel@laptopd505.fenrus.org>
References: <0E3FA95632D6D047BA649F95DAB60E57060CCE7C@exa-atlanta>
	 <1116230776.6274.20.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 16 May 2005 09:18:03 -0500
Message-Id: <1116253084.5040.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 10:06 +0200, Arjan van de Ven wrote:
> > +			spin_lock( instance->host_lock );
> > +			cmd->scmd->scsi_done( cmd->scmd );
> > +			spin_unlock( instance->host_lock );
> 
> are you really sure you don't want to use spin_lock_irqsave() here ?

Actually, don't bother with the lock at all.  scsi_done() is designed to
be called locklessly.

James


