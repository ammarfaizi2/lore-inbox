Return-Path: <linux-kernel-owner+w=401wt.eu-S932860AbXABLbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbXABLbs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbXABLbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:31:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45346 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbXABLbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:31:46 -0500
Date: Tue, 2 Jan 2007 11:31:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Sam Creasey <sammy@sammy.net>
Subject: Re: [PATCH] Sun3 SCSI: Make sun3 scsi drivers compile/work again
Message-ID: <20070102113143.GB24951@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-scsi@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Sam Creasey <sammy@sammy.net>
References: <Pine.LNX.4.64.0612091036450.12009@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612091036450.12009@anakin>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 10:37:05AM +0100, Geert Uytterhoeven wrote:
> +#include "initio.h"

This is definitly wrong.  This is a header file for a specific driver.
I suspect you want the old-EH definitions for SCSI_RESET_*/SCSI_ABORT_*?

You're returning them from the EH routines which are plugged into the
new EH method slots, so this is not only wrong by including an other
drivers private headers but also functionally deadly.

