Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUENN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUENN0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUENN0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:26:23 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:40165 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265276AbUENN0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:26:16 -0400
Date: Fri, 14 May 2004 15:26:15 +0200
From: bert hubert <ahu@ds9a.nl>
To: Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>
Cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] AES i586 optimized, regparm fixed
Message-ID: <20040514132615.GA21039@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>,
	linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	James Morris <jmorris@redhat.com>
References: <20040514130724.GA8081@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514130724.GA8081@ghanima.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:07:24PM +0200, Fruhwirth Clemens wrote:

> +config CRYPTO_AES_586
> +	tristate "AES cipher algorithms (586)"
> +	depends on CRYPTO && X86 && !X86_64 
> +	help
> +	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
> +	  algorithm.

I'm wondering if this should be a configurable setting. Reminds me of older
programs asking if they should do something using the 'fast' or 'slow'
algorithm, even though results were identical.

If we trust the AES assembler code, and it is supposed to be faster on >586,
it should be the default on those CPUs as there is no gain in using the C version.

On the other hand, if we think there are situations when the new assembler
code won't be correct or faster, we should not merge it.

In any case, Kconfig does not seem the way to go.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
