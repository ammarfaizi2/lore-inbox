Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286190AbRLJIOR>; Mon, 10 Dec 2001 03:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286191AbRLJIN4>; Mon, 10 Dec 2001 03:13:56 -0500
Received: from zero.tech9.net ([209.61.188.187]:43782 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286190AbRLJINs>;
	Mon, 10 Dec 2001 03:13:48 -0500
Subject: Re: "Colo[u]rs"
From: Robert Love <rml@tech9.net>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011210024959.01c81c20@whisper.qrpff.net>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>
	<5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net> 
	<5.1.0.14.2.20011210024959.01c81c20@whisper.qrpff.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 03:13:55 -0500
Message-Id: <1007972036.1237.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 03:00, Stevie O wrote:

> For the n-way associative deal:

If the cache is n-way associative, it can store n lines at each
mapping.  So even though two virtual addresses map to the same cache
line, they can both be stored.  Of course, if you have k addresses such
that k>n, then you reach the same problem as direct map (the case where
n=1) caches.

To reiterate, the point of coloring would be to prevent the case of
multiple addresses mapping to the same line.  Let me give you a
real-life example.  We recently have been trying to color the kernel
stack.  If every process's stack lies at the same address (let alone the
same page multiple and offset), then they all map to the same place in
the cache and we can effectively only cache one of them (and
subsequently cache miss on every other access).  If we "color" the
location of the stack, we make sure they don't all map to the same
place.  This obviously involves some knowledge of the cache system, but
it tends to be general enough that we can get it right for all cases.

If you are _really_ interested in this, an excellent and very thorough
book is UNIX Systems for Modern Architectures: Symmetric Multiprocessing
and Caching for Kernel Programmers, by Curt Schimmel.

	Robert Love

