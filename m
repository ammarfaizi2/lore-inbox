Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCaKUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCaKUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCaKUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:20:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16355 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261226AbVCaKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:20:42 -0500
Date: Thu, 31 Mar 2005 11:20:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 08/13] scsi: move request preps in other places into prep_fn()
Message-ID: <20050331102040.GD13842@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.94FFEC1E@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331090647.94FFEC1E@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Macro to determine the size of SCSI command. This macro takes vendor
> + * unique commands into account. SCSI commands in groups 6 and 7 are
> + * vendor unique and we will depend upon the command length being
> + * supplied correctly in cmd_len.
> + */
> +#define CDB_SIZE(cmd)	(((((cmd)->cmnd[0] >> 5) & 7) < 6) ? \
> +				COMMAND_SIZE((cmd)->cmnd[0]) : (cmd)->cmd_len)

should probably go to scsi.h as it's generally usefull.

