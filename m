Return-Path: <linux-kernel-owner+w=401wt.eu-S1754757AbXAAXW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbXAAXW4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXAAXW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:22:56 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:56910 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbXAAXWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:22:55 -0500
Date: Tue, 2 Jan 2007 00:22:54 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <17817.37844.730977.13636@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.64.0701020018330.5162@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
 <1167388475.6106.51.camel@lade.trondhjem.org>
 <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
 <17816.29254.497543.329777@gargle.gargle.HOWL>
 <Pine.LNX.4.64.0701012356410.5162@artax.karlin.mff.cuni.cz>
 <17817.37844.730977.13636@gargle.gargle.HOWL>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > BTW. How does ReiserFS find that a given inode number (or object ID in
> > ReiserFS terminology) is free before assigning it to new file/directory?
>
> reiserfs v3 has an extent map of free object identifiers in
> super-block.

Inode free space can have at most 2^31 extents --- if inode numbers 
alternate between "allocated", "free". How do you pack it to superblock?

> reiser4 used 64 bit object identifiers without reuse.

So you are going to hit the same problem as I did with SpadFS --- you 
can't export 64-bit inode number to userspace (programs without 
-D_FILE_OFFSET_BITS=64 will have stat() randomly failing with EOVERFLOW 
then) and if you export only 32-bit number, it will eventually wrap-around 
and colliding st_ino will cause data corruption with many userspace 
programs.

Mikulas
