Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRKSKbF>; Mon, 19 Nov 2001 05:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277568AbRKSKar>; Mon, 19 Nov 2001 05:30:47 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:14054 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277533AbRKSKaH>; Mon, 19 Nov 2001 05:30:07 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 19 Nov 2001 21:30:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.57148.518049.713010@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Andreas Dilger on Monday November 19
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
	<E164gCQ-0003YZ-00@the-village.bc.nu>
	<15352.32969.717938.153375@notabene.cse.unsw.edu.au>
	<20011119015242.B1308@lynx.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 19, adilger@turbolabs.com wrote:
> On Nov 19, 2001  14:47 +1100, Neil Brown wrote:
> >  - devfs puts a lot of miscellaneous stuff in the top level.
> >    I would want to group them into one namespace. e.g.:
> >        misc/memory/mem
> >        misc/memory/kmem
> >        misc/memory/zero
> >        misc/memory/null
> >        misc/random/random
> >        misc/random/urandom
> 
> Erm, what about the millions+ of scripts/apps that reference /dev/zero
> or /dev/null?

# ln -s misc/memory/null /dev/null
# mknod /dev/null c 0 0

I was talking about how naming should look inside the kernel.  The
names that are presented to user-space are up to user-space.  The
names that are used internally should make sense internally.
mknod is there to provide a gateway between the two.

Devfs defines internal names which are, to some extent, chosen to
match expected external names.  This is putting policy in the kernel,
which is one of the complaints about devfs.
Devfs actually has a bit each way.  There is a concept of "compatible"
names which are imposed on devfs by devfsd, so that internal names
don't have to match external names.  But many interal names do still
match historical external names.

I would like a very well defined and rigidly adhered to structure for
internal names.  This should be chosen to match the internal (actual
or planned) of the kernel.  And there should be a mechanism to allow
user-space to define external names to map to those internal names.

NeilBrown
