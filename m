Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269502AbUIZHsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269502AbUIZHsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 03:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269504AbUIZHsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 03:48:52 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:45293 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269502AbUIZHso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 03:48:44 -0400
Date: Sun, 26 Sep 2004 08:48:41 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.58.0409250834110.2317@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0409260847460.18239@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
 <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
 <20040925072516.GS23987@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0409250834110.2317@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Linus Torvalds wrote:
> I personally believe that people use enum's largely in two (independent) 
> ways:
> 
>  - a convenient compile-time constant:
> 
> 	enum {
> 		DevEnableMask = 1UL << 0,
> 		DevIRQMask = 1UL << 5,
> 		DevError = 1UL << 31
> 	};
> 
>    where you never actually _save_ an enum anywhere. In this case, the 
>    typing is very convenient indeed.
> 
>  - a "type enumerator":
> 
> 	enum token_type {
> 		TOKEN_IDENT = 1,
> 		TOKEN_NUMBER,
> 		TOKEN_MACRO,
> 	...
> 
>    where the enum actually is used as a variable to distinguish different 
>    cases. In this case, the per-enum typing ends up being possibly even 
>    confusing, since using a constant will have a potentially _different_ 
>    type than loading that constant from a variable.
> 
> The second case is why I think it's a sane thing to warn if anybody ever 
> creates a variable (or structure/union member) with an enum that used the 
> typing features. Not because we can't make the enum fit all the values, 
> but because the types simply WILL NOT MATCH. They fundamentally cannot, 
> since we took the approach of having per-entry types.
> 
> And for sparse, since the type is _the_ most important part of anything, 
> we should warn when the types won't match.

What does sparse do at the moment when the enum size has been changed 
away from sizeof(int) using __attribute__ ((__packed__))?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
