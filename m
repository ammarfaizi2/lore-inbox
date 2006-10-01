Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWJAPXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJAPXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 11:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWJAPXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 11:23:24 -0400
Received: from zakalwe.fi ([80.83.5.154]:59564 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S1750984AbWJAPXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 11:23:23 -0400
Date: Sun, 1 Oct 2006 18:22:28 +0300
From: Heikki Orsila <shd@zakalwe.fi>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, matt@nomadgs.com,
       amit.kucheria@nokia.com, igor.stoppa@nokia.com,
       ext-Tuukka.Tikkanen@nokia.com
Subject: Re: [RFC] OMAP1 PM Core, PM Core  Implementation 2/2
Message-ID: <20061001152228.GA24539@zakalwe.fi>
References: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060930022435.b2344b5f.eugeny.mints@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some nitpicking about the patch follows..

On Sat, Sep 30, 2006 at 02:24:35AM +0400, Eugeny S. Mints wrote:
> +static long 
> +get_vtg(const char *vdomain)
> +{
> +	long ret = 0;

Unnecessary initialisation.

> +static long 
> +set_vtg(const char *vdomain, int val)
> +{
> +	long ret = 0;

here too. This and 'int i = 0;' happens in many functions.

> +	err = omap_pm_core_verify_opt(opt);
> +	if (err != 0)
> +		goto out;
> +
> +	return (void *)opt;
> +out:
> +	kfree(opt);
> +	return NULL;
> +}

Maybe use if (err != 0) { kfree(opt); return NULL; } because goto out is 
only used once?

> +static int cpu_vltg_show(void *md_opt, int *value)
> +{
> +	int rc = 0;
> +	if (md_opt == NULL) {
> +		if ((*value = get_vtg("v1")) <= 0)
> +			return -EIO;
> +	}
> +	else {
> +		struct pm_core_point *opt = (struct pm_core_point *)md_opt;
> +		*value = opt->cpu_vltg;
> +	}
> +
> +	return rc;
> +}

int rc is unnecessary because the function always returns 0. This 
happens in many places.

> +	int dpll;     /* in KHz */
> +	int cpu;      /* CPU frequency in KHz */
> +	int tc;       /* in KHz */
> +	int per;      /* in KHz */
> +	int dsp;      /* in KHz */
> +	int dspmmu;   /* in KHz */
> +	int lcd;      /* in KHz */
> +};

The SI multiplier is 'k', not 'K'.

- Heikki
