Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269418AbUIYXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269418AbUIYXcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUIYXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:32:14 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:65218 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269418AbUIYXcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:32:11 -0400
Date: Sun, 26 Sep 2004 00:31:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 7/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <20040925063852.GR23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.60.0409260028320.21041@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <20040925063852.GR23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Sep 24, 2004 at 05:14:12PM +0100, Anton Altaparmakov wrote:
> >   * Generic magic comparison macros. Finally found a use for the ## preprocessor
> >   * operator! (-8
> >   */
> > -#define ntfs_is_magic(x, m)	(   (u32)(x) == magic_##m )
> > -#define ntfs_is_magicp(p, m)	( *(u32*)(p) == magic_##m )
> > +
> > +static inline BOOL __ntfs_is_magic(le32 x, NTFS_RECORD_TYPES r)
> > +{
> > +	return (x == (__force le32)r);
> > +}
> > +#define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
> > +
> > +static inline BOOL __ntfs_is_magicp(le32 *p, NTFS_RECORD_TYPES r)
> > +{
> > +	return (*p == (__force le32)r);
> > +}
> > +#define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)
> 
> *eeeeeek*
> 
> It looks badly wrong.  Why do you need these casts?

*eeeeeek*

It is badly wrong.  Removed.  Thanks!

IIRC I had put them in to silence some sparse warnings I was getting until 
I solved the underlying problems and then completely forgot about them and 
so they didn't get removed again afterwards.  Sorry.  Just me being 
stupid.  )-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
