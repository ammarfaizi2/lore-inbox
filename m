Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVBWUKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVBWUKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVBWUKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:10:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:24723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261547AbVBWUJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:09:55 -0500
Date: Wed, 23 Feb 2005 12:09:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: zensonic@zensonic.dk (Thomas S. Iversen)
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in
 __find_get_block_slow
Message-Id: <20050223120928.133778a4.akpm@osdl.org>
In-Reply-To: <20050223130251.GA31851@zensonic.dk>
References: <4219BC1A.1060007@zensonic.dk>
	<20050222011821.2a917859.akpm@osdl.org>
	<20050223120013.GA28169@zensonic.dk>
	<20050223041036.5f5df2ff.akpm@osdl.org>
	<20050223130251.GA31851@zensonic.dk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zensonic@zensonic.dk (Thomas S. Iversen) wrote:
>
> > OK, so we're looking for the buffer_head for block 101 and the first
> > buffer_head which is attached to the page represents block 100.  So the
> > next buffer_head _should_ represent block 101.  Please print it out:
> 
> Not quite the same, but simelar:
> 
> Feb 23 14:50:24 localhost kernel: __find_get_block_slow() failed. block=102,
> b_blocknr=128, next=129
> Feb 23 14:50:24 localhost kernel: b_state=0x00000013, b_size=2048
> Feb 23 14:50:24 localhost kernel: device blocksize: 2048
> Feb 23 14:50:24 localhost kernel: ------------[ cut here ]------------

Something has caused the page at offset 51 (block 102) to have buffer_heads
for blocks 128 and 129 attached to it.

> > Could be UFS.  But what does "transparent block encryption and sector
> > shuffling" mean?  How is the sector shuffling implemented?
> 
> GDBE is a block level encrypter. It encrypts the actual sectors
> transparently via the GEOM API (corresponds to the devicemapper api in linux).
> 
> GBDE assigns a key for each block, thereby introducing keysectors.
> Furthermore the sectors are remapped so that one can not guess where e.g.
> metadata is located on the physical disk. It is a rather simple remap:

I'd be suspecting that the sector remapping is the cause of the problem. 
How is it implemented?
