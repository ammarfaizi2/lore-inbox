Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946050AbWJaWIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946050AbWJaWIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946056AbWJaWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:08:54 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:63736 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1946050AbWJaWIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:08:53 -0500
Date: Tue, 31 Oct 2006 23:08:38 +0100
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: SCSI over USB showstopper bug?
Message-ID: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it looks as if SG_GET_RESERVED_SIZE & SG_SET_RESERVED_SIZE
are not in interaction with the underlying SCSI transport.

Programs like readcd and cdda2wav that try to get very large SCSI
transfer buffers get a confirmation for nearly any SCSI transfer size 
but later when readcd/cdda2wav try to transfer data with an
actual SCSI command, they fail with ENOMEM.

Correct fix: let sg.c make a callback to the underlying SCSI transport
		and let it get a confirmation tfor the buffer size.

Quick and dirty fix: reduce the maximum allowed DMA size to the smallest
		max DMA size of all SCSI transports.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
