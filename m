Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBRBy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBRBy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWBRBy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:54:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:9604 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750745AbWBRBy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:54:28 -0500
Date: Fri, 17 Feb 2006 17:54:13 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 04/22] OF adapter probing
Message-ID: <20060218015413.GA17653@kroah.com>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005712.13620.82908.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005712.13620.82908.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:57:14PM -0800, Roland Dreier wrote:
> +int hipz_count_adapters(void)
> +{
> +	int num = 0;
> +	struct device_node *dn = NULL;
> +
> +	EDEB_EN(7, "");
> +
> +	while ((dn = of_find_node_by_name(dn, "lhca"))) {
> +		num++;
> +	}

The { } are not needed here.

> +
> +	of_node_put(dn);
> +
> +	if (num == 0) {
> +		EDEB_ERR(4, "No lhca node name was found in the"
> +			 " Open Firmware device tree.");
> +		return -ENODEV;
> +	}
> +
> +	EDEB(6, " ... found %x adapter(s)", num);
> +
> +	EDEB_EX(7, "num=%x", num);
> +
> +	return num;
> +}
> +
> +int hipz_probe_adapters(char **adapter_list)
> +{
> +	int ret = 0;
> +	int num = 0;
> +	struct device_node *dn = NULL;
> +	char *loc;
> +
> +	EDEB_EN(7, "adapter_list=%p", adapter_list);
> +
> +	while ((dn = of_find_node_by_name(dn, "lhca"))) {
> +		loc = get_property(dn, "ibm,loc-code", NULL);
> +		if (loc == NULL) {
> +			EDEB_ERR(4, "No ibm,loc-code property for"
> +				 " lhca Open Firmware device tree node.");
> +			ret = -ENODEV;
> +			goto probe_adapters0;
> +		}
> +
> +		adapter_list[num] = loc;
> +		EDEB(6, " ... found adapter[%x] with loc-code: %s", num, loc);
> +		num++;
> +	}
> +
> +      probe_adapters0:
> +	of_node_put(dn);

Please use tabs everywhere.

Hm, wait, that's a label.  Put it where it belongs, over on the left
please.

thanks,

greg k-h
