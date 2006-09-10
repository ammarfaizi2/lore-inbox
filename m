Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWIJRS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWIJRS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWIJRS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:18:28 -0400
Received: from outbound-mail-23.bluehost.com ([70.103.189.18]:41183 "HELO
	outbound-mail-23.bluehost.com") by vger.kernel.org with SMTP
	id S932315AbWIJRS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:18:28 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: David Miller <davem@davemloft.net>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 10:18:06 -0700
User-Agent: KMail/1.9.3
Cc: jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org, akpm@osdl.org,
       segher@kernel.crashing.org
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <45028F87.7040603@garzik.org> <20060909.030854.78720744.davem@davemloft.net>
In-Reply-To: <20060909.030854.78720744.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101018.06930.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.169.58.76 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 09, 2006 3:08 am, David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Sat, 09 Sep 2006 05:55:19 -0400
>
> > As (I think) BenH mentioned in another email, the normal way Linux
> > handles these interfaces is for the primary API (readX, writeX) to
> > be strongly ordered, strongly coherent, etc.  And then there is a
> > relaxed version without barriers and syncs, for the smart guys who
> > know what they're doing
>
> Indeed, I think that is the way to handle this.

Well why didn't you guys mention this when mmiowb() went in?

I agree that having a relaxed PIO ordering version of writeX makes sense 
(jejb convinced me of this on irc the other day).  But what to name it?  
We already have readX_relaxed, but that's for PIO vs. DMA ordering, not 
PIO vs. PIO.  To distinguish from that case maybe writeX_weak or 
writeX_nobarrier would make sense?

Jesse
