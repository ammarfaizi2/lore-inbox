Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVBSTMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVBSTMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 14:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVBSTMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 14:12:35 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:35034 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261769AbVBSTMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 14:12:32 -0500
Date: Sat, 19 Feb 2005 20:12:08 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: mike.miller@hp.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, akpm@osdl.org,
       eric.moore@lsil.com
Subject: Re: cciss CSMI via sysfs for 2.6
Message-ID: <20050219191208.GA30401@hout.vanvergehaald.nl>
References: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216164512.GA5734@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 10:45:12AM -0600, mike.miller@hp.com wrote:
> +static ssize_t cciss_phyinfo_show(struct device *dev, char *buf)
> +{
> +	ctlr_info_t *h = dev->driver_data;
> +	unsigned long flags;
> +	CommandList_struct *c;
> +	CSMI_SAS_PHY_INFO_BUFFER iocommand;
> +	CSMI_SAS_IDENTIFY p;
> +	u64bit temp64;
> +	DECLARE_COMPLETION(wait);
> +
> +	printk(KERN_WARNING "cciss: into cciss_phyinfo_show\n");
> +	memset(&iocommand, 0, sizeof(CSMI_SAS_PHY_INFO_BUFFER));
> +	memset(&p, 0, sizeof(CSMI_SAS_IDENTIFY));
> +
> +	/* allocate and fill in the command */
> +	if ((c = cmd_alloc(h, 0)) == NULL)
> +		return -ENOMEM;
> +
> +	iocommand.IoctlHeader.Length = sizeof(CSMI_SAS_PHY_INFO_BUFFER);
> +	c->cmd_type = CMD_IOCTL_PEND;
> +	c->Header.ReplyQueue = 0;
> +		
> +	//Do we send the whole buffer?
> +	if (iocommand.IoctlHeader.Length > 0){

This test will always be true, no?

> +		c->Header.SGList = 1;
> +		c->Header.SGTotal = 1;
> +	} else {
> +		c->Header.SGList = 0;
> +		c->Header.SGTotal = 0;
> +	}

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
