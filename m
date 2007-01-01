Return-Path: <linux-kernel-owner+w=401wt.eu-S932178AbXAAW60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXAAW60 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbXAAW60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 17:58:26 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:55103 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbXAAW6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 17:58:24 -0500
Date: Mon, 1 Jan 2007 23:58:23 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <17816.29254.497543.329777@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.64.0701012356410.5162@artax.karlin.mff.cuni.cz>
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
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The question is: why does the kernel contain iget5 function that looks up
> > according to callback, if the filesystem cannot have more than 64-bit
> > inode identifier?
>
> Generally speaking, file system might have two different identifiers for
> files:
>
> - one that makes it easy to tell whether two files are the same one;
>
> - one that makes it easy to locate file on the storage.
>
> According to POSIX, inode number should always work as identifier of the
> first class, but not necessary as one of the second. For example, in
> reiserfs something called "a key" is used to locate on-disk inode, which
> in turn, contains inode number. Identifiers of the second class tend to

BTW. How does ReiserFS find that a given inode number (or object ID in 
ReiserFS terminology) is free before assigning it to new file/directory?

Mikulas

> live in directory entries, and during lookup we want to consult inode
> cache _before_ reading inode from the disk (otherwise cache is mostly
> useless), right? This means that some file systems want to index inodes
> in a cache by something different than inode number.
