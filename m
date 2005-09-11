Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVIKWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVIKWUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbVIKWUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:20:43 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:22552 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbVIKWUm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:20:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5gXAHId3FRddCiwSKYAm+M/CCgCTFkp5tVIMGf78BNccruFpyqPpWDYFpM2OFqjohCp/ZFViHkmKmagntPPNHOeCB5d9C/K/UK6FNTYWoyN0Gc7wIrI2CmNPj08F0l6XG6PYlU3ixfBpKDchpK6RakepXiJ1f9pNRLwCHZK6eE=
Message-ID: <9a8748490509111520186dcf0c@mail.gmail.com>
Date: Mon, 12 Sep 2005 00:20:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Tom Watson <tsw@johana.com>
Subject: Re: Pruning the source tree (idea)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4324A817.8050004@johana.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4324A817.8050004@johana.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/05, Tom Watson <tsw@johana.com> wrote:
> In downloading the whole source tree for the 2.6 kernel, I note that
> there is quite a bit of code relating to architectures other than the
> one I'm using.  While this is a "good thing", it does take up space and if
> I search for something in the kernel (grep, or some such), the non-used
> architectures can take up additional time.
> 

The arch specifics don't take up /that/ much space : 

juhl@dragon:~/download/kernel/linux-2.6.13/arch$ du -hc --max-depth=1
1.7M    ./sh
1.7M    ./um
4.6M    ./arm
722K    ./frv
5.7M    ./ppc
2.7M    ./i386
1.5M    ./cris
801K    ./m32r
2.5M    ./ia64
4.3M    ./m68k
4.7M    ./mips
901K    ./s390
474K    ./v850
637K    ./sh64
1.6M    ./alpha
930K    ./arm26
333K    ./h8300
2.5M    ./ppc64
1.3M    ./sparc
1.7M    ./sparc64
1.7M    ./parisc
1.2M    ./x86_64
505K    ./xtensa
745K    ./m68knommu
45M     .
45M     total

juhl@dragon:~/download/kernel/linux-2.6.13/include$ du -hc --max-depth=0 asm-*
763K    asm-alpha
3.1M    asm-arm
515K    asm-arm26
2.4M    asm-cris
551K    asm-frv
177K    asm-generic
447K    asm-h8300
1.1M    asm-i386
1.2M    asm-ia64
583K    asm-m32r
881K    asm-m68k
832K    asm-m68knommu
2.7M    asm-mips
687K    asm-parisc
1.3M    asm-ppc
884K    asm-ppc64
631K    asm-s390
960K    asm-sh
443K    asm-sh64
900K    asm-sparc
880K    asm-sparc64
540K    asm-um
535K    asm-v850
768K    asm-x86_64
723K    asm-xtensa
24M     total

So we are talking about less than 100MB, and it's even fairly simple
for you to clean it out by hand if you want. I must admit I don't see
the point of having to maintain such a makefile target.  If you want
to delete the archs that don't matter to you, fine, just do that by
hand then or write a small script for it.


> A proposal:
> Have a top level make target that prunes (deletes summarily) the
> unwanted architectures from the source tree.  This should be able to be
> done before, or after a config step, but might not be allowed after the
> first make.  Of course, this step is optional, but for those of us who
> only have a single machine type, it would save a bunch of time.
> 
Submit a patch to implement it then.


Personally I don't think this matters or is a good idea.

It doesn't save that much space (<100MB doesn't matter much with the
several hundred gigabyte HD's of today), and it's easy for someone to
delete locally, by hand, if they want to.

As for the "it speeds up grep" argument, that doesn't hold water, you
can just use the --include and --exclude arguments for grep to only
search relevant dirs.

Including a makefile target that does this would also add one more
thing to maintain and keep working for little gain.

There's also the issue of patching the kernel post-pruning. When you
want to upgrade the source of a pruned kernel, lots of the patch for
the next kernel version won't apply any longer.


No, let's not do this, is my oppinion..


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
