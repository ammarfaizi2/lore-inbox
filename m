Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWHCOek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWHCOek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHCOek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:34:40 -0400
Received: from pat.uio.no ([129.240.10.4]:60555 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932525AbWHCOek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:34:40 -0400
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>, Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
In-Reply-To: <20060802094529.09db5532@cad-250-152.norway.atmel.com>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
	 <20060731174659.72da734f@cad-250-152.norway.atmel.com>
	 <1154371259.13744.4.camel@localhost>
	 <20060801101210.0548a382@cad-250-152.norway.atmel.com>
	 <1154450847.5605.21.camel@localhost>
	 <20060802094529.09db5532@cad-250-152.norway.atmel.com>
Content-Type: multipart/mixed; boundary="=-YaFodYrjgJteknWnlyMD"
Date: Thu, 03 Aug 2006 10:34:21 -0400
Message-Id: <1154615661.5774.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.183, required 12,
	autolearn=disabled, AWL 0.31, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YaFodYrjgJteknWnlyMD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-08-02 at 09:45 +0200, Haavard Skinnemoen wrote:
> On Tue, 01 Aug 2006 09:47:27 -0700
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > That 'sec=null' would explain why you are seeing a problem, and the
> > attached patch ought to fix it.
> 
> That does explain it, but unfortunately the patch doesn't fix it
> because data->version is 6. I added "case 6:" on the line after "case
> 5:", and it solved the problem.
> 
> I don't know what the difference between version 5 and 6 is, but I
> suspect it has something to do with data->context?

Argh... You are quite right. We ought to have fixed the pseudoflavour
thingy in version 6, and made it mandatory, but we missed the chance...

Revised patch is attached.

Cheers,
  Trond

--=-YaFodYrjgJteknWnlyMD
Content-Disposition: inline; filename=linux-2.6.18-036-nfs-fix_auth_mount.dif
Content-Type: message/rfc822; name=linux-2.6.18-036-nfs-fix_auth_mount.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
NFS: Ensure NFSv2/v3 mounts respect the NFS_MOUNT_SECFLAVOUR flag
Date: Thu, 03 Aug 2006 10:33:52 -0400
Subject: No Subject
Message-Id: <1154615632.5774.31.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 867b5dc..97cfb14 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -471,12 +471,14 @@ static int nfs_validate_mount_data(struc
 						data->version);
 				return -EINVAL;
 			}
-			/* Fill in pseudoflavor for mount version < 5 */
-			data->pseudoflavor = RPC_AUTH_UNIX;
 		case 5:
 			memset(data->context, 0, sizeof(data->context));
 	}
 
+	/* Set the pseudoflavor */
+	if (!(data->flags & NFS_MOUNT_SECFLAVOUR))
+		data->pseudoflavor = RPC_AUTH_UNIX;
+
 #ifndef CONFIG_NFS_V3
 	/* If NFSv3 is not compiled in, return -EPROTONOSUPPORT */
 	if (data->flags & NFS_MOUNT_VER3) {

--=-YaFodYrjgJteknWnlyMD--

