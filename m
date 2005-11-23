Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVKWCii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVKWCii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVKWCii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:38:38 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:63107 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932451AbVKWCih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:38:37 -0500
Date: Wed, 23 Nov 2005 03:38:25 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Message-ID: <20051123023825.GA11869@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Al Viro <viro@ftp.linux.org.uk>, Neil Brown <neilb@suse.de>,
	linux-kernel@vger.kernel.org
References: <17283.52960.913712.454816@cse.unsw.edu.au> <20051123021545.GP27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123021545.GP27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.233.80
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 02:15:45AM +0000, Al Viro wrote:
> On Wed, Nov 23, 2005 at 01:07:28PM +1100, Neil Brown wrote:
> > After putting in copious tracing printk, the offending test is:
> > 
> > 	if (user_nd.mnt->mnt_parent == user_nd.mnt)
> > 		goto out2; /* not attached */
> > 
> > If I remove this, it works (or seems to).
> > Presumably the initial root file system is 'not attached'.  But that
> > shouldn't be a problem, should it?
> 
> Initial root is root and will remain root, period.
> 
> > Could this be related to the new shared mounts stuff???
> 
> No.  And no, it's not going to change - any memory you win on killing
> initramfs is not going to be worth the extra code needed to special-case
> it.
> 
> pivot_root() does work in chroot jail (including the one we get after
> chrooting to "final" root), but that's all it does.

Just want to add that some nice person wrote
Documentation/filesystems/ramfs-rootfs-initramfs.txt.

http://lwn.net/Articles/156098/
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=b3404a0325967de5fdce4a29e879258075ede500;hb=4b4a27dff4e2d4cc2eac1cde31aede834a966a48;f=Documentation/filesystems/ramfs-rootfs-initramfs.txt

HTH,
Johannes
