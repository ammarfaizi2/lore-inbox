Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbTJEPgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTJEPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 11:36:55 -0400
Received: from colin2.muc.de ([193.149.48.15]:63492 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263134AbTJEPgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 11:36:54 -0400
Date: 5 Oct 2003 17:37:07 +0200
Date: Sun, 5 Oct 2003 17:37:07 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Tony Hoyle <tmh@nodomain.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br
Subject: Re: Oops linux 2.4.23-pre6 on amd64
Message-ID: <20031005153707.GB30792@colin2.muc.de>
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org> <20031005092052.GC12880@colin2.muc.de> <3F802AD2.9010108@nodomain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F802AD2.9010108@nodomain.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 03:29:38PM +0100, Tony Hoyle wrote:
> Andi Kleen wrote:
> 
> >To rule out the compiler you can use the compiler/binutils from
> >
> >ftp.suse.com:/pub/suse/x86-64/supplementary/CrossTools/8.1-i386/
> >
> OK I built with that and here are the results:
> 
> 1. The ehci-hcd driver fails in exactly the same place.
> 2. It was still v. unstable, which led me to investigate why (since I'm 
> pretty sure the hardware is good & the suse compiler is supposed to be a 
> good one).  I started stripping out options until eventually I found 
> that it's devfs that's the culprit - with that enabled I get random 
> compile errors every few seconds.  With it disabled the compile works 
> perfectly, even with the debian compiler (tried -j20 and -j255 and both 
> passed).

Thanks for tracking this down. I would have never noticed
because I don't use devfs.

Marcelo, any ideas? Do you get broken devfs reports for other
64bit architectures too?

AFAIK devfs is unmaintained and I don't really plan to maintain
it myself. My proposal is to just disable it in the configuration
for x86-64 for now.

> My first guess was you can't use a 32bit devfsd with a 64bit kernel, but 
> stopping devfsd didn't seem to make a whole lot of difference to the 
> stability... only compiling out the entire devfs system solved it.

Very likely the devfs code in the kernel is buggy. It is known
to be race hell, I wouldn't be surprised if it has 64bit bugs too.

-Andi
