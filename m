Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUGTUnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUGTUnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUGTUnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:43:40 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:48791 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266234AbUGTUnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:43:37 -0400
Date: Tue, 20 Jul 2004 13:42:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, nathans@sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL and XFS on 4KSTACKS=n
Message-ID: <20040720204238.GA3051@taniwha.stupidest.org>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720195012.GN14733@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 09:50:12PM +0200, Adrian Bunk wrote:

> 1. let 4KSTACKS depend on EXPERIMENTAL

i don't like this change, despite what i might have claimed earlier :)

the reason i say this is if XFS blows up with 4K stacks then it
probably can with 8K stacks but it will be much harder, so it's not
really fixing anything but just papering over the problem

the reason for this is 8K stacks means you don't have separate irq
stacks, so if and interrupt comes along at the right time and the
codes paths are just right, you can still overflow (arguably you have
less overall space than with 4K stacks and separate irq stacks)

that said, separate irq stacks *and* 8k thread stacks would be safe,
but i'd love to see ideas on how to get the stack utilization down
(it's actually really hard)


  --cw
