Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264393AbTCXU26>; Mon, 24 Mar 2003 15:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264395AbTCXU25>; Mon, 24 Mar 2003 15:28:57 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:47622 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264393AbTCXU2x>; Mon, 24 Mar 2003 15:28:53 -0500
Date: Mon, 24 Mar 2003 20:39:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Message-ID: <20030324203957.A24112@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
References: <UTC200303242034.h2OKYEF21820.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303242034.h2OKYEF21820.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Mar 24, 2003 at 09:34:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 09:34:14PM +0100, Andries.Brouwer@cwi.nl wrote:
> A. On kdev_t vs. dev_t:
> kdev_t gives small and fast code, dev_t needs a conditional
> That was my main reason. I suppose you say that dev_t is a cookie
> and that the kernel should never want to ask about major and minor,
> except perhaps at filesystem interfaces. So the 1000+ invocations
> that we have now should all go away. A reasonable point of view.

Yupp.  And you'll notice that we're almost there for block devices
already.

> B. On what is registered:
> The main question here is what the documented outside reality is.
> Is that phrased in terms of dev_t intervals? Or is that phrased
> in terms of (major,minor) pairs?
> Until convinced otherwise I will hold that users talk about
> (major,minor) pairs. They do ls -l and see major,minor pairs.
> They want to do mknod and need a major,minor pair.
> So I suppose that the documented reality will give a minor
> range for a given major, or give a major range.

Well, users can do that if it makes their live easier.  The kernel
doesn't need nor should know about this split internally.  There's
a few legacy interfaces left that hardcode this split, but it's
okay - no one expects the major/minor split to have more meaning
than __low/__high anyway - we already have far too many subsystems
that hand out ranges (or in the case of sound individual dev_t s)
to drivers.

> Of course one can avoid the distinction by decreeing that
> majors 0-255 cannot have more than 256 minors.

It might be a wise idea to not use them to avoid subtile driver
breakage unless we do a full audit, yes.
