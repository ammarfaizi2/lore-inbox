Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVKVHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKVHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVKVHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:51:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60321 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932225AbVKVHv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:51:57 -0500
Date: Tue, 22 Nov 2005 07:51:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122075148.GB20476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
	linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121101959.GB13927@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o 128 bit
>   On 32bit machines, you can't even fully utilize a 64bit filesystem
>   without VFS changes.  Have you ever noticed?  Thought so.

What is a '128 bit' or '64 bit' filesystem anyway?  This description doesn't
make any sense,  as there are many different things that can be
addresses in filesystems, and those can be addressed in different ways.
I guess from the marketing documents that they do 128 bit _byte_ addressing
for diskspace.  All the interesting Linux filesystems do _block_ addressing
though, and 64bits addressing large enough blocks is quite huge.
128bit inodes again is something could couldn't easily implement, it would
mean a non-scalar ino_t type which guarantees to break userspace.  128
i_size?  Again that would totally break userspace because it expects off_t
to be a scalar, so every single file must fit into 64bit _byte_ addressing.
If the surrounding enviroment changes (e.g. we get a 128bit scalar type
on 64bit architectures) that could change pretty easily, similarly to how
ext2 got a 64bit i_size during the 2.3.x LFS work.
