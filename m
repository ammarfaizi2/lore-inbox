Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVB1W0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVB1W0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVB1WZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:25:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63725 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261787AbVB1WZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:25:23 -0500
Date: Mon, 28 Feb 2005 22:25:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mark_Salyzyn@adaptec.com
Subject: Re: [2.6 patch] SCSI: possible cleanups
Message-ID: <20050228222509.GB19376@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark_Salyzyn@adaptec.com
References: <20050228213159.GO4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228213159.GO4021@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 10:31:59PM +0100, Adrian Bunk wrote:
> Before I'm getting flamed to death:
> This patch contains possible cleanups. If parts of this patch conflict 
> with pending changes these parts of my patch have to be dropped.
> 
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove or #if 0 the following unused functions:
>   - scsi.h: print_driverbyte
>   - scsi.h: print_hostbyte

these two please kill.

>   - constants.c: scsi_print_hostbyte
>   - constants.c: scsi_print_driverbyte

these we'll probably keep for now.

>   - scsi_scan.c: scsi_scan_single_target

this one will grow a user soon, but maybe it'll be completely
rewritten before.

> - remove the following unneeded EXPORT_SYMBOL's:
>   - constants.c: __scsi_print_sense

this was put in for a drivea and makes sense as API.

>   - hosts.c: scsi_host_lookup

we should probably kill this export.

>   - scsi.c: scsi_device_cancel
>   - scsi_lib.c: scsi_device_resume

dito.

>   - scsi_error.c: scsi_normalize_sense
>   - scsi_error.c: scsi_sense_desc_find

st is expected to use these soon.

>   - scsi_scan.c: scsi_rescan_device

aacraid was going to use that one, Mark, any chance to get a patch
anytime soon?

>   - scsi_scan.c: scsi_scan_single_target

as mentioned above we'll need this one soon.
