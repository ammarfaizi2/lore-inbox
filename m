Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVDCMPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDCMPI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVDCMPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:15:08 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:16396 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261702AbVDCMPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:15:02 -0400
Date: Sun, 3 Apr 2005 22:14:27 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: linville@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Oops in set_spdif_output in i810_audio
Message-ID: <20050403121427.GC21388@gondor.apana.org.au>
References: <20050402162840.29a65623.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402162840.29a65623.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 04:28:40PM -0800, Andrew Morton wrote:
> 
> *** These are init messages & oops:
> i810_audio: Unknown symbol ac97_set_dac_rate
> i810_audio: Unknown symbol ac97_release_codec
> i810_audio: Unknown symbol ac97_set_adc_rate
> i810_audio: Unknown symbol ac97_alloc_codec
> i810_audio: Unknown symbol ac97_probe_codec

The codec initialisation failed so the codec is NULL.

> EIP is at i810_set_spdif_output+0x22/0x160 [i810_audio]

Boom as we dereferenced the codec.

Is there any reason why we should allow i810_probe to succeed
when there is no codec?

If not we can make i810_ac97_init fail in this case.

If so then we'll have to make sure that every dereference of
codec in this driver checks whether it's NULL.

I personally don't see a reason why we should allow it to
continue when the codec doesn't exist.  What do you guys think?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
