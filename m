Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVCaKO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVCaKO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCaKOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:14:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7139 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261226AbVCaKN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:13:58 -0500
Date: Thu, 31 Mar 2005 11:13:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 05/13] scsi: remove a timer race from scsi_queue_insert() and cleanup timer
Message-ID: <20050331101353.GC13842@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.4025028A@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331090647.4025028A@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		/* Queue the command and wait for it to complete */
>  		/* Abuse eh_timeout in the scsi_cmnd struct for our purposes */
>  		init_timer(&cmd->eh_timeout);
> +		cmd->eh_timeout.function = NULL;

I'd rather not see aic7xxx poke even deeper into this internal code.
Can you please switch it to use a timer of it's own first?

