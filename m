Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDXWCP>; Tue, 24 Apr 2001 18:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132313AbRDXWCF>; Tue, 24 Apr 2001 18:02:05 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:16553 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131643AbRDXWBv>; Tue, 24 Apr 2001 18:01:51 -0400
Date: Wed, 25 Apr 2001 00:01:20 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolinux.com>, Christoph Rohland <cr@sap.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010425000120.M719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200104241837.f3OIb0ii016925@webber.adilger.int> <Pine.GSO.4.21.0104241441560.6992-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0104241441560.6992-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Apr 24, 2001 at 02:49:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 02:49:23PM -0400, Alexander Viro wrote:
> On Tue, 24 Apr 2001, Andreas Dilger wrote:
> > One thing to watch out for is that the current code zeros the u. struct
> > for us (as you pointed out to me previously), but allocating from the
> > slab cache will not...  This could be an interesting source of bugs for
> > some filesystems that assume zero'd inode_info structs.
> True, but easy to catch.

Jepp. Just request SLAB_ZERO (still to be implemented) instead of
SLAB_POISON or provide an constructor.

A nice set of macros for this would make it quite easy. The ctor
is the way to handle it. May be we could even put all the fs
specific initalizers into it (e.g. magics, zeroes).

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
