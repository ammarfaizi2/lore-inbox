Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVCVTRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVCVTRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCVTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:17:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31242 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261667AbVCVTRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:17:03 -0500
Date: Tue, 22 Mar 2005 20:17:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322191702.GF1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de> <20050322185605.GB27733@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322185605.GB27733@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 07:56:05PM +0100, Jörn Engel wrote:
> On Tue, 22 March 2005 18:13:40 +0100, Adrian Bunk wrote:
> > 
> > REISER4_FS is the only option with a dependency on !4KSTACKS which is 
> > bad since 8 kB stacks on i386 won't stay forever.
> > 
> > Could fix the problems with 4 kB stacks?
> > 
> > Running
> > 
> >   make checkstacks | grep reiser4
> > 
> > inside te kernel sources after compiling gives you hints where problems 
> > might come from.
> 
> Actually, I've run the Big Ol' checkstack program on reiser4 once.
> Without recursions, the code is well below 3k, but some of the
> recursions look a bit daunting.  Here is the relevant output:
>...
>      404  jnode_flush
>...
>      460  rename_hashed
>...
>      224  coord_by_key
>...

These would have been missed by the grep I suggested due to the missing 
reiser4_ prefix.

>      208  locks_remove_flock
>...

That seems to be a generic issue in fs/locks.c .
It seems this is the "struct file_lock fl"?

> Jörn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

