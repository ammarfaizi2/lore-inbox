Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWAFOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWAFOdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWAFOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:33:15 -0500
Received: from magic.adaptec.com ([216.52.22.17]:19585 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932427AbWAFOdP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:33:15 -0500
content-class: urn:content-classes:message
Subject: RE: RAID controller safety
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 6 Jan 2006 09:33:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F02026FB0@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID controller safety
Thread-Index: AcYNU/2ljKq6GzgWRCOSJAK035IoVwFckikQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kenny Simpson" <theonetruekenny@yahoo.com>
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox sez:
> 2005-12-29 at 08:29 -0800, Kenny Simpson wrote:
> > Specificly, I am looking at the Adaptec RAID controllers 
> > and their i2o drivers.  I am told the
> > kernel's i2o driver lacks a strong guarantee on fsync, and 
> > so far am unable to determine if the
> > dpt_i2o driver also falls short in this reguard.
> Only dpt can tell you what their firmware actually does.

The dpt_i2o driver (which is a scsi driver) accepts the
SYNCHRONIZE_CACHE scsi command and passes it off to the firmware. The
firmware respects this and flushes all the outstanding (cached)
commands. This is true in all (kernel.org or Adaptec latest) versions.

The only environment, in my memory, that this has been tested is in the
ASR driver in FreeBSD, where this behavior is necessary in support of
cluster checkpointing.

-- Mark Salyzyn
