Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292124AbSBAWzg>; Fri, 1 Feb 2002 17:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292125AbSBAWz1>; Fri, 1 Feb 2002 17:55:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36107 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292124AbSBAWzZ>; Fri, 1 Feb 2002 17:55:25 -0500
Message-ID: <3C5B1CBB.6080802@zytor.com>
Date: Fri, 01 Feb 2002 14:54:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Peter Monta <pmonta@pmonta.com>
CC: garzik@havoc.gtf.org, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org> <20020201205605.ED5111C5@www.pmonta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Monta wrote:

> 
> Well, yes and no.  What you really need is a conservative estimate
> of how much entropy is contained in n bits of input; a cryptographic
> hash, such as MD5, will distill out the "truly random".  The comments
> in drivers/char/random.c claim that the input hash is cryptographically
> noncritical, but to be pedantic, maybe MD5 the audio noise before
> writing to /dev/random.
> 


/dev/random rather does that itself (that's what the output hash does.)


> Assuming the sound-card output looks like reasonable noise of
> a few LSBs amplitude, a conservative estimate might be 0.1 bit
> of entropy per sample.  This is 9600 bits of entropy per second
> from a stereo card, more than enough.
> 
> A small daemon would wake up every so often, check if /dev/random
> needs topped up, read some audio samples, MD5(), write(),
> ioctl(# of claimed entropy bits).  I haven't seen the i810 RNG tools,
> but I guess they do something similar.


The point with the tests that have been mentioned is to derive such a
conservative estimate, and to raise a red flag if the output suddenly
becomes predictable.

	-hpa

 


