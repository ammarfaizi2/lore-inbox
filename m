Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWB0PdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWB0PdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWB0PdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:33:07 -0500
Received: from ns2.tasking.nl ([195.193.207.10]:31656 "EHLO ns2.tasking.nl")
	by vger.kernel.org with ESMTP id S964774AbWB0Pc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:58 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <200602250042.51677.bero@arklinux.org>
From: dick.streefland@altium.nl (Dick Streefland)
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <27d9.44031ba8.afafc@altium.nl>
Date: Mon, 27 Feb 2006 15:32:56 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
| I've just released dvdrtools 0.3.1 
| (http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools that 
| (as the name indicates) adds support for writing to DVD-R and DVD-RW disks 
| using purely Free Software, that tries to do things the Linux way ("dvdrecord 
| dev=/dev/cdrom whatever.iso") without suggesting to use 2.4 kernels or even 
| other operating systems, uses a standard make system, is maintained in a 
| public svn repository, and does away with a lot of the libc 
| functionality-clones found in cdrtools.

Good. So, we can finally fix this:

diff -pu dvdrtools-0.3.1/dvdrecord/scsi_cdr.c.orig dvdrtools-0.3.1/dvdrecord/scsi_cdr.c
--- dvdrtools-0.3.1/dvdrecord/scsi_cdr.c.orig	2006-02-15 03:47:41.000000000 +0100
+++ dvdrtools-0.3.1/dvdrecord/scsi_cdr.c	2006-02-27 16:24:10.000000000 +0100
@@ -2196,7 +2196,7 @@ EXPORT void printinq(SCSI *scgp, FILE *f
 	if (inq->add_len >= 31 ||
 			inq->info[0] || inq->ident[0] || inq->revision[0]) {
 		fprintf(f, "Vendor_info    : '%.8s'\n", inq->info);
-		fprintf(f, "Identifikation : '%.16s'\n", inq->ident);
+		fprintf(f, "Identification : '%.16s'\n", inq->ident);
 		fprintf(f, "Revision       : '%.4s'\n", inq->revision);
 	}
 }

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

