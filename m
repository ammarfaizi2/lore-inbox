Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUDWRXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUDWRXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUDWRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:23:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:516 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262176AbUDWRXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:23:42 -0400
Message-ID: <408951CE.3080908@techsource.com>
Date: Fri, 23 Apr 2004 13:26:38 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: File system compression, not at the block layer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably just another of my silly "they already thought of that 
and someone is doing exactly this" ideas.

I get the impression that a lot of people interested in doing FS 
compression want to do it at the block layer.  This gets complicated, 
because you need to allocate partial physical blocks.

Well, why not do the compression at the highest layer?

The idea is something akin to changing this (syntax variation intentional):

    tar cf - somefiles* > file

To this:

    tar cf - somefiles* | gzip > file

Except doing it transparently and for all files.

This way, the disk cache is all compressed data, and only decompressed 
as it's read or written by a process.

For files below a certain size, this is obviously pointless, since you 
can't save any space.  But in many cases, this could speed up the I/O 
for large files that are compressable.  (Space is cheap.  The only 
reason to compress is for speed.)

