Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVDNNJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVDNNJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVDNNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:09:46 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:31493 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261497AbVDNNJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:09:29 -0400
Date: Thu, 14 Apr 2005 23:07:43 +1000
To: "SuD (Alex)" <sud@latinsud.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       alsa-devel@alsa-project.org
Subject: Re: [OSS] Add CXT48 to modem black list in ac97
Message-ID: <20050414130743.GA18784@gondor.apana.org.au>
References: <E1DInEA-0006md-00@gondolin.me.apana.org.au> <425D963C.5030202@latinsud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D963C.5030202@latinsud.com>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:59:24PM +0200, SuD (Alex) wrote:
> 
> As a result, if i insert "snd-intel8x0" it will detect a soundcard (pci 
> 0:0:1f.5), but if insert instead
> "snd-intel8x0M" it will detect a modem (pci 0:0:1f.6).
> If a modem is detected i get errors like: "MC'97 0 converters and GPIO 
> not ready (0x1)", and not sure how to test it.
> If i load both modules only the first will work. The second will give an 
> probe error -13 (EACCES?), because it has been marked as audio device, 
> but also marked as _SKIP_AUDIO (ac97_codec.c:1862), or viceversa.

Thanks for testing.

It would appear then that ALSA doesn't have a magic solution :)
It'll always treat the codec as a sound card when the sound module
is loaded.

Alan, you seem to be the one who added the original code to
i810_audio to skip the modem codecs.  Does this actually
do anything for OSS? That is, are there any modem drivers out
there that will work with OSS drivers?

If not, then I'd suggest that we simply remove the modem checks
from the OSS Code.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
