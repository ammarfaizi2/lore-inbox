Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCODUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCODUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCODUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:20:10 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:61077 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261493AbVCODTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:19:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nMSzhXmB0YhnnOQOL3SvQH9vDX6LFdxSvlv1kVny+n9EODubxwnRLk91qWdOHWNRB6h9aGXiD4c9xKuC+rBSCXD295+Zb9HeY+vPha6yVsCAvaTyxoSKBLcYDWCod5RP+yP8iBTGo/OVy/HMWJ+IX34HepLjQplPX3ob5VCj7Gk=
Message-ID: <9e47339105031419195bae4e11@mail.gmail.com>
Date: Mon, 14 Mar 2005 22:19:37 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <9e473391050312075548fb0f29@mail.gmail.com>
	 <16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	 <9e47339105031317193c28cbcf@mail.gmail.com>
	 <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 12:42:27 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:
> >>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
> 
> >>  The scenario I'm thinking about with these patches are things like
> >> low-latency user-level networking between nodes in a cluster, where
> >> for good performance even with a kernel driver you don't want to
> >> share your interrupt line with anything else.
> 
> Jon> The code needs to refuse to install if the IRQ line is shared.
> 
> It does.  The request_irq() call explicitly does not include SA_SHARED
> in its flags, so if the line is shared, it'll return an error to user
> space when the driver tries to open the file representing the interrupt.

Please put some big comments warning people about adding SA_SHARED. I
can easily see someone thinking that they are fixing a bug by adding
it. I'd probably even write a paragraph about what will happen if
SA_SHARED is added.

> 
> Jon> Also what about SMP, if you shut the IRQ off on one CPU isn't it
> Jon> still enabled on all of the others?
> 
> Nope.   disable_irq_nosync() talks to the interrupt controller, which
> is common to all the processors.  The main problem is that it's slow,
> because it has to go off-chip.
> 
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
> 


-- 
Jon Smirl
jonsmirl@gmail.com
