Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUHDLC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUHDLC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUHDLC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:02:58 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:28064 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264531AbUHDLCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:02:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Date: Wed, 4 Aug 2004 21:02:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16656.49742.597235.511861@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
In-Reply-To: message from Frank Steiner on Wednesday August 4
References: <410F481C.9090408@bio.ifi.lmu.de>
	<64bf.410f9d6f.62af@altium.nl>
	<ceouv0$7s8$2@news.cistron.nl>
	<41108380.6080809@bio.ifi.lmu.de>
	<20040804064716.GA31600@traveler.cistron.net>
	<16656.35530.819884.579436@cse.unsw.edu.au>
	<4110BBEF.1040709@bio.ifi.lmu.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 4, fsteiner-mail@bio.ifi.lmu.de wrote:
> Neil Brown wrote:
> 
> >>But I just tried to reproduce this on 2.6.7-rc2 (it's what my
> >>workstation happens to be running) and I can't. I can mount an
> >>nfs-exported /dev from both 2.4 and 2.6 servers read-only and
> >>I can open devices on that read-only mount just fine.
> > 
> > 
> > Yes, it was a bug in the NFS server in 2.6 that was fixed fairly
> > recently.
> 
> Hi Neil,
> 
> it still occurs in 2.6.8rc3 in some way:

.... It looks like it was *so* recent that I haven't actually
submitted the patch yet :-(

I think someone reported it, I sent them a patch, and never got a
confirmation that it worked (or missed it if I did) so the patch
didn't progres..

Try the following.

Thanks,
NeilBrown


### Diffstat output
 ./fs/nfsd/vfs.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff ./fs/nfsd/vfs.c~current~ ./fs/nfsd/vfs.c
--- ./fs/nfsd/vfs.c~current~	2004-07-26 09:54:15.000000000 +1000
+++ ./fs/nfsd/vfs.c	2004-07-23 13:37:38.000000000 +1000
@@ -376,12 +376,13 @@ static struct accessmap	nfs3_anyaccess[]
 	 * to the server to check for access for things like /dev/null
 	 * (which really, the server doesn't care about).  So
 	 * We provide simple access checking for them, looking
-	 * mainly at mode bits
+	 * mainly at mode bits, and we make sure to ignore read-only
+	 * filesystem checks
 	 */
     {	NFS3_ACCESS_READ,	MAY_READ			},
     {	NFS3_ACCESS_EXECUTE,	MAY_EXEC			},
-    {	NFS3_ACCESS_MODIFY,	MAY_WRITE			},
-    {	NFS3_ACCESS_EXTEND,	MAY_WRITE			},
+    {	NFS3_ACCESS_MODIFY,	MAY_WRITE|MAY_LOCAL_ACCESS	},
+    {	NFS3_ACCESS_EXTEND,	MAY_WRITE|MAY_LOCAL_ACCESS	},
 
     {	0,			0				}
 };
