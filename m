Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUHRJQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUHRJQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 05:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUHRJQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 05:16:23 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25862 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265232AbUHRJPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 05:15:53 -0400
Date: Wed, 18 Aug 2004 10:15:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040818101540.A30983@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dave Jones <davej@redhat.com>,
	=?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040817220816.GA14343@hardeman.nu> <20040817233732.GA8264@redhat.com> <20040818004339.A27701@infradead.org> <20040817234522.GA4170@redhat.com> <1092801681.27352.194.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1092801681.27352.194.camel@bach>; from rusty@rustcorp.com.au on Wed, Aug 18, 2004 at 02:01:21PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 02:01:21PM +1000, Rusty Russell wrote:
> Thx for reminder.  Polished up the drm stuff: this compiles.  Of course,
> as Christoph would say, it's still shit.  However, the turd is now more
> polished.
> 
> Dave, please consider removing the piggybacking of DRM module stubs; it
> is the cause of this horror.  I don't know enough to know what that
> would break.

Actually this is is a classic example of over-engineering (not on your side
but the original drm side). IF a normal driver supports pci and isa devices
it depends on PCI || ISA and has ifdefs or stubs for both.

Similarly drm should depend on AGP for those cards where there are only
AGP versions (most of them) and the driver where pci is also posisble (some
ati driver only IIRC) could compile with or withut but I'd be a compile-time
thing.

