Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264391AbTCXUXI>; Mon, 24 Mar 2003 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264392AbTCXUXI>; Mon, 24 Mar 2003 15:23:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:29863 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264391AbTCXUXG>;
	Mon, 24 Mar 2003 15:23:06 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Mar 2003 21:34:14 +0100 (MET)
Message-Id: <UTC200303242034.h2OKYEF21820.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Christoph Hellwig <hch@infradead.org>

    > Yes, it is more elegant to register one or more ranges.
    > (But ranges of what? Ranges in dev_t space? Or in kdev_t space?

    In dev_t space.

    I guess basically everyone will disagree with you on making kdev_t
    a different representation.  This will end up as messy as the
    internal/external dev_t stuff on some of the SVR4 ports.

You are the first to say so. I'll think about it.

A. On kdev_t vs. dev_t:
kdev_t gives small and fast code, dev_t needs a conditional
That was my main reason. I suppose you say that dev_t is a cookie
and that the kernel should never want to ask about major and minor,
except perhaps at filesystem interfaces. So the 1000+ invocations
that we have now should all go away. A reasonable point of view.

B. On what is registered:
The main question here is what the documented outside reality is.
Is that phrased in terms of dev_t intervals? Or is that phrased
in terms of (major,minor) pairs?
Until convinced otherwise I will hold that users talk about
(major,minor) pairs. They do ls -l and see major,minor pairs.
They want to do mknod and need a major,minor pair.
So I suppose that the documented reality will give a minor
range for a given major, or give a major range.
Such ranges correspond to kdev_t ranges, not to dev_t ranges.

Of course one can avoid the distinction by decreeing that
majors 0-255 cannot have more than 256 minors.

Andries
