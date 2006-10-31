Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423674AbWJaWSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423674AbWJaWSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423681AbWJaWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:18:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423674AbWJaWSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:18:12 -0500
Subject: Re: SCSI over USB showstopper bug?
From: Arjan van de Ven <arjan@infradead.org>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
In-Reply-To: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de>
References: <4547c966.8oyAB/pzCZ7bGUza%Joerg.Schilling@fokus.fraunhofer.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 31 Oct 2006 23:18:10 +0100
Message-Id: <1162333090.3044.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 23:08 +0100, Joerg Schilling wrote:
> Hi,
> 
> it looks as if SG_GET_RESERVED_SIZE & SG_SET_RESERVED_SIZE
> are not in interaction with the underlying SCSI transport.
> 
> Programs like readcd and cdda2wav that try to get very large SCSI
> transfer buffers get a confirmation for nearly any SCSI transfer size 
> but later when readcd/cdda2wav try to transfer data with an
> actual SCSI command, they fail with ENOMEM.
> 
> Correct fix: let sg.c make a callback to the underlying SCSI transport
> 		and let it get a confirmation tfor the buffer size.
> 
> Quick and dirty fix: reduce the maximum allowed DMA size to the smallest
> 		max DMA size of all SCSI transports.

real good fix:

use SG_IO on the device directly that checks this already




