Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVBRTql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVBRTql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVBRTql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:46:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:25515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261465AbVBRTqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:46:36 -0500
Date: Fri, 18 Feb 2005 19:46:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: mike.miller@hp.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, akpm@osdl.org,
       eric.moore@lsil.com, linux-scsi@vger.kernel.org, greg@kroah.com
Subject: Re: cciss CSMI via sysfs for 2.6
Message-ID: <20050218194628.GA24583@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
	linux-kernel@vger.kernel.org, mochel@osdl.org, akpm@osdl.org,
	eric.moore@lsil.com, linux-scsi@vger.kernel.org, greg@kroah.com
References: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
> + * sysfs stuff
> + * this should be moved to it's own file, maybe cciss_sysfs.h
> + */
> +
> +static ssize_t cciss_firmver_show(struct device *dev, char *buf)
> +{
> +	ctlr_info_t *h = dev->driver_data;
> +        return sprintf(buf,"%c%c%c%c\n", h->firm_ver[0], h->firm_ver[1],
> +                                h->firm_ver[2], h->firm_ver[3]);
> +}

I really wish we had a common firmver release attribut in the driver
core, as mentioned in the fc transport class thread.  Greg?

> +static ssize_t cciss_bus_id_show(struct device *dev, char *buf)
> +{
> +        return sprintf(buf,"%s\n", dev->bus_id);
> +}

this one is already exposed in the name of the sysfs link,
see bus_add_device()

> +	return sprintf(buf, "%x %x %x %x%x%x%x%x%x%x%x %x%x%x%x%x%x%x%x "
> +				"%x %x %x%x%x%x%x%x\n",
> +		p.bDeviceType, p.bRestricted, p.bInitiatorPortProtocol,
> +		p.bRestricted2[0], 
> +		p.bRestricted2[1], 
> +		p.bRestricted2[2],
> +		p.bRestricted2[3], 
> +		p.bRestricted2[4], 
> +		p.bRestricted2[5],
> +		p.bRestricted2[6], 
> +		p.bRestricted2[7],
> +	 	p.bSASAddress[0],
> +	 	p.bSASAddress[1],
> +	 	p.bSASAddress[2],
> +	 	p.bSASAddress[3],
> +	 	p.bSASAddress[4],
> +	 	p.bSASAddress[5],
> +	 	p.bSASAddress[6],
> +	 	p.bSASAddress[7],
> +		p.bPhyIdentifier, p.bSignalClass,
> +		p.bReserved[0],
> +		p.bReserved[1],
> +		p.bReserved[2],
> +		p.bReserved[3],
> +		p.bReserved[4],
> +		p.bReserved[5]);
> +}

This belongs into a SAS/SATA phy transport class and should be split
into multiple attributes.

