Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSHGUeN>; Wed, 7 Aug 2002 16:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSHGUeM>; Wed, 7 Aug 2002 16:34:12 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:54955 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317385AbSHGUeI>;
	Wed, 7 Aug 2002 16:34:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Wed, 7 Aug 2002 22:39:15 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Rik van Riel <riel@conectiva.com.br>
References: <E17aiJv-0007cr-00@starship> <3D5177CB.D8CA77C2@zip.com.au> <E17cXFM-0004si-00@starship>
In-Reply-To: <E17cXFM-0004si-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17cXaO-0004xi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 22:17, Daniel Phillips wrote:
> On Wednesday 07 August 2002 21:40, Andrew Morton wrote:
> > > Vectoring up the pte chain nodes as
> > > you do here doesn't help much because the internal fragmentation
> > > roughly equals the reduction in link fields.
> > 
> > Are you sure about that?  The vectoring is only a loss for very low
> > sharing levels, at which the space consumption isn't a problem anyway.
> > At high levels of sharing it's almost a halving.
> 
> Your vector will only be half full on average.

Ah, the internal fragmentation only exists in the first node, yes I see.
So I'm correct at typical sharing levels, but for massive sharing, yes
it approaches half the space, which is significant.  That's also when rmap
should show the most advantage over virtual scanning, so we really truly
do have to benchmark that.

-- 
Daniel
