Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVCZLVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVCZLVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVCZLVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:21:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22950 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262033AbVCZLVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:21:17 -0500
Date: Sat, 26 Mar 2005 11:21:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Message-ID: <20050326112108.GA25751@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <91888D455306F94EBD4D168954A9457C01B7055E@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91888D455306F94EBD4D168954A9457C01B7055E@nacos172.co.lsil.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took a quick look an a here's a few comments:

 - I don't think renaming mptscsih.c to mpt_core.c makes sense.
   the new name is confusing at best, and keeping the old name allows
   to keep SCCS history aswell.  That means the new SPI stub driver should
   be called mptspi or something like that.
 - please don't link mpt_core.o into both mptfch.ko and mptscsih.ko but
   make it a module of it's own
 - the new driver shoild use module_param, not MODULE_PARM
 - why does the fc driver set ioc->spi_data.mpt_pq_filter?
 - no need to forward-declare the module_init/module_exit handlers
