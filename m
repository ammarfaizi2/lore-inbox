Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUHJOmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUHJOmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUHJOmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:42:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55791 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266219AbUHJOmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:42:06 -0400
Date: Tue, 10 Aug 2004 16:42:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tim Cambrant <tcambrant@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding out what certain kernel config options are dependant on
Message-ID: <20040810144200.GN26174@fs.tum.de>
References: <BAY1-F15JkUwWpSWerO0001ad67@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-F15JkUwWpSWerO0001ad67@hotmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 01:15:18PM +0200, Tim Cambrant wrote:

> Hi, I'm sorry for not posting a more development related question, but I 
> know there is a need for finding out why certain options in make config are 
> preselected, and why we can't choose not to use them. If this doesn't make 
> sense, consider this:
> On my machine, with 2.6.8-rc4-mm1 (and all the other versions I've tried so 
> far in 2.6) CONFIG_CRYPTO is preselected, and I can't remove it. I'm not 
> interested in the cryptographic API at all. So what driver or option did i 
> enable that requires CONFIG_CRYPTO?
> I'd appreciate help on finding this out, since I'd like to remove it all 
> from my .config. Is there a script or some other automated way on finding 
> this out?
> If I find out that CONFIG_CRYPTO really is needed in the kernel all the 
> way, I appologize for asking such a stupid question, but then I'd wonder 
> why there is even an option for that.


  find . -name Kconfig\* | xargs grep select | grep CRYPTO


It seems, you have one or more of the following options enabled:

BLK_DEV_CRYPTOLOOP
DM_CRYPT
INET6_AH
INET6_ESP
INET6_IPCOMP
INET_AH
INET_ESP
INET_IPCOMP
IPV6_PRIVACY
IP_SCTP
NFS_V4
RPCSEC_GSS_KRB5

Disabling all of them should enable you to disable CRYPTO.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

