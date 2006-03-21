Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWCUQo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWCUQo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWCUQo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:44:56 -0500
Received: from mail0.lsil.com ([147.145.40.20]:58607 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751031AbWCUQoy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:44:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Question: where should the SCSI driver place MODE_SENSE data ?
Date: Tue, 21 Mar 2006 09:44:39 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C265142114@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: where should the SCSI driver place MODE_SENSE data ?
Thread-Index: AcZNBr6cl1yEfATYTrSEnWrpGxVUcw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "linux-scsi" <linux-scsi@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Mar 2006 16:44:39.0567 (UTC) FILETIME=[BEF779F0:01C64D06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.6 (2.6.9 and scsi-misc in git) kernel, MODE_SENSE SCSI command
packet (scsi_cmnd) carries following entries with unexpectedly small in
size.
- request_bufflen
- bufflen

Especially for MODE SENSE with page code 8 (caching page), driver has
minumum 12 Bytes MODE_SENSE data to deliver besides 'mode parameter
header' and 'block descriptors'.
When I dump those entries, they both are 4 Bytes in size.
To me, it seems like that SCSI mid layer allocated 512 Bytes for
MODE_SENSE data buffer, but the buffer length passed down to LLD
incorrectly.

Please guide me if there is anything missing.

Thank you,

Seokmann
