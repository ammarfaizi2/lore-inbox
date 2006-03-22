Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWCVP65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWCVP65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWCVP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:58:57 -0500
Received: from mail0.lsil.com ([147.145.40.20]:61433 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1751059AbWCVP64 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:58:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Question: where should the SCSI driver place MODE_SENSE data ?
Date: Wed, 22 Mar 2006 08:52:50 -0700
Message-ID: <9738BCBE884FDB42801FAD8A7769C26514211A@NAMAIL1.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question: where should the SCSI driver place MODE_SENSE data ?
Thread-Index: AcZNO2x1K75FYbB/SmuUJTie4pE1JAAi9Ylg
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "linux-scsi" <linux-scsi@vger.kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2006 15:58:48.0534 (UTC) FILETIME=[81A2E760:01C64DC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 21, 2006 6:02 PM, James Bottomley wrote:
> I don't understand the question.  Are you asking why
> sd_read_write_protect_flag and sd_read_cache_type operate in the way
> they do?  i.e. header first then actual data.
For any SCSI command including MODE_SENSE, 'bufflen'in scsi_cmnd structure holds actual data buffer size in bytes if 'use_sg' flage is NOT set.
The question is that "value of bufflen is 4 for the sd_read_cache_type operation and that is NOT sufficient to return header and page data by driver".
If there is something that I misunderstood with the operation, please guide.

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Tuesday, March 21, 2006 6:02 PM
> To: Ju, Seokmann
> Cc: linux-scsi; linux-kernel
> Subject: Re: Question: where should the SCSI driver place 
> MODE_SENSE data ?
> 
> On Tue, 2006-03-21 at 09:44 -0700, Ju, Seokmann wrote:
> > In the 2.6 (2.6.9 and scsi-misc in git) kernel, MODE_SENSE 
> SCSI command
> > packet (scsi_cmnd) carries following entries with 
> unexpectedly small in
> > size.
> > - request_bufflen
> > - bufflen
> > 
> > Especially for MODE SENSE with page code 8 (caching page), 
> driver has
> > minumum 12 Bytes MODE_SENSE data to deliver besides 'mode parameter
> > header' and 'block descriptors'.
> > When I dump those entries, they both are 4 Bytes in size.
> > To me, it seems like that SCSI mid layer allocated 512 Bytes for
> > MODE_SENSE data buffer, but the buffer length passed down to LLD
> > incorrectly.
> 
> I don't understand the question.  Are you asking why
> sd_read_write_protect_flag and sd_read_cache_type operate in the way
> they do?  i.e. header first then actual data.
> 
> James
> 
> 
> 
