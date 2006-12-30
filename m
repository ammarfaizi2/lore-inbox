Return-Path: <linux-kernel-owner+w=401wt.eu-S1030190AbWL3BEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWL3BEr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWL3BEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:04:47 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:40050 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030190AbWL3BEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:04:46 -0500
Date: Sat, 30 Dec 2006 02:04:45 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <1167388475.6106.51.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> 
 <1166869106.3281.587.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> 
 <4593890C.8030207@panasas.com>  <1167300352.3281.4183.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
 <1167388475.6106.51.camel@lade.trondhjem.org>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Trond Myklebust wrote:

> On Thu, 2006-12-28 at 19:14 +0100, Mikulas Patocka wrote:
>> Why don't you rip off the support for colliding inode number from the
>> kernel at all (i.e. remove iget5_locked)?
>>
>> It's reasonable to have either no support for colliding ino_t or full
>> support for that (including syscalls that userspace can use to work with
>> such filesystem) --- but I don't see any point in having half-way support
>> in kernel as is right now.
>
> What would ino_t have to do with inode numbers? It is only used as a
> hash table lookup. The inode number is set in the ->getattr() callback.

The question is: why does the kernel contain iget5 function that looks up 
according to callback, if the filesystem cannot have more than 64-bit 
inode identifier?

This lookup callback just induces writing bad filesystems with coliding 
inode numbers. Either remove coda, smb (and possibly other) filesystems 
from the kernel or make a proper support for userspace for them.

The situation is that current coreutils 6.7 fail to recursively copy 
directories if some two directories in the tree have coliding inode 
number, so you get random data corruption with these filesystems.

Mikulas
