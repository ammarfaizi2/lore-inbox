Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289398AbSAODuK>; Mon, 14 Jan 2002 22:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289395AbSAODuA>; Mon, 14 Jan 2002 22:50:00 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:40701 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289394AbSAODtq>;
	Mon, 14 Jan 2002 22:49:46 -0500
Date: Mon, 14 Jan 2002 20:48:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Theodore Tso <tytso@mit.edu>, Juan Quintela <quintela@mandrakesoft.com>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020114204830.E26688@lynx.adilger.int>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Theodore Tso <tytso@mit.edu>,
	Juan Quintela <quintela@mandrakesoft.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
	andersen@codepoet.org
In-Reply-To: <20020114165849.B26688@lynx.adilger.int> <Pine.LNX.4.44.0201141921580.2836-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0201141921580.2836-100000@waste.org>; from oxymoron@waste.org on Mon, Jan 14, 2002 at 07:26:54PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  19:26 -0600, Oliver Xymoron wrote:
> On Mon, 14 Jan 2002, Andreas Dilger wrote:
> > Actually, the whole point of Juan's suggestion was that you _don't_ want
> > to fsck a filesystem that is currently mounted.  There is always a
> > potential problem that fsck will change the on-disk data of the filesystem
> > in a way that is not coherent with what the kernel has in-memory, which
> > should force a system reboot before continuing (which most initscripts
> > don't do).  For ext2/ext3 this may be relatively safe (data/metadata don't
> > move around much), but reiserfsck cannot (or will not) fsck a mounted
> > filesystem at all.
> 
> Interesting point. Modulo any existing LVM brokenness, we can do this with
> a read-only snapshot and pivot_root afterwards. Alternately, a read-only
> /bootsupport or something of the sort which contains *fsck. What we don't
> want is initramfs to get big.

Err, you think putting the necessary LVM tools in initramfs (vgscan,
vgchange, lvcreate, liblvm) will be _smaller_ than e2fsck???  Your
"modulo" is also a very big one - I'd rather trust e2fsck than LVM
in my boot environment any day.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

