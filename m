Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266237AbSKGAT5>; Wed, 6 Nov 2002 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266238AbSKGAT4>; Wed, 6 Nov 2002 19:19:56 -0500
Received: from pc132.utati.net ([216.143.22.132]:44417 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S266237AbSKGATz> convert rfc822-to-8bit; Wed, 6 Nov 2002 19:19:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [lkcd-devel] Re: What's left over.
Date: Wed, 6 Nov 2002 19:24:07 +0000
User-Agent: KMail/1.4.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu> <m1heevfiih.fsf@frodo.biederman.org>
In-Reply-To: <m1heevfiih.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211061924.07801.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 November 2002 04:07, Eric W. Biederman wrote:

> Personally I would love to be able to allocate one big contiguous
> buffer that the kernel is not using and neither is the image I will
> eventually load.  Then I could just memcpy from that buffer and I
> would be done.
>
> Alas memory management in the kernel is done in pages, and can be
> fragmented after running for many moons.  So I need to allocate all of
> my memory in pages, and I need to let the kernel know where it will
> all eventually live so I can correctly order the memcpy operations.

Reverse Mappings are cool, and one reason tehy're cool is, in theory, you can 
grab a page of physical memory away from something else.  In theory code 
could be written to ask the kernel "could you please swap this the heck out, 
pin the page in memory, and give it to me instead now?"  And it can refuse 
("it's already pinned by something else, maybe it's a kernel page, go away"), 
it can block a bit ("gotta flush it to disk, wait until DMA is done"), or it 
could immediatley comply ("it was a clean buffer, have it, keep it, stuff it 
and mount it on the wall for all I care...").

This means you can retroactively get contiguous areas of memory by shoving 
stuff aside.  If it's in use, it'll swap back in immediately.  (An obvious 
optimization occurs, but that's not necessary for minimal functionality.)

So the the whole problem of needing contiguous areas of memory could, in 
theory, be addressed using RMAP.

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
