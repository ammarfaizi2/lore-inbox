Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269771AbUJGJv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269771AbUJGJv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUJGJvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:51:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:14510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269779AbUJGJuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:50:37 -0400
Date: Thu, 7 Oct 2004 11:50:30 +0200
From: Andi Kleen <ak@suse.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: common code between i386 and x86_64 (was Re: [Patch] share i386/x86_64 intel cache descriptors table)
Message-ID: <20041007095030.GB21807@wotan.suse.de>
References: <20041006184723.A10900@unix-os.sc.intel.com> <4164B71A.30105@pobox.com> <20041007002550.A12738@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007002550.A12738@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:25:50AM -0700, Siddha, Suresh B wrote:
> On Wed, Oct 06, 2004 at 11:25:14PM -0400, Jeff Garzik wrote:
> > 
> > I have often wondered if there is any value to creating arch/x86 and 
> > include/asm-x86 for stuff shared between x86-64 and i386.
> 
> Yes. There is definitely some value. Currently this kind of code is scattered
> all around the place. With this demarcation, people touching this common
> code will be careful of not breaking arch's that are sharing this code.

The current method of just linking between arch/i386 and arch/x86_64
works fine IMHO. No need to get any fancier. Doing a large scale
rename would just have the effect of breaking any 3rd party patchkits
and making merging even more difficult. I doubt it would
improve the maintainability much.

I don't think they will be more careful just because the code is
in a separate directory. The only way to enforce both work is
to compile and test both.


> We can avoid duplicate data structure definitions and duplicate prototypes.

Possible a few more includes could be shared, but the advantage 
is probably not big. I don't think it makes sense to share
includes when the main code is not shared.

Also in some ways x86 and x86-64 are diverging more and more, so
sharing becomes more difficult. e.g. long ago I actually applied
a lot of patches with sed s/i386/x86_64/g. But these days most
things need to be ported by hand. And most stuff that can 
be trivially shared is already shared. Doing significantly
more sharing would need more changes to arch/i386, and I still
don't see much support for that. Also in some cases I expect
code to diverge even more, so having a bit less is not a bad thing.

-Andi
