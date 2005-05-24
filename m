Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVEXUp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVEXUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVEXUp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:45:56 -0400
Received: from magic.adaptec.com ([216.52.22.17]:18612 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261392AbVEXUpL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:45:11 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Date: Tue, 24 May 2005 16:45:05 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B01399B22@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.12-rc4-mm1 3/4] megaraid_sas: updating the driver
Thread-Index: AcVaI7buUXFwsud3RM2sZH+FXr8cUAGeOYFw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <Matt_Domsch@Dell.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley writes:
> On Mon, 2005-05-16 at 10:06 +0200, Arjan van de Ven wrote:
>> > +			spin_lock( instance->host_lock );
>> > +			cmd->scmd->scsi_done( cmd->scmd );
>> > +			spin_unlock( instance->host_lock );
>> 
>> are you really sure you don't want to use spin_lock_irqsave() here ?
>
>Actually, don't bother with the lock at all.  scsi_done() is designed
to
>be called locklessly.

Could I get an historical (2.4 & Distribution) perspective on this. At
which point, or what code/include/manifest/version delineating it, would
you say the driver is no longer, if ever, required to place a lock
(host_lock or io_request_lock) around the scsi_done call?

I expect (or hope) the answer to be: always needs io_request_lock in
2.4, never needed the host_lock in 2.5+.

-- Mark Salyzyn
