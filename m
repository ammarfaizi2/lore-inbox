Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVHHQIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVHHQIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVHHQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:08:35 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:60085 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932096AbVHHQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:08:35 -0400
Date: Mon, 8 Aug 2005 18:08:38 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to reclaim inode pages on demand
Message-ID: <20050808160838.GB17978@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0508081650160.26013@skynet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 August 2005 16:52:52 +0100, Mel Gorman wrote:
> 
> I am working on a direct reclaim strategy to free up large blocks of
> contiguous pages. The part I have is working fine, but I am finding a
> hundreds of pages that are being used for inodes that I need to reclaim. I
> tried purging the inode lists using a variation of prune_icache() but it
> is not working out.
> 
> Given a struct page, that one knows is an inode, can anyone suggest the
> best way to find the inode using it and free it?

A struct page ain't an inode.  So I'm assuming you mean something like
"giving a struct page that is known to be part of the inode slab
cache".

In that case, you have to decide how intimate you want the slab code
and your page/inode reclaim code to be.  You could use slab structures
to find out the (ofs,len) tupel of contained structures, cast those
to a struct inode and then continue.  Whether you actually want that,
depends on your moral standards.

Jörn

-- 
I don't understand it. Nobody does.
-- Richard P. Feynman
