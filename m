Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRKXKyz>; Sat, 24 Nov 2001 05:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbRKXKyp>; Sat, 24 Nov 2001 05:54:45 -0500
Received: from gate.mesa.nl ([194.151.5.70]:60943 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S275990AbRKXKy0>;
	Sat, 24 Nov 2001 05:54:26 -0500
Date: Sat, 24 Nov 2001 11:54:11 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011124115411.C25094@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9tmocg$jfn$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Nov 23, 2001 at 04:07:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:07:44PM -0800, H. Peter Anvin wrote:
> Followup to:  <20011123155901.C1308@lynx.no>
> By author:    Andreas Dilger <adilger@turbolabs.com>
> In newsgroup: linux.dev.kernel
> > 
> > Don't do that.  That is only good if the filesystem thinks that there
> > is no journal, or it is using a hidden inode for the journal (i.e. if
> > you run "tune2fs -l /dev/whatever" and it doesn't have "has_journal"
> > listed in the filesystem features (this is what happened with 2.4.10).
> > Otherwise, you will delete your real journal, tune2fs will complain,
> > and then you will need to run e2fsck to clean up after yourself, before
> > re-creating your journal again.
> > 
> > If you have a filesystem with a .journal file, and you want to "hide"
> > it, just run e2fsck 1.25 while the filesystem is unmounted, and it
> > will do it for you.  If you don't want to have a .journal in the first
> > place, run tune2fs -j while the filesystem is unmounted.
> > 
> 
> This is all fine and good except for the root partition (I'm pleased
> to hear that e2fsck 1.25 will move the journal to the hidden inode for
> non-root partitions.)  It would be nice if this was done automagically
> by the mounting code instead of by fsck; that way migration would
> truly be painless.

Hm, the e2fsck check does not work for me...
The .journal file still exists after

   # umount /dev/hda11
   # e2fsck -f /dev/hda11
   # mount /dev/hda11
   # rpm -q e2fsprogs
   e2fsprogs-1.25-1

(on redhat rawhide)


-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
