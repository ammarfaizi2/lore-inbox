Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTEOAq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTEOAq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:46:58 -0400
Received: from dsl093-135-135.sfo2.dsl.speakeasy.net ([66.93.135.135]:12928
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S263348AbTEOAq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:46:27 -0400
Date: Wed, 14 May 2003 17:59:04 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515005904.GA1510@jm.kir.nu>
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030514234359.GB9898@suse.de> <3EC2D6FB.5050700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2D6FB.5050700@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:53:31PM -0400, Jeff Garzik wrote:

> airo and HostAP do indeed need to use CryptoAPI not reimplement their 
> own crypto, though...

Host AP driver has a dynamic crypto implementation that allows one to
load new algorithms as a separate kernel modules. One of such modules
was an interface to use CryptoAPI. However, I don't think there is a
public release of it.

Do you think WEP should be implemented as a CryptoAPI algorithm? It is a
combination of CRC-32 and RC4 and the crypto module in Host AP does
these together in one pass of the packet payload to minimize host CPU
load. I'm not keen on using RC4 separately with CryptoAPI (I don't think
it is even included yet) if that means making the WEP encryption use
more CPU.. However, I could consider taking CryptoAPI into use it would
support WEP as an algorithm (i.e., I could consider porting the current
Host AP WEP code to CryptoAPI).

Since I'm not that interested in maintaining multiple source trees of
the driver, own WEP implementation is going to remain in the Host AP
driver for 2.2 and 2.4 kernels. Anyway, this could probably be
automatically stripped from the code if backward compatibility in
drivers must be removed from 2.5/2.6 kernel tree.

-- 
Jouni Malinen                                            PGP id EFC895FA
