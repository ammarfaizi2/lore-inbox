Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUEGWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUEGWhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUEGWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 18:37:50 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:14748 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263827AbUEGWht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 18:37:49 -0400
Date: Sat, 8 May 2004 02:37:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Christoph Hellwig <hch@lst.de>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040508023717.A3960@jurassic.park.msu.ru>
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040507143512.GA14338@lst.de>; from hch@lst.de on Fri, May 07, 2004 at 04:35:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 04:35:12PM +0200, Christoph Hellwig wrote:
> On Fri, May 07, 2004 at 06:32:08PM +0400, Ivan Kokshaysky wrote:
> > -	MOD_INC_USE_COUNT;
> > +	BUG_ON(!try_module_get(THIS_MODULE));
> 
> This is broken.  If you know you already have a reference somewhere -
> and I can't find how that would work - you'd have to use __module_get,
> but if it's not you can get a failure from try_module_get legally and
> you should do the try_module_get outside the module, before it's code
> is exectuted.

Ok, I realize - this seems to be confusing. I'll try to clarify:
- First of all, mere mortals are _not_ allowed to compile mandatory
  alpha IEEE fp emulation code as a module. Which is documented
  in arch/alpha/Kconfig.
- Roughly speaking, the fp emu _module_ code intercepts the fp traps,
  so races vs module loading/unloading are fundamentally unavoidable.
  These refcounting attempts just narrow the window.

And no, try_module_get should never fail here.

Alternatively, we could just drop _all_ module related stuff from
alpha/math-emu...

Ivan.
