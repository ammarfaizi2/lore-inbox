Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754637AbWKHSRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbWKHSRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbWKHSRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:17:47 -0500
Received: from smtp-out.google.com ([216.239.45.12]:1886 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1754637AbWKHSRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:17:46 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=WwfQKDQ9F61kIfmS2i1TFj2u2mCkIYhMIfr9Y09ikz+aejIaUULHxYGJjh1qlWqOy
	Xu6/LZl2QjOWSV2vK1gQg==
Message-ID: <8f95bb250611081017lf8171e9y30e404e4a4336e89@mail.gmail.com>
Date: Wed, 8 Nov 2006 10:17:32 -0800
From: "Aaron Durbin" <adurbin@google.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Cc: "Adrian Bunk" <bunk@stusta.de>, "Matthew Wilcox" <matthew@wil.cx>,
       "Andi Kleen" <ak@suse.de>, "Jeff Chua" <jeff.chua.linux@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
	 <20061107171143.GU27140@parisc-linux.org>
	 <200611080839.46670.ak@suse.de>
	 <20061108122237.GF27140@parisc-linux.org>
	 <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
	 <20061108172650.GC4729@stusta.de>
	 <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 8 Nov 2006, Adrian Bunk wrote:
> > >
> > > Anyway, I do not consider this a regression. MMCONFIG has _never_ worked
> > > reliably. It has always been a case of "we can make it work on some
> > > machines by making it break on others".
> >
> > It is a serious regression:
> >
> > The problem is that with the default CONFIG_PCI_GOANY, MMCONFIG is the
> > _first_ method tried.
>
> No. That was a bug at some point, but it's not that way now. See
>
>         pci_access_init(void)
>
> which checks the pci_direct_probe() first, and only _then_ calls
> pci_mmcfg_init(). And pci_mmcfg_init() will refuse to even use MMCONFIG
> unless either the direct probe failed _or_ the MMCONFIG area is marked
> entirely reserved in the e820 tables. Exactly because MMCONFIG generally
> doesn't _work_.
>

It appears in both i386 and x86-64 that the check is only on the first MCFG
entry and it only checks a hard-coded value of 16 buses.  This check is only
done if pci access type == 1.  The patches I posted yesterday have a few more
checks and warnings concerning the MCFG region, but these checks are only for
the resource allocation.  They do not concern actual config access. With those
patches applied we should be at least able to track more buggy BIOS's provided
that people notice messages in their dmesg.

-Aaron
