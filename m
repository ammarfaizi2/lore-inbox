Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315816AbSEJGd3>; Fri, 10 May 2002 02:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315817AbSEJGd2>; Fri, 10 May 2002 02:33:28 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:10696 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315816AbSEJGd1>; Fri, 10 May 2002 02:33:27 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 10 May 2002 16:31:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.26975.71466.20500@notabene.cse.unsw.edu.au>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Device naming... was Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: message from Linus Torvalds on Tuesday May 7
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 7, torvalds@transmeta.com wrote:
> 
> If you have /dev/hda1, that _cannot_ be a symlink to the physical tree,
> because on a physical level that partition DOES NOT EXIST. It's purely a
> virtual mapping.
> 
> Yet clearly there _is_ a mapping from /dev/hda1 onto the physical device
> in question, and clearly it _is_ a meaninful operation to operate on the
> physical device underlying /dev/hda1.
> 
> So if you want to have a sane interface, you need to have a way to look up
> the physical device that underlies /dev/hda1.
> 
> Yet it clearly cannot be a symlink.

I have this dream about how we *should* name things in the
kernel..... but I won't bore you with that just now.

The relevant bit relates to how to map from an open-file-descriptor on
a device (or on a file on a filesystem on a device) to information
about that device.
The only piece of information we can currently get is the device
number (either st_rdev or st_dev).

Using the principle that
   "All API extenstions should be done via special filesystems"
the answer has to be that there is filesystem-like-thing that maps
device numbers to their "True Identity".
e.g.

  /kernel/devno/3/1 ->  /kernel/device/pci/0/00:1f.4/ide/0/0/pc_partition/1

Actually, I would prefer something like:

  /kernel/devno/3/1 -> /kernel/disk/3/part/1
together with
  /kernel/disk/3/bus -> /kernel/ide/0
  /kernel/disk/3/disk   BLOCK:3:0
  /kernel/disk/3/part/1 BLOCK:3:1
  /kernel/disk/3/part/2 BLOCK:3:2

  /kernel/ide/0/disk -> /kernel/disk/3
  /kernel/ide/0/bus  -> /kernel/pci/0/00:1f.4

  /kernel/pci/0/00:1f.4/ide -> /kernel/ide/0

and they would be "devlinks", not "symlinks"... but I think I might be
beginning to bore you.

NeilBrown

