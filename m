Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbTIIRSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTIIRSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:18:24 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:37648 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264316AbTIIRSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:18:13 -0400
Date: Tue, 9 Sep 2003 14:19:23 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_PCMCIA_WL3501 build fails
Message-ID: <20030909171922.GE919@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030909132809.B4216@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309091009210.17041-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091009210.17041-100000@home.osdl.org>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good patch, Linus please apply 8)

Die, 2.95, die :-)

- Arnaldo

Em Tue, Sep 09, 2003 at 10:13:37AM -0700, Linus Torvalds escreveu:
> 
> On Tue, 9 Sep 2003, Russell King wrote:
> 
> > On Tue, Sep 09, 2003 at 10:12:11PM +1000, Eyal Lebedinsky wrote:
> > > allmodconfig, i386:
> > > 
> > >   CC [M]  drivers/net/wireless/wl3501_cs.o
> > > drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_join':
> > > drivers/net/wireless/wl3501_cs.c:641: unknown field `id' specified in
> > > initializer
> > 
> > I notice that this driver uses .foo.bar = baz type initialisers.  These
> > do not work on gcc 2.95 (and last time I checked, the kernels minimum
> > compiler version was still 2.95.x)
> 
> Yeah, the ".foo.bar = baz" thing should go. Something like the following, 
> but it would be good to have somebody verify that this was all of it and 
> that it actually works.
> 
> 		Linus
> 
> ----
> ===== drivers/net/wireless/wl3501_cs.c 1.70 vs edited =====
> --- 1.70/drivers/net/wireless/wl3501_cs.c	Tue Aug 19 07:24:34 2003
> +++ edited/drivers/net/wireless/wl3501_cs.c	Tue Sep  9 10:12:46 2003
> @@ -638,8 +638,10 @@
>  		.sig_id		  = WL3501_SIG_JOIN_REQ,
>  		.timeout	  = 10,
>  		.ds_pset = {
> -			.el.id  = IW_MGMT_INFO_ELEMENT_DS_PARAMETER_SET,
> -			.el.len = 1,
> +			.el = {
> +				.id  = IW_MGMT_INFO_ELEMENT_DS_PARAMETER_SET,
> +				.len = 1,
> +			},
>  			.chan	= this->chan,
>  		},
>  	};
> @@ -655,13 +657,17 @@
>  		.beacon_period		= 400,
>  		.dtim_period		= 1,
>  		.ds_pset = {
> -			.el.id  = IW_MGMT_INFO_ELEMENT_DS_PARAMETER_SET,
> -			.el.len = 1,
> +			.el = {
> +				.id  = IW_MGMT_INFO_ELEMENT_DS_PARAMETER_SET,
> +				.len = 1,
> +			},
>  			.chan	= this->chan,
>  		},
>  		.bss_basic_rset	= {
> -			.el.id	= IW_MGMT_INFO_ELEMENT_SUPPORTED_RATES,
> -			.el.len = 2,
> +			.el = {
> +				.id	= IW_MGMT_INFO_ELEMENT_SUPPORTED_RATES,
> +				.len = 2,
> +			},
>  			.data_rate_labels = {
>  				[0] = IW_MGMT_RATE_LABEL_MANDATORY |
>  				      IW_MGMT_RATE_LABEL_1MBIT,
> @@ -670,8 +676,10 @@
>  			},
>  		},
>  		.operational_rset	= {
> -			.el.id	= IW_MGMT_INFO_ELEMENT_SUPPORTED_RATES,
> -			.el.len = 2,
> +			.el = {
> +				.id	= IW_MGMT_INFO_ELEMENT_SUPPORTED_RATES,
> +				.len = 2,
> +			},
>  			.data_rate_labels = {
>  				[0] = IW_MGMT_RATE_LABEL_MANDATORY |
>  				      IW_MGMT_RATE_LABEL_1MBIT,
> @@ -680,8 +688,10 @@
>  			},
>  		},
>  		.ibss_pset		= {
> -			.el.id	     = IW_MGMT_INFO_ELEMENT_IBSS_PARAMETER_SET,
> -			.el.len	     = 2,
> +			.el = {
> +				.id	 = IW_MGMT_INFO_ELEMENT_IBSS_PARAMETER_SET,
> +				.len     = 2,
> +			},
>  			.atim_window = 10,
>  		},
>  		.bss_type		= wl3501_fw_bss_type(this),
