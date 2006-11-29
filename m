Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936007AbWK2UDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936007AbWK2UDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936008AbWK2UDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:03:35 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59835 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S936007AbWK2UDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:03:34 -0500
Message-ID: <456DE7B2.8090505@cfl.rr.com>
Date: Wed, 29 Nov 2006 15:04:02 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <mj+md-20061128.131233.3594.atrey@ucw.cz> <456C704F.3050008@cfl.rr.com> <mj+md-200611 <mj+md-20061128.210510.8000.atrey@ucw.cz>
In-Reply-To: <mj+md-20061128.210510.8000.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Nov 2006 20:04:03.0895 (UTC) FILETIME=[84C5CC70:01C713F1]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14844.000
X-TM-AS-Result: No--14.199700-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> No, the only safe thing the kernel can do is to add NO entropy,
> unless explicitly told otherwise.

Ahh, I think I see where I got confused now.  I thought you wanted to 
save and restore the entropy estimate after a reboot.  I was trying to 
say that you don't want to/can't do that.  I would think that since you 
are, in fact, adding some entropy by writing the data, that increasing 
the entropy count would be fine, you just can't set it to its 'full' 
value ( assuming it was full at shutdown ).

> More importantly, it should be possible for root to write to /dev/random
> _without_ increasing the entropy count, for example when restoring random
> pool contents after reboot. In such cases you want the pool to contain
> at least some unpredictable data before real entropy arrives, so that
> /dev/urandom cannot be guessed, but you unless you remember the entropy
> counter as well, you should not add any entropy.

I believe that random and urandom use separate entropy pools, so boot 
scripts save/restore urandom to keep that nicely seeded, but not random. 
  It has to start clean each boot and rely on entropy created by the 
usual input methods.  That is actually why I have a problem with the 
ioctl being required, because I can't just write a simple boot script to 
save/restore random data as is done with urandom, and be able to extract 
some random data right away.

