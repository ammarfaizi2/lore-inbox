Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272691AbTHEMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272692AbTHEMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:00:59 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11279 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272691AbTHEMAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:00:55 -0400
Date: Tue, 5 Aug 2003 14:00:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@lst.de>
cc: James.Bottomley@steeleye.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] simplify i386 mca Kconfig bits
In-Reply-To: <20030805113551.GB23754@lst.de>
Message-ID: <Pine.LNX.4.44.0308051347060.717-100000@serv>
References: <20030805113154.GA23728@lst.de> <20030805113351.GA23754@lst.de>
 <20030805113551.GB23754@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Aug 2003, Christoph Hellwig wrote:

> --- 1.62/arch/i386/Kconfig	Thu Jun 19 19:06:56 2003
> +++ edited/arch/i386/Kconfig	Tue Jun 24 21:31:52 2003
> @@ -1104,16 +1104,13 @@
>  
>  config MCA
>  	bool "MCA support"
> -	depends on !(X86_VISWS || X86_VOYAGER)
> +	depends on !X86_VISWS
> +	default y if X86_VOYAGER
>  	help
>  	  MicroChannel Architecture is found in some IBM PS/2 machines and
>  	  laptops.  It is a bus system similar to PCI or ISA. See
>  	  <file:Documentation/mca.txt> (and especially the web page given
>  	  there) before attempting to build an MCA bus kernel.
> -
> -config MCA
> -	depends on X86_VOYAGER
> -	default y if X86_VOYAGER

This is not really the same as before, e.g. this might be better:

config MCA
	bool "MCA support" if !(X86_VISWS || X86_VOYAGER)
	default y if X86_VOYAGER

or you could do this:

config X86_VOYAGER
	bool "Voyager (NCR)"
	select MCA

config MCA
	bool "MCA support"
	depends on !X86_VISWS

bye, Roman

