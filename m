Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbTFUHww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbTFUHww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:52:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:45547 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265097AbTFUHwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:52:49 -0400
Date: Sat, 21 Jun 2003 10:06:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hid-core: fix double kfree of device->rdesc on hid_parse_parse error path
Message-ID: <20030621100619.A23898@ucw.cz>
References: <20030620234911.GA6246@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620234911.GA6246@conectiva.com.br>; from acme@conectiva.com.br on Fri, Jun 20, 2003 at 08:49:11PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 08:49:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Vojtech,
> 
> 	Please pull from:
> 
> bk://kernel.bkbits.net/acme/usb-2.5
> 
> 	device->rdesc is freed in hid_free_device.
> 
> Best Regards,
> - Arnaldo

Thanks, added that patch to my tree. I didn't pull it from your tree,
since that one contains a lot of other changesets.

> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 
> ===================================================================
> 
> 
> ChangeSet@1.1363, 2003-06-20 20:30:13-03:00, acme@conectiva.com.br
>   o hid-core: fix double kfree of device->rdesc on hid_parse_parse error path
> 
> 
>  hid-core.c |    5 -----
>  1 files changed, 5 deletions(-)
> 
> 
> diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
> --- a/drivers/usb/input/hid-core.c	Fri Jun 20 20:32:46 2003
> +++ b/drivers/usb/input/hid-core.c	Fri Jun 20 20:32:46 2003
> @@ -674,7 +674,6 @@
>  
>  		if (item.format != HID_ITEM_FORMAT_SHORT) {
>  			dbg("unexpected long global item");
> -			kfree(device->rdesc);
>  			kfree(device->collection);
>  			hid_free_device(device);
>  			kfree(parser);
> @@ -684,7 +683,6 @@
>  		if (dispatch_type[item.type](parser, &item)) {
>  			dbg("item %u %u %u %u parsing failed\n",
>  				item.format, (unsigned)item.size, (unsigned)item.type, (unsigned)item.tag);
> -			kfree(device->rdesc);
>  			kfree(device->collection);
>  			hid_free_device(device);
>  			kfree(parser);
> @@ -694,7 +692,6 @@
>  		if (start == end) {
>  			if (parser->collection_stack_ptr) {
>  				dbg("unbalanced collection at end of report description");
> -				kfree(device->rdesc);
>  				kfree(device->collection);
>  				hid_free_device(device);
>  				kfree(parser);
> @@ -702,7 +699,6 @@
>  			}
>  			if (parser->local.delimiter_depth) {
>  				dbg("unbalanced delimiter at end of report description");
> -				kfree(device->rdesc);
>  				kfree(device->collection);
>  				hid_free_device(device);
>  				kfree(parser);
> @@ -714,7 +710,6 @@
>  	}
>  
>  	dbg("item fetching failed at offset %d\n", (int)(end - start));
> -	kfree(device->rdesc);
>  	kfree(device->collection);
>  	hid_free_device(device);
>  	kfree(parser);
> 
> ===================================================================
> 
> 
> This BitKeeper patch contains the following changesets:
> 1.1363
> ## Wrapped with gzip_uu ##
> 
> 
> M'XL( )Z9\SX  \V4VXK;,!"&KZ.G&-C+8GLDV5)BR))VMP?80D/*7A=%GL0F
> M&RO(3MJ"'[ZR0[/='A*Z]*(^#=:,?\_ALZ_@OB&?CXS=$KN"=ZYI\Y%U-=FV
> M.IC8NFV\],&Q<"XXDM)M*5ENDGVSC$2<L>"9F]:6<"#?Y",>R]-*^W5'^6CQ
> M^NW]^Y<+QJ93N"E-O::/U,)TREKG#^:A:&:F+1]<';?>U,V6VN&=W2FT$X@B
> M[!G7$C/5<86I[BPO.#<IIP)%.E;IHUJ?X#DMB4IP'DX47:8FBK-;X#&72@+*
> M!%4B$ 3F$G,N(Y0Y(O2MF?W<$GC!(4+V"OYM'3?,@H.R*B+K/.6PJKY X?;+
> M!X+-RA.!6T%!A\I2=.T+:D)TW8=_VAG?T/$*Y+WSL L)L3>@4&7([B#32@@V
> M?QP"B_YR8PP-LNL+%1>^ZEGH"4E"8K']H?(4N>[2-"QTA>9<KU9ZJ8N),2K[
> M?9>?J%7U;M\FWWMS%.['B4**<2H[(26F VCGGKK,WC,K8&M/Z]G&.U/^(O.'
> MU+GB$ZD#B5)RG@XD*O&$0S'.TPL<(D39?\_A'1RG\P$B_WDX D_SLX-Z!I^W
> H2FL(7[0:'\UD,!JSP?#^[O1[LB793;/?3L=4:*4EL6^9'"&9"P4     
>  

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
