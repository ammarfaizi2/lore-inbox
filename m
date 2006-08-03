Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWHCOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWHCOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWHCOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:22:26 -0400
Received: from pat.uio.no ([129.240.10.4]:60924 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932430AbWHCOW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:22:26 -0400
Subject: Re: NFS root broken in 2.6.18-rc2-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200608020650.18093.ak@suse.de>
References: <200608020650.18093.ak@suse.de>
Content-Type: multipart/mixed; boundary="=-2EtP1zHqE5pUp0r2nT6y"
Date: Thu, 03 Aug 2006 10:22:07 -0400
Message-Id: <1154614928.5774.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.174, required 12,
	autolearn=disabled, AWL 0.32, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2EtP1zHqE5pUp0r2nT6y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-08-02 at 06:50 +0200, Andi Kleen wrote:
> FYI,
> 
> I tried to boot 2.6.18-rc2-mm1 on a nfsroot system with x86-64 defconfig.
> 
> Unfortunately it seems to generate lots of random EIO while reading executables 
> during the startup sequence, which causes some things to break. Writing
> also doesn't seem to work - it complains about EPERM for that.
> Not all executables error out, but at least some.
> 
> The same setup works fine with mainline 2.6.18-rc*

Known issue. The attached patch ought to fix it...

Cheers,
  Trond

--=-2EtP1zHqE5pUp0r2nT6y
Content-Disposition: inline; filename=linux-2.6.18-036-nfs-fix_auth_mount.dif
Content-Type: message/rfc822; name=linux-2.6.18-036-nfs-fix_auth_mount.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
NFS: Ensure NFSv2/v3 mounts respect the NFS_MOUNT_SECFLAVOUR flag
Date: Thu, 03 Aug 2006 10:21:56 -0400
Subject: No Subject
Message-Id: <1154614916.5774.6.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 867b5dc..d744f63 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -471,9 +471,10 @@ static int nfs_validate_mount_data(struc
 						data->version);
 				return -EINVAL;
 			}
-			/* Fill in pseudoflavor for mount version < 5 */
-			data->pseudoflavor = RPC_AUTH_UNIX;
 		case 5:
+			/* Set the pseudoflavor */
+			if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
+				data->pseudoflavor = RPC_AUTH_UNIX;
 			memset(data->context, 0, sizeof(data->context));
 	}
 

--=-2EtP1zHqE5pUp0r2nT6y--

