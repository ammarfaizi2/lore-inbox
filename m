Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbTJEO3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTJEO3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:29:47 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:56218 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S263115AbTJEO3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:29:46 -0400
Message-ID: <3F802AD2.9010108@nodomain.org>
Date: Sun, 05 Oct 2003 15:29:38 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org> <3F7F1D21.1070503@nodomain.org> <20031004205545.GB71123@colin2.muc.de> <3F7F4AFC.7000700@nodomain.org> <20031005092052.GC12880@colin2.muc.de>
In-Reply-To: <20031005092052.GC12880@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> To rule out the compiler you can use the compiler/binutils from
> 
> ftp.suse.com:/pub/suse/x86-64/supplementary/CrossTools/8.1-i386/
> 
OK I built with that and here are the results:

1. The ehci-hcd driver fails in exactly the same place.
2. It was still v. unstable, which led me to investigate why (since I'm 
pretty sure the hardware is good & the suse compiler is supposed to be a 
good one).  I started stripping out options until eventually I found 
that it's devfs that's the culprit - with that enabled I get random 
compile errors every few seconds.  With it disabled the compile works 
perfectly, even with the debian compiler (tried -j20 and -j255 and both 
passed).

My first guess was you can't use a 32bit devfsd with a 64bit kernel, but 
stopping devfsd didn't seem to make a whole lot of difference to the 
stability... only compiling out the entire devfs system solved it.

I suppose it could be insmod breaking the ehci-hcd... I'll see if I can 
find a pure 64bit one (presumably suse have one) rather than the biarch 
one that debian uses.

Tony

