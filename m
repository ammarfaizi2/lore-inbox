Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULJK4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULJK4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 05:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULJK4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 05:56:25 -0500
Received: from webapps.arcom.com ([194.200.159.168]:3595 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261174AbULJK4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 05:56:12 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Ian Campbell <icampbell@arcom.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Fri, 10 Dec 2004 10:56:08 +0000
Message-Id: <1102676169.31305.85.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2004 10:58:23.0203 (UTC) FILETIME=[2ACA6B30:01C4DEA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> +	/* Determine chip type */
> +	if (tpm_nsc_init(chip) == 0) {
> +		chip->recv = tpm_nsc_recv;
> +		chip->send = tpm_nsc_send;
> +		chip->cancel = tpm_nsc_cancel;
> +		chip->req_complete_mask = NSC_STATUS_OBF;
> +		chip->req_complete_val = NSC_STATUS_OBF;
> +	} else if (tpm_atml_init(chip) == 0) {
> +		chip->recv = tpm_atml_recv;
> +		chip->send = tpm_atml_send;
> +		chip->cancel = tpm_atml_cancel;
> +		chip->req_complete_mask =
> +		    ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL;
> +		chip->req_complete_val = ATML_STATUS_DATA_AVAIL;
> +	} else {
> +		rc = -ENODEV;
> +		goto out_release;
> +	}

The atmel part at least also comes as an I2C variant. 

We could continue to add to the ifelse here but perhaps it might be
beneficial to split the individual chip specific stuff into separate
files now and perhaps register them via some sort of
register_tpm_hardware(struct tpm_chip_ops *) type interface?

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

