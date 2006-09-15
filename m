Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWIOQac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWIOQac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWIOQab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:30:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:1942 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751678AbWIOQaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:30:30 -0400
X-Authenticated: #5039886
Date: Fri, 15 Sep 2006 18:30:27 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Rohit Seth <rohitseth@google.com>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch03/05]- Containers: Initialization and Configfs interface
Message-ID: <20060915163027.GA5285@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Rohit Seth <rohitseth@google.com>, Andrew Morton <akpm@osdl.org>,
	devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158284486.5408.154.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1158284486.5408.154.camel@galaxy.corp.google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.14 18:41:26 -0700, Rohit Seth wrote:
> +static int __init configfs_container_init(void)
> +{
> +	int ret;
> +
> +	config_group_init(&containerfs_group.cs_subsys.su_group);
> +	init_MUTEX(&containerfs_group.cs_subsys.su_sem);
> +	ret = configfs_register_subsystem(&containerfs_group.cs_subsys);
> +
> +	if (ret) 
> +		printk(KERN_ERR "Error %d while registering container subsystem\n", ret);
> +	else {
> +		container_wq = create_workqueue("Kcontainerd");
> +		if (container_wq == NULL) {
> +			ret = -ENOMEM;
> +			printk(KERN_ERR "Unable to create Container controllers");

Shouldn't the subsystem be unregistered here?

> +		}
> +	}
> +	return ret;
> +}

Regards,
Björn
