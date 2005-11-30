Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVK3Nxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVK3Nxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVK3Nxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:53:46 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:23178 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751222AbVK3Nxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:53:46 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 30 Nov 2005 13:53:27 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Tarkan Erimer <tarkane@gmail.com>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2
 and 2.6.15-rc1-mm2
In-Reply-To: <20051129151044.7ce3ef4a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511301347490.14736@hermes-1.csi.cam.ac.uk>
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
 <1132917564.7068.41.camel@laptopd505.fenrus.org>
 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
 <1133092701.2853.0.camel@laptopd505.fenrus.org>
 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
 <20051127165733.643d5444.akpm@osdl.org> <9611fa230511291357g3aa964adj6918fea50f5ee66e@mail.gmail.com>
 <20051129151044.7ce3ef4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Nov 2005, Andrew Morton wrote:
> Tarkan Erimer <tarkane@gmail.com> wrote:
> > On 11/28/05, Andrew Morton <akpm@osdl.org> wrote:
> > > XFS went nuts.  Please test the latest git snapshot which has fixes for
> > > this.
> > 
> > I tried 2.6.15-rc2-git6 and just released 2.6.15-rc3. Result is same.
> > I still got occasional hangs.
> 
> Please generate the sysrq-T trace when the system hangs.
> 
> > When I check my syslog, I found no error
> > messages. But notice, XFS related errors have gone.
> 
> OK, we might have fixed XFS.
> 
> > I paste last few
> > lines of my syslog.
> > 
> > ----syslog ----
> > Nov 29 23:22:43 hightemple kernel: [  518.648894] NTFS-fs warning
> > (device hda1): ntfs_filldir(): Skipping unrepresentable inode 0x516d.
> > Nov 29 23:22:54 hightemple kernel: [  529.059660] printk: 36 messages
> > suppressed.
> > Nov 29 23:22:54 hightemple kernel: [  529.059669] NTFS-fs error
> > (device hda1): ntfs_ucstonls(): Unicode name contains characters that
> > cannot be converted to character set iso8859-1.  You might want to try
> > to use the mount option nls=utf8.
> > Nov 29 23:22:54 hightemple kernel: [  529.059676] NTFS-fs warning
> > (device hda1): ntfs_filldir(): Skipping unrepresentable inode 0x57db.
> 
> Anton is the man.

Yes.  (-:

These just means that you have mounted with a bad default code page or 
whatever you want to call it and the ntfs volume contains characters 
whethe the Unicode (i.e. NTFS) to your code page conversion fails (NLS 
conversion returns error due to non-existant character in your code page).  
As the message suggests if you adjust your mount options to include the 
"nls=utf8" option the errors will go away and everything will work except 
maybe your terminal/gui may dislay some garbage characters if it does not 
understand utf8 characters but at least you will see all 
files/directories.

> > Nov 29 23:23:57 hightemple gconfd (root-11625): starting (version
> > 2.12.1), pid 11625 user 'root'
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
> > configuration source at position 0
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readwrite:/root/.gconf" to a writable configuration source at
> > position 1
> > Nov 29 23:23:57 hightemple gconfd (root-11625): Resolved address
> > "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
> > configuration source at position 2
> 
> I assume the above isn't kernel-related?

Correct.  That is just Gnome and in particular gconf stuff (i.e. the Gnome 
daemon providing access to the Gnome version of the Windows registry)...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
