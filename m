Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVLLSJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVLLSJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLLSJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:09:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932172AbVLLSJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:09:39 -0500
Date: Mon, 12 Dec 2005 10:09:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Ryan Richter <ryan@tau.solarneutrino.net>, Hugh Dickins <hugh@veritas.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <1134409531.9994.13.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
References: <20051201195657.GB7236@tau.solarneutrino.net> 
 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> 
 <20051202180326.GB7634@tau.solarneutrino.net> 
 <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> 
 <20051202194447.GA7679@tau.solarneutrino.net> 
 <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com> 
 <20051206160815.GC11560@tau.solarneutrino.net> 
 <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com> 
 <20051206204336.GA12248@tau.solarneutrino.net> 
 <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com> 
 <20051212165443.GD17295@tau.solarneutrino.net>  <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
 <1134409531.9994.13.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Dec 2005, James Bottomley wrote:
> 
> This is that SCSI patch you reversed just before you went away.  If you
> put it back again, the problem will go away ...

Well, that patch is definitely broken.

You say that it just causes a warning about sleeping in interrupt context, 
while I say that the warning is a serious error. If that semaphore _ever_ 
is write-locked, the whole machine will crash from trying to sleep when it 
cannot sleep.

So I can certainly undo the undo, but the fact is, the code is CRAP. I'd 
much rather get a real fix instead of having to select between two known 
bugs.

Please?

		Linus
