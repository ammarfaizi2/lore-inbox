Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJ1THr>; Mon, 28 Oct 2002 14:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSJ1THr>; Mon, 28 Oct 2002 14:07:47 -0500
Received: from ns.suse.de ([213.95.15.193]:64006 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261518AbSJ1THq>;
	Mon, 28 Oct 2002 14:07:46 -0500
Date: Mon, 28 Oct 2002 20:10:11 +0100
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andi Kleen <ak@suse.de>, IA64 Linux Mail Group <linux-ia64@linuxia64.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixing /proc/kcore
Message-ID: <20021028201011.A14591@wotan.suse.de>
References: <DD755978BA8283409FB0087C39132BD10C4404@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD755978BA8283409FB0087C39132BD10C4404@fmsmsx404.fm.intel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:03:42AM -0800, Luck, Tony wrote:
> What about a combined approach ... architecture dependent code
> should add all the interesting stuff to the vmlist, so kcore just
> needs to walk the list to cover everything.  We could also keep the

Works for me. You just have to make sure to keep vmlist ordered
and make sure all users of vmlist check for their correct address
range (vmalloc.c does, but some arch specific code may not)

> KCORE_BASE concept from my patch, but turn it into a variable that
> the architecture dependent code can set to some suitable offset to
> keep all the offsets in /proc/kcore positive.  This will avoid
> having to fixup binutils (at least until someone comes up with an
> architecture where kernel space scatters across a wide enough range
> that we can't keep the offsets positive).

x86-64 is such an architecture, so binutils will need to be fixed anyways.

-andi
