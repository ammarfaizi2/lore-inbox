Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSJaNpx>; Thu, 31 Oct 2002 08:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbSJaNpx>; Thu, 31 Oct 2002 08:45:53 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:18832 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S262802AbSJaNpw>;
	Thu, 31 Oct 2002 08:45:52 -0500
Date: Thu, 31 Oct 2002 14:52:06 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [miniPATCH] 2.5.4[4,5] AFS dir.c compile fix
Message-ID: <20021031135206.GB15941@hazard.jcu.cz>
References: <20021031134312.GA15941@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20021031134312.GA15941@hazard.jcu.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

On Thu, Oct 31, 2002 at 02:43:12PM +0100, Jan Marek wrote:
> Hallo,
> 
> thist patch is needed for compile AFS with compiler gcc version prior
> 3.0. Have been accepted by Alan Cox in 2.5.44-ac3...
> 
> Please apply...

:-( And here is patch... :-)

Sorry...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fs_afs_dirc.patch"

--- linux-2.5.44/fs/afs/dir.c.old	2002-10-23 11:35:12.000000000 +0200
+++ linux-2.5.44/fs/afs/dir.c	2002-10-23 11:39:57.000000000 +0200
@@ -72,7 +72,7 @@
 		u8	name[16];
 		u8	overflow[4];	/* if any char of the name (inc NUL) reaches here, consume
 					 * the next dirent too */
-	};
+	} parts;
 	u8	extended_name[32];
 } afs_dirent_t;
 
@@ -258,7 +258,7 @@
 
 		/* got a valid entry */
 		dire = &block->dirents[offset];
-		nlen = strnlen(dire->name,sizeof(*block) - offset*sizeof(afs_dirent_t));
+		nlen = strnlen(dire->parts.name,sizeof(*block) - offset*sizeof(afs_dirent_t));
 
 		_debug("ENT[%u.%u]: %s %u \"%.*s\"\n",
 		       blkoff/sizeof(afs_dir_block_t),offset,
@@ -290,11 +290,11 @@
 
 		/* found the next entry */
 		ret = filldir(cookie,
-			      dire->name,
+			      dire->parts.name,
 			      nlen,
 			      blkoff + offset * sizeof(afs_dirent_t),
-			      ntohl(dire->vnode),
-			      filldir==afs_dir_lookup_filldir ? dire->unique : DT_UNKNOWN);
+			      ntohl(dire->parts.vnode),
+			      filldir==afs_dir_lookup_filldir ? dire->parts.unique : DT_UNKNOWN);
 		if (ret<0) {
 			_leave(" = 0 [full]");
 			return 0;

--jI8keyz6grp/JLjh--
