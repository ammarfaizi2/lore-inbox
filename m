Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264721AbUD1KVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264721AbUD1KVb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUD1KVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:21:30 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32983 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264721AbUD1KVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:21:20 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <16527.34205.472659.465932@laputa.namesys.com>
Date: Wed, 28 Apr 2004 14:21:17 +0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: David Lang <dlang@digitalinsight.com>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
In-Reply-To: <20040428100916.GA29219@wohnheim.fh-wedel.de>
References: <408951CE.3080908@techsource.com>
	<Pine.LNX.4.58.0404271753380.20613@dlang.diginsite.com>
	<20040428100916.GA29219@wohnheim.fh-wedel.de>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:
 > On Tue, 27 April 2004 18:00:11 -0700, David Lang wrote:
 > > 
 > > to answer the fundamental question that was asked in this thread but not
 > > answered.
 > > 
 > > the reason why we want to compress at the block level instead of over the
 > > entire file is that sometimes we want to do random seeks into the middle
 > > of the file or replace a chunk in the middle of a file (edits, inserts,
 > > etc). by doing the compression in a block the worst that you have to do is
 > > to read that one block, decompress it and get your data out (or modify the
 > > block, compress it and put it back on disk). if your unit of compression
 > > is the entire file each of these options will require manipulating basicly
 > > the entire file (Ok, reads you can possibly stop after you found your
 > > data)
 > 
 > *IF* your unit of compression...
 > 
 > If that is the complete block device, you're stupid and deserve what
 > you get.  If it is the file, same thing.  No difference.
 > 
 > Do it at the file system level or don't do it at all.

File system where unit of disk space allocation is smaller than disk
block (i.e., several files can use portions of the same disk block) can
efficiently use various "units of compression": 100 bytes, device block
size, N-blocks, etc.

 > 
 > Jörn

Nikita.
