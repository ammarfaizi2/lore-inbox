Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSDOUsu>; Mon, 15 Apr 2002 16:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313255AbSDOUst>; Mon, 15 Apr 2002 16:48:49 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:44270 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313254AbSDOUss>; Mon, 15 Apr 2002 16:48:48 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 15 Apr 2002 14:47:09 -0600
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Dominik Kubla <kubla@sciobyte.de>,
        linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020415204709.GF14783@turbolinux.com>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
	Dominik Kubla <kubla@sciobyte.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <200204100041.g3A0fSj00928@saturn.cs.uml.edu.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel> <p73adsbpdaz.fsf@oldwotan.suse.de> <20020408203515.B540@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 08, 2002  20:35 +0000, Pavel Machek wrote:
> Andi Kleen writes:
> > You can already do background fsck on a linux system today. Just do it on
> > a LVM/EVMS snapshot.
> 
> How do you fix errors you find by such background fsck?

You shouldn't get any in the first place (they would be from disk
errors, memory corruption, software bugs, etc).  If you _do_ get such
an error, isn't it worth it to shut down your system and bring it back
to a known state (and maybe figure out what actually caused this error)?

The only reason to have such a feature is for high-availability,
high-uptime systems which cannot normally be shut down.  In very recent
versions of e2fsprogs, you are able to reset the "last checked" field
in the superblock (you could reset the "mount count" field for a long
time), so that you do an online check every week/month, then you can
avoid the forced fsck after a reboot because the filesystem hasn't been
checked in 6 months.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

