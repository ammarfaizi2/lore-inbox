Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267529AbVBEDdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267529AbVBEDdr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 22:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266980AbVBED3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 22:29:44 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:37251 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265215AbVBEDNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 22:13:00 -0500
Date: Fri, 4 Feb 2005 22:08:13 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] ns558 bug
Message-ID: <20050205030813.GB7998@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com, Andrew Morton <akpm@osdl.org>,
	castet.matthieu@free.fr, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
References: <4203D476.4040706@free.fr> <20050205004311.GA7998@neo.rr.com> <20050204190614.6cfd68ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204190614.6cfd68ce.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:06:14PM -0800, Andrew Morton wrote:

It looks ok.  My only concern is what would happen if the isa probe succeded
but the pnp_register_driver failed?  "pnp_register_driver" return -ENODEV if
"CONFIG_PNP" isn't enabled.  Do you think this would conflict with legacy
probing?

Thanks,
Adam


> So would this be the appropriate fix?
> 
> --- 25/drivers/input/gameport/ns558.c~ns558-oops-fix	2005-02-04 19:03:11.065813120 -0800
> +++ 25-akpm/drivers/input/gameport/ns558.c	2005-02-04 19:05:52.607255088 -0800
> @@ -264,6 +264,7 @@ static struct pnp_driver ns558_pnp_drive
>  static int __init ns558_init(void)
>  {
>  	int i = 0;
> +	int ret;
>  
>  /*
>   * Probe for ISA ports.
> @@ -272,8 +273,8 @@ static int __init ns558_init(void)
>  	while (ns558_isa_portlist[i])
>  		ns558_isa_probe(ns558_isa_portlist[i++]);
>  
> -	pnp_register_driver(&ns558_pnp_driver);
> -	return list_empty(&ns558_list) ? -ENODEV : 0;
> +	ret = pnp_register_driver(&ns558_pnp_driver);
> +	return (ret < 0) ? ret : 0;
>  }
>  
>  static void __exit ns558_exit(void)
> _
