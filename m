Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424069AbWKPOCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424069AbWKPOCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 09:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424071AbWKPOCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 09:02:39 -0500
Received: from zakalwe.fi ([80.83.5.154]:31688 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1424069AbWKPOCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 09:02:38 -0500
Date: Thu, 16 Nov 2006 16:02:31 +0200
From: Heikki Orsila <shd@zakalwe.fi>
To: Maynard Johnson <maynardj@us.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC, Patch 1/1] OProfile for Cell: Initial profiling support -- new patch
Message-ID: <20061116140231.GA12227@zakalwe.fi>
References: <455B619C.7040904@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <455B619C.7040904@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 12:51:08PM -0600, Maynard Johnson wrote:
> +/* This function is called once for all cpus combined */
> +static void
> +cell_reg_setup(struct op_counter_config *ctr,
> +	       struct op_system_config *sys, int num_ctrs)
> +{
> [SNIP]
> +	for (i = 0; i < num_ctrs; ++i) {
> +
> +		if ((ctr[i].event >= 2100) && (ctr[i].event <= 2111))
> +			pmc_cntrl[1][i].evnts = ctr[i].event + 19;
> +		else if (ctr[i].event == 2203)
> +			pmc_cntrl[1][i].evnts = ctr[i].event;
> +		else if ((ctr[i].event >= 2200) && (ctr[i].event <= 2215))
> +			pmc_cntrl[1][i].evnts = ctr[i].event + 16;
> +		else
> +			pmc_cntrl[1][i].evnts = ctr[i].event;
> +

I think the previous code would be more readable with a switch() 
statement. 

	switch (ctr[i].event) {
	case 2100 ... 2111:
		pmc_cntrl[1][i] = ctr[i].event + 19;
		break;
	case 2200 ... 2202:
	case 2204 ... 2215:
		pmc_cntrl[1][i] = ctr[i].event + 16;
		break;
	default:
		pmc_cntrl[1][i] = ctr[i].event;
	}

 - Heikki
