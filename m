Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTLLWfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLLWfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:35:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262131AbTLLWfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:35:03 -0500
Message-ID: <3FDA426B.1060508@pobox.com>
Date: Fri, 12 Dec 2003 17:34:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
       linux-tr@linuxtr.net, jschlst@samba.org, cgoos@syskonnect.de,
       mid@auk.cx, phillim@amtrak.com, jochen@scram.de
Subject: Re: [PATCH][TRIVIAL] dep_tristate wants 3 arguments (fwd)
References: <20031212222655.GH1825@fs.tum.de>
In-Reply-To: <20031212222655.GH1825@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi Marcelo,
> 
> the trivial patch by Rik forwarded below still applies against 
> 2.4.24-pre1.
> 
> Please apply

Let's not and say we did :)


> ----- Forwarded message from Rik van Riel <riel@surriel.com> -----
> 
> Date:	Mon, 13 Oct 2003 11:10:36 -0400 (EDT)
> From: Rik van Riel <riel@surriel.com>
> To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH][TRIVIAL] dep_tristate wants 3 arguments
> 
> The tokenring Config.in has dep_tristate statements with only two
> arguments. Add the obvious third argument.
> 
> diff -urNp linux-5110/drivers/net/tokenring/Config.in linux-10010/drivers/net/tokenring/Config.in
> --- linux-5110/drivers/net/tokenring/Config.in
> +++ linux-10010/drivers/net/tokenring/Config.in
> @@ -21,10 +21,10 @@ if [ "$CONFIG_TR" != "n" ]; then
>     dep_tristate '  3Com 3C359 Token Link Velocity XL adapter support' CONFIG_3C359 $CONFIG_TR $CONFIG_PCI
>     tristate '  Generic TMS380 Token Ring ISA/PCI adapter support' CONFIG_TMS380TR
>     if [ "$CONFIG_TMS380TR" != "n" ]; then
> -      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI
> -      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA
> -      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI
> -      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA
> +      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI $CONFIG_TMS380TR
> +      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA $CONFIG_TMS380TR
> +      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI $CONFIG_TMS380TR
> +      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA $CONFIG_TMS380TR

I don't see why this patch is needed.

dep_tristate statements with only three arguments (include desc. text) 
are just fine.  There is no need for additional arguments.

	dep_tristate 'blah blah' CONFIG_BLAH dep...

Further, adding CONFIG_TMS380TR dependency is complete nonsense, 
considering that the "if [ "$CONFIG_TMS380TR" != "n" ]" check remains.

	Jeff



