Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTARUSo>; Sat, 18 Jan 2003 15:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTARUSo>; Sat, 18 Jan 2003 15:18:44 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:6529 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S265039AbTARUSg>;
	Sat, 18 Jan 2003 15:18:36 -0500
Date: Sat, 18 Jan 2003 21:27:23 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Raja R Harinath <harinath@cs.umn.edu>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, alsa-devel@alsa-project.org,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Message-ID: <20030118202723.GA27477@vana.vc.cvut.cz>
References: <20030117155717.A6250@baldur.yggdrasil.com> <d9n0lz18an.fsf@bose.cs.umn.edu> <20030118031319.GA19982@vana.vc.cvut.cz> <d9bs2e8o0b.fsf@bose.cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bs2e8o0b.fsf@bose.cs.umn.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 09:40:36AM -0600, Raja R Harinath wrote:
> > -	if (fd == -1)
> > +	filp = filp_open(fn, 0, 0);
> > +	if (IS_ERR(filp))
> >  	{
> >  		printk(KERN_INFO "Unable to load '%s'.\n", fn);
> >  		return 0;
> >  	}
> [snip]
> 
> I noticed that do_mod_firmware_load is wrapped by a
> set_fs(get_gs())/set_fs(fs) pair in mod_firmware_load, presumably
> because it performs an 'int 0x80' kernel syscall in there.  The
> cleanup to use the VFS directly should probably kill the wrapper too.

vfs_read expects userspace pointer, so we must do set_fs() at least
around vfs_read, and so I left it around whole function, to minimize
changes in code.

In original message I asked whether I should convert firmware loader to 
the "if (error) goto quit;" style to move error handling to one place, 
but only answer I got was 'Ask Rob' ;-)

And as I do not have sound hardware which needs firmware, I do not
want to make more changes than absolutely necessary to the code I cannot
verify. Of course if you'll find someone with hardware...
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
