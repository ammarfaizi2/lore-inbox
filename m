Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUEGXyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUEGXyv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 19:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbUEGXyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 19:54:51 -0400
Received: from verein.lst.de ([212.34.189.10]:49627 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263879AbUEGXyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 19:54:50 -0400
Date: Sat, 8 May 2004 00:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040507224104.GA21153@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
	linux-kernel@vger.kernel.org
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508023717.A3960@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 02:37:17AM +0400, Ivan Kokshaysky wrote:
> Ok, I realize - this seems to be confusing. I'll try to clarify:
> - First of all, mere mortals are _not_ allowed to compile mandatory
>   alpha IEEE fp emulation code as a module. Which is documented
>   in arch/alpha/Kconfig.
> - Roughly speaking, the fp emu _module_ code intercepts the fp traps,
>   so races vs module loading/unloading are fundamentally unavoidable.
>   These refcounting attempts just narrow the window.
> 
> And no, try_module_get should never fail here.
> 
> Alternatively, we could just drop _all_ module related stuff from
> alpha/math-emu...

either that or just marking it unloadable by removing the cleanup_module
handler sound like the simplest solution I guess.
