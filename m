Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRGJNl5>; Tue, 10 Jul 2001 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266181AbRGJNlr>; Tue, 10 Jul 2001 09:41:47 -0400
Received: from ns.suse.de ([213.95.15.193]:50185 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265149AbRGJNlo>;
	Tue, 10 Jul 2001 09:41:44 -0400
Date: Tue, 10 Jul 2001 15:41:35 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andi Kleen <ak@suse.de>, Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010710154135.A4603@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu.suse.lists.linux.kernel> <oupbsmueyv8.fsf@pigdrop.muc.suse.de> <20010711013311.B31799@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711013311.B31799@weta.f00f.org>; from cw@f00f.org on Wed, Jul 11, 2001 at 01:33:11AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 01:33:11AM +1200, Chris Wedgwood wrote:
> On Mon, Jul 09, 2001 at 08:33:31PM +0200, Andi Kleen wrote:
> 
>     Actually all the file systems who do that on Linux (JFS, XFS,
>     reiserfs) have fixed the issue properly server side, by adding a
>     layer that generates stable cookies. You should too.
> 
> I've always thought that was a stupid fix. Why not have the clients be
> smarted and make them responsible for getting a new cookie if the old
> one is hosed?

Because to get that new cookie you would need another cookie; otherwise
you could violate the readdir guarantee that it'll never return files
twice.

> For linux, with the dcache, I'm not even sure that this would be all
> the hard. Persumable Solaris could (does?) do the same?

dcache is not populated on readdir for good reasons (it would 
require reading the inodes and tie a of lot of memory) and you would need
to lock all the dcache entries belong to a directory while a nfs readdir;
tieing up even more memory. Also a readdir() is not bounded in time.

BTW; the cookie issue is not an NFS only problem. It occurs on local
IO as well. Just consider rm -rf - reading directories and in parallel
deleting them (the original poster's file system would have surely
gotten that wrong). Another tricky case is telldir().  


-Andi
