Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269334AbRHCGyg>; Fri, 3 Aug 2001 02:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269332AbRHCGy1>; Fri, 3 Aug 2001 02:54:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:7949 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S269331AbRHCGyL>; Fri, 3 Aug 2001 02:54:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Date: Fri, 3 Aug 2001 16:53:34 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15210.19054.503792.982041@notabene.cse.unsw.edu.au>
Cc: dcinege@psychosis.com, linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: md.c - devfs naming fix.
In-Reply-To: message from Richard Gooch on Tuesday July 31
In-Reply-To: <3B1AF531.C31CB45C@psychosis.com>
	<200107312139.f6VLdRp00491@mobilix.ras.ucalgary.ca>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 31, rgooch@ras.ucalgary.ca wrote:
> Dave Cinege writes:
> > This is a multi-part message in MIME format.
> 
> Yuk! MIME!
> 
> > Changes:
> > 	Cleaned a few printk's
> > 
> > 	Removed a meaningless ifndef.
> > 
> > 	Moved md= name_to_ kdev_t() processing from md_setup() to
> > 	md_setup_drive. Rewrote it and added devfs_find_handle() call
> > 	to support devfs names for md=. 
> > 
> > The devfs_find_handle() code is now redundant in my patch and
> > fs/super.c::mount_root(). It probably should be moved directly into
> > name_to_kdev_t(), no? If this was done the md= code would have
> > worked as is, except for the devfs code choking on the trailing ','
> > in the device_names list. (Richard, want to check for this in the
> > future?)
> 
> What is this patch trying to fix? I've been running devfs with MD
> devices for a long time and have no problems. My raidtab lists devfs
> device names (in fact, the /dev/sd/* variants created by devfsd) and
> it seems to work fine.

You can start a raid array at boot time with a boot parameter like:

  md=0,/dev/somedisc,/dev/otherdisc,/dev/thatoneoverthere

However, this only worked for device names that were hard coded into
init/main.c.  Devices which only had names in devfs couldn't be
recognised.

The patch delayed the processing of the names in an md= line until
after devfs was initialised, and the made sure that devfs had a chance
to look at them.

> 
> > This diff is against md.c in 2.4.4.
> > Comments/testing please.
> 
> Have you received any other comments? I've not tracked this.

The patch is already in Linus' tree.

NeilBrown

> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
