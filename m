Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUEGOgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUEGOgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUEGOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:36:23 -0400
Received: from verein.lst.de ([212.34.189.10]:39634 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263609AbUEGOfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:35:25 -0400
Date: Fri, 7 May 2004 16:35:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040507143512.GA14338@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, rth@twiddle.net,
	linux-kernel@vger.kernel.org
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507183208.A3283@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 06:32:08PM +0400, Ivan Kokshaysky wrote:
> -	MOD_INC_USE_COUNT;
> +	BUG_ON(!try_module_get(THIS_MODULE));

This is broken.  If you know you already have a reference somewhere -
and I can't find how that would work - you'd have to use __module_get,
but if it's not you can get a failure from try_module_get legally and
you should do the try_module_get outside the module, before it's code
is exectuted.

