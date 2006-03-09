Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWCICBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWCICBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCICBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:01:01 -0500
Received: from sccrmhc13.comcast.net ([204.127.200.83]:2959 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932147AbWCICBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:01:00 -0500
Date: Wed, 8 Mar 2006 21:03:10 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: replace snprintf to scnprintf in fs/9p/fcprint.c
Message-ID: <20060309020310.GA1815@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fcprint.c incorrectly assumes that snprintf returns the actual number of
bytes saved in the buffer.

This patch fixes the code replacing snprintf with scnprintf.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 8dc8afaa254e9a147c9ab3dc548ba0941823622f
tree cf6f0f16883ef7924bedc5958025527766101e00
parent 371103ccfa30054059bf4e9dc183555b343c10f5
author Latchesar Ionkov <lucho@ionkov.net> Wed, 08 Mar 2006 20:57:30 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Wed, 08 Mar 2006 20:57:30 -0500

 fs/9p/fcprint.c |  100 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/fs/9p/fcprint.c b/fs/9p/fcprint.c
index c435675..8a05603 100644
--- a/fs/9p/fcprint.c
+++ b/fs/9p/fcprint.c
@@ -54,7 +54,7 @@ v9fs_printqid(char *buf, int buflen, str
 		b[n++] = 'L';
 	b[n] = '\0';
 
-	return snprintf(buf, buflen, "(%.16llx %x %s)", (long long int) q->path, 
+	return scnprintf(buf, buflen, "(%.16llx %x %s)", (long long int) q->path, 
 		q->version, b);
 }
 
@@ -85,7 +85,7 @@ v9fs_printperm(char *buf, int buflen, in
 		b[n++] = 'L';
 	b[n] = '\0';
 
-	return snprintf(buf, buflen, "%s%03o", b, perm&077);
+	return scnprintf(buf, buflen, "%s%03o", b, perm&077);
 }
 
 int
@@ -93,28 +93,28 @@ v9fs_printstat(char *buf, int buflen, st
 {
 	int n;
 
-	n = snprintf(buf, buflen, "'%.*s' '%.*s'", st->name.len, 
+	n = scnprintf(buf, buflen, "'%.*s' '%.*s'", st->name.len, 
 		st->name.str, st->uid.len, st->uid.str);
 	if (extended)
-		n += snprintf(buf+n, buflen-n, "(%d)", st->n_uid);
+		n += scnprintf(buf+n, buflen-n, "(%d)", st->n_uid);
 
-	n += snprintf(buf+n, buflen-n, " '%.*s'", st->gid.len, st->gid.str);
+	n += scnprintf(buf+n, buflen-n, " '%.*s'", st->gid.len, st->gid.str);
 	if (extended)
-		n += snprintf(buf+n, buflen-n, "(%d)", st->n_gid);
+		n += scnprintf(buf+n, buflen-n, "(%d)", st->n_gid);
 
-	n += snprintf(buf+n, buflen-n, " '%.*s'", st->muid.len, st->muid.str);
+	n += scnprintf(buf+n, buflen-n, " '%.*s'", st->muid.len, st->muid.str);
 	if (extended)
-		n += snprintf(buf+n, buflen-n, "(%d)", st->n_muid);
+		n += scnprintf(buf+n, buflen-n, "(%d)", st->n_muid);
 	
-	n += snprintf(buf+n, buflen-n, " q ");
+	n += scnprintf(buf+n, buflen-n, " q ");
 	n += v9fs_printqid(buf+n, buflen-n, &st->qid);
-	n += snprintf(buf+n, buflen-n, " m ");
+	n += scnprintf(buf+n, buflen-n, " m ");
 	n += v9fs_printperm(buf+n, buflen-n, st->mode);
-	n += snprintf(buf+n, buflen-n, " at %d mt %d l %lld",
+	n += scnprintf(buf+n, buflen-n, " at %d mt %d l %lld",
 		st->atime, st->mtime, (long long int) st->length);
 
 	if (extended)
-		n += snprintf(buf+n, buflen-n, " ext '%.*s'", 
+		n += scnprintf(buf+n, buflen-n, " ext '%.*s'", 
 			st->extension.len, st->extension.str);
 
 	return n;
@@ -127,15 +127,15 @@ v9fs_dumpdata(char *buf, int buflen, u8 
 
 	i = n = 0;
 	while (i < datalen) {
-		n += snprintf(buf + n, buflen - n, "%02x", data[i]);
+		n += scnprintf(buf + n, buflen - n, "%02x", data[i]);
 		if (i%4 == 3)
-			n += snprintf(buf + n, buflen - n, " ");
+			n += scnprintf(buf + n, buflen - n, " ");
 		if (i%32 == 31)
-			n += snprintf(buf + n, buflen - n, "\n");
+			n += scnprintf(buf + n, buflen - n, "\n");
 
 		i++;
 	}
-	n += snprintf(buf + n, buflen - n, "\n");
+	n += scnprintf(buf + n, buflen - n, "\n");
 
 	return n;
 }
@@ -152,7 +152,7 @@ v9fs_printfcall(char *buf, int buflen, s
 	int i, ret, type, tag;
 
 	if (!fc)
-		return snprintf(buf, buflen, "<NULL>");
+		return scnprintf(buf, buflen, "<NULL>");
 
 	type = fc->id;
 	tag = fc->tag;
@@ -160,21 +160,21 @@ v9fs_printfcall(char *buf, int buflen, s
 	ret = 0;
 	switch (type) {
 	case TVERSION:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Tversion tag %u msize %u version '%.*s'", tag,
 			fc->params.tversion.msize, fc->params.tversion.version.len,
 			fc->params.tversion.version.str);
 		break;
 
 	case RVERSION:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Rversion tag %u msize %u version '%.*s'", tag, 
 			fc->params.rversion.msize, fc->params.rversion.version.len,
 			fc->params.rversion.version.str);
 		break;
 
 	case TAUTH:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Tauth tag %u afid %d uname '%.*s' aname '%.*s'", tag, 
 			fc->params.tauth.afid, fc->params.tauth.uname.len,
 			fc->params.tauth.uname.str, fc->params.tauth.aname.len, 
@@ -182,12 +182,12 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 
 	case RAUTH:
-		ret += snprintf(buf+ret, buflen-ret, "Rauth tag %u qid ", tag); 
+		ret += scnprintf(buf+ret, buflen-ret, "Rauth tag %u qid ", tag); 
 		v9fs_printqid(buf+ret, buflen-ret, &fc->params.rauth.qid);
 		break;
 
 	case TATTACH:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Tattach tag %u fid %d afid %d uname '%.*s' aname '%.*s'",
 			tag, fc->params.tattach.fid, fc->params.tattach.afid, 
 			fc->params.tattach.uname.len, fc->params.tattach.uname.str,
@@ -195,41 +195,41 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 
 	case RATTACH:
-		ret += snprintf(buf+ret, buflen-ret, "Rattach tag %u qid ", tag); 
+		ret += scnprintf(buf+ret, buflen-ret, "Rattach tag %u qid ", tag); 
 		v9fs_printqid(buf+ret, buflen-ret, &fc->params.rattach.qid);
 		break;
 
 	case RERROR:
-		ret += snprintf(buf+ret, buflen-ret, "Rerror tag %u ename '%.*s'",
+		ret += scnprintf(buf+ret, buflen-ret, "Rerror tag %u ename '%.*s'",
 			tag, fc->params.rerror.error.len, 
 			fc->params.rerror.error.str);
 		if (extended)
-			ret += snprintf(buf+ret, buflen-ret, " ecode %d\n",
+			ret += scnprintf(buf+ret, buflen-ret, " ecode %d\n",
 				fc->params.rerror.errno);
 		break;
 
 	case TFLUSH:
-		ret += snprintf(buf+ret, buflen-ret, "Tflush tag %u oldtag %u",
+		ret += scnprintf(buf+ret, buflen-ret, "Tflush tag %u oldtag %u",
 			tag, fc->params.tflush.oldtag);
 		break;
 
 	case RFLUSH:
-		ret += snprintf(buf+ret, buflen-ret, "Rflush tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rflush tag %u", tag);
 		break;
 
 	case TWALK:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Twalk tag %u fid %d newfid %d nwname %d", tag, 
 			fc->params.twalk.fid, fc->params.twalk.newfid, 
 			fc->params.twalk.nwname);
 		for(i = 0; i < fc->params.twalk.nwname; i++)
-			ret += snprintf(buf+ret, buflen-ret," '%.*s'", 
+			ret += scnprintf(buf+ret, buflen-ret," '%.*s'", 
 				fc->params.twalk.wnames[i].len,
 				fc->params.twalk.wnames[i].str);
 		break;
 
 	case RWALK:
-		ret += snprintf(buf+ret, buflen-ret, "Rwalk tag %u nwqid %d", 
+		ret += scnprintf(buf+ret, buflen-ret, "Rwalk tag %u nwqid %d", 
 			tag, fc->params.rwalk.nwqid);
 		for(i = 0; i < fc->params.rwalk.nwqid; i++)
 			ret += v9fs_printqid(buf+ret, buflen-ret, 
@@ -237,38 +237,38 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 		
 	case TOPEN:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Topen tag %u fid %d mode %d", tag,
 			fc->params.topen.fid, fc->params.topen.mode);
 		break;
 		
 	case ROPEN:
-		ret += snprintf(buf+ret, buflen-ret, "Ropen tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Ropen tag %u", tag);
 		ret += v9fs_printqid(buf+ret, buflen-ret, &fc->params.ropen.qid);
-		ret += snprintf(buf+ret, buflen-ret," iounit %d", 
+		ret += scnprintf(buf+ret, buflen-ret," iounit %d", 
 			fc->params.ropen.iounit);
 		break;
 		
 	case TCREATE:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Tcreate tag %u fid %d name '%.*s' perm ", tag, 
 			fc->params.tcreate.fid, fc->params.tcreate.name.len,
 			fc->params.tcreate.name.str);
 
 		ret += v9fs_printperm(buf+ret, buflen-ret, fc->params.tcreate.perm);
-		ret += snprintf(buf+ret, buflen-ret, " mode %d", 
+		ret += scnprintf(buf+ret, buflen-ret, " mode %d", 
 			fc->params.tcreate.mode);
 		break;
 		
 	case RCREATE:
-		ret += snprintf(buf+ret, buflen-ret, "Rcreate tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rcreate tag %u", tag);
 		ret += v9fs_printqid(buf+ret, buflen-ret, &fc->params.rcreate.qid);
-		ret += snprintf(buf+ret, buflen-ret, " iounit %d", 
+		ret += scnprintf(buf+ret, buflen-ret, " iounit %d", 
 			fc->params.rcreate.iounit);
 		break;
 		
 	case TREAD:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Tread tag %u fid %d offset %lld count %u", tag, 
 			fc->params.tread.fid, 
 			(long long int) fc->params.tread.offset,
@@ -276,7 +276,7 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 		
 	case RREAD:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Rread tag %u count %u data ", tag, 
 			fc->params.rread.count);
 		ret += v9fs_printdata(buf+ret, buflen-ret, fc->params.rread.data,
@@ -284,7 +284,7 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 		
 	case TWRITE:
-		ret += snprintf(buf+ret, buflen-ret, 
+		ret += scnprintf(buf+ret, buflen-ret, 
 			"Twrite tag %u fid %d offset %lld count %u data ", 
 			tag, fc->params.twrite.fid, 
 			(long long int) fc->params.twrite.offset, 
@@ -294,52 +294,52 @@ v9fs_printfcall(char *buf, int buflen, s
 		break;
 		
 	case RWRITE:
-		ret += snprintf(buf+ret, buflen-ret, "Rwrite tag %u count %u", 
+		ret += scnprintf(buf+ret, buflen-ret, "Rwrite tag %u count %u", 
 			tag, fc->params.rwrite.count);
 		break;
 		
 	case TCLUNK:
-		ret += snprintf(buf+ret, buflen-ret, "Tclunk tag %u fid %d", 
+		ret += scnprintf(buf+ret, buflen-ret, "Tclunk tag %u fid %d", 
 			tag, fc->params.tclunk.fid);
 		break;
 		
 	case RCLUNK:
-		ret += snprintf(buf+ret, buflen-ret, "Rclunk tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rclunk tag %u", tag);
 		break;
 		
 	case TREMOVE:
-		ret += snprintf(buf+ret, buflen-ret, "Tremove tag %u fid %d", 
+		ret += scnprintf(buf+ret, buflen-ret, "Tremove tag %u fid %d", 
 			tag, fc->params.tremove.fid);
 		break;
 		
 	case RREMOVE:
-		ret += snprintf(buf+ret, buflen-ret, "Rremove tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rremove tag %u", tag);
 		break;
 		
 	case TSTAT:
-		ret += snprintf(buf+ret, buflen-ret, "Tstat tag %u fid %d", 
+		ret += scnprintf(buf+ret, buflen-ret, "Tstat tag %u fid %d", 
 			tag, fc->params.tstat.fid);
 		break;
 		
 	case RSTAT:
-		ret += snprintf(buf+ret, buflen-ret, "Rstat tag %u ", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rstat tag %u ", tag);
 		ret += v9fs_printstat(buf+ret, buflen-ret, &fc->params.rstat.stat,
 			extended);
 		break;
 		
 	case TWSTAT:
-		ret += snprintf(buf+ret, buflen-ret, "Twstat tag %u fid %d ", 
+		ret += scnprintf(buf+ret, buflen-ret, "Twstat tag %u fid %d ", 
 			tag, fc->params.twstat.fid);
 		ret += v9fs_printstat(buf+ret, buflen-ret, &fc->params.twstat.stat,
 			extended);
 		break;
 		
 	case RWSTAT:
-		ret += snprintf(buf+ret, buflen-ret, "Rwstat tag %u", tag);
+		ret += scnprintf(buf+ret, buflen-ret, "Rwstat tag %u", tag);
 		break;
 
 	default:
-		ret += snprintf(buf+ret, buflen-ret, "unknown type %d", type);
+		ret += scnprintf(buf+ret, buflen-ret, "unknown type %d", type);
 		break;
 	}
 
