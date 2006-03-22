Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWCVQOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWCVQOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCVQOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:14:42 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:48331 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751348AbWCVQOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:14:41 -0500
Subject: RE: Question: where should the SCSI driver place MODE_SENSE data ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C26514211A@NAMAIL1.ad.lsil.com>
References: <9738BCBE884FDB42801FAD8A7769C26514211A@NAMAIL1.ad.lsil.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 10:14:37 -0600
Message-Id: <1143044077.3633.15.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 08:52 -0700, Ju, Seokmann wrote:
> On Tuesday, March 21, 2006 6:02 PM, James Bottomley wrote:
> > I don't understand the question.  Are you asking why
> > sd_read_write_protect_flag and sd_read_cache_type operate in the way
> > they do?  i.e. header first then actual data.
> For any SCSI command including MODE_SENSE, 'bufflen'in scsi_cmnd structure holds actual data buffer size in bytes if 'use_sg' flage is NOT set.
> The question is that "value of bufflen is 4 for the sd_read_cache_type operation and that is NOT sufficient to return header and page data by driver".
> If there is something that I misunderstood with the operation, please guide.

If you look at the functions in sd.c you'll see it goes about asking for
mode sense very carefully, because there are a lot of broken devices out
there.  The first request is only for enough of the headers to work out
the length of the page.

James


