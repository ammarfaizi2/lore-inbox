Return-Path: <linux-kernel-owner+w=401wt.eu-S1750880AbXANOn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbXANOn0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXANOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:43:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59055 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbXANOnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:43:25 -0500
Date: Sun, 14 Jan 2007 14:54:11 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 00/12] Fix ppc64's writing to struct file_operations
Message-ID: <20070114145411.1fd8c985@localhost.localdomain>
In-Reply-To: <1168735914.3123.317.camel@laptopd505.fenrus.org>
References: <1168735868.3123.315.camel@laptopd505.fenrus.org>
	<1168735914.3123.317.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	.read		= seq_read,
> +	.write		= lparcfg_write,
>  	.open		= lparcfg_open,
>  	.release	= single_release,
>  };
> @@ -581,10 +582,8 @@ int __init lparcfg_init(void)
>  
>  	/* Allow writing if we have FW_FEATURE_SPLPAR */
>  	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
> -			!firmware_has_feature(FW_FEATURE_ISERIES)) {
> -		lparcfg_fops.write = lparcfg_write;
> +			!firmware_has_feature(FW_FEATURE_ISERIES))
>  		mode |= S_IWUSR;
> -	}


This doesn't appea to do the same thing at all. You need to select
between two sets of const inode ops instead, otherwise you turn write on
arbitarily.
