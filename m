Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbTILVeT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTILVeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:34:19 -0400
Received: from palrel11.hp.com ([156.153.255.246]:53472 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261282AbTILVeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:34:17 -0400
Date: Fri, 12 Sep 2003 14:34:15 -0700
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Max Krasnyansky <maxk@qualcomm.com>,
       BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Bluez-devel] Re: [BUG] BlueTooth socket busted in 2.6.0-test5
Message-ID: <20030912213415.GA24895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030910225810.GA7712@bougret.hpl.hp.com> <1063237174.28890.6.camel@pegasus> <20030911203249.GA15575@bougret.hpl.hp.com> <1063344094.7869.396.camel@imladris.demon.co.uk> <1063354754.23778.380.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063354754.23778.380.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 09:19:15AM +0100, David Woodhouse wrote:
> On Fri, 2003-09-12 at 06:21 +0100, David Woodhouse wrote:
> > Er, if we're actually _running_ code from the bnep module, how can it
> > have a zero refcount? This bug is elsewhere, surely?
> 
> Please confirm this fixes it...
> 
> ===== net/bluetooth/bnep/sock.c 1.11 vs edited =====
> --- 1.11/net/bluetooth/bnep/sock.c	Thu Jun  5 01:57:08 2003
> +++ edited/net/bluetooth/bnep/sock.c	Fri Sep 12 09:16:17 2003
> @@ -186,7 +189,8 @@
>  
>  static struct net_proto_family bnep_sock_family_ops = {
>  	.family = PF_BLUETOOTH,
> -	.create = bnep_sock_create
> +	.create = bnep_sock_create,
> +	.owner = THIS_MODULE
>  };
>  
>  int __init bnep_sock_init(void)
> 
> 
> -- 
> dwmw2

	Sorry for the slow answer, but yes, this fixes the problem
(and yes, I've removed my temporary hack).
	Thanks a lot !

	Jean

