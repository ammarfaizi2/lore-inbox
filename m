Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSBDNlR>; Mon, 4 Feb 2002 08:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288973AbSBDNlI>; Mon, 4 Feb 2002 08:41:08 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:51347 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S288976AbSBDNlC>;
	Mon, 4 Feb 2002 08:41:02 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
In-Reply-To: <20020202190242.C1740@havoc.gtf.org>
	<E16XAnc-00010K-00@the-village.bc.nu>
	<20020202200332.A3740@havoc.gtf.org>
	<20020203181302.C12963@fafner.intra.cogenit.fr>
	<20020203124614.A10139@havoc.gtf.org>
	<20020203230652.D12963@fafner.intra.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 04 Feb 2002 13:58:28 +0100
In-Reply-To: <20020203230652.D12963@fafner.intra.cogenit.fr>
Message-ID: <m3g04h5rpn.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> --- linux-2.5.3-kh/include/linux/hdlc/ioctl.h	Thu Jan  1 01:00:00 1970
> +++ linux-2.5.3/include/linux/hdlc/ioctl.h	Sun Feb  3 21:46:11 2002
> +typedef struct {
> +	unsigned short encoding;
> +	unsigned short parity;
> +} raw_proto;

This isn't for "raw" protocol. It's for raw _HDLC_ (or "just" HDLC),
so I think a better name is still hdlc_proto.

> +struct hdlc_settings {
> +	union {
> +		raw_proto		raw;
> +		cisco_proto		cisco;
> +		fr_proto		fr;
> +		fr_proto_pvc		fr_pvc;
> +		sync_serial_settings	sync;
> +		te1_settings		te1;
> +	} hdlcs_hdlcu;
> +};

I want to avoid such a union, because it's possible some of future member
structs will be large.

> @@ -95,10 +96,13 @@ struct ifmap 
>  struct if_settings
>  {
>  	unsigned int type;	/* Type of physical device or protocol */
> -	unsigned int data_length; /* device/protocol data length */
> -	void * data;		/* pointer to data, ignored if length = 0 */
> +	union {
> +		/* {atm/eth/dsl}_settings anyone ? */
> +		struct hdlc_settings ifsu_hdlc;
> +	} ifs_ifsu;
>  };

And here. It's currently impossible, as if_settings must be 16 bytes long
at most. Unless, of course, we have a variable-sized ifreq.
-- 
Krzysztof Halasa
Network Administrator
