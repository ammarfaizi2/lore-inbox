Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273414AbSISV0P>; Thu, 19 Sep 2002 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273392AbSISVZs>; Thu, 19 Sep 2002 17:25:48 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:2058
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S273214AbSISVYl>; Thu, 19 Sep 2002 17:24:41 -0400
Subject: Re: [patch] 2.4-ac: real-time / scheduling information out of /proc
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032470788.16889.169.camel@phantasy>
References: <1032470788.16889.169.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-4l5uRDdCW4xyUt11DtC8"
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Sep 2002 17:29:40 -0400
Message-Id: <1032470981.20929.171.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4l5uRDdCW4xyUt11DtC8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-09-19 at 17:26, Robert Love wrote:

> The attached patch exports scheduling policy and real-time priority from
> /proc/<pid>/stats.
> 
> Support for reading this information is in procps CVS.
> 
> This information has been in 2.5 since 2.5.18.
> 
> It does not break old versions of procps as it just adds the new entries
> to the end.  I do not know what the practice is wrt adding proc fields
> in stable kernels, however since this does not break procps, is
> supported by current procps, and is in 2.5 -- it is perfectly safe to
> me.
> 
> Patch is against 2.4.20-pre7-ac3, please apply.

Ugh, missing a comma.  Sorry,

	Robert Love




--=-4l5uRDdCW4xyUt11DtC8
Content-Disposition: attachment; filename=proc-add-rt-info-rml-2.4.20-pre7-ac3-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=proc-add-rt-info-rml-2.4.20-pre7-ac3-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.20-pre7-ac3/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.4.20-pre7-ac3/fs/proc/array.c	Thu Sep 19 16:10:34 2002
+++ linux/fs/proc/array.c	Thu Sep 19 17:18:36 2002
@@ -346,7 +346,7 @@
 	read_unlock(&tasklist_lock);
 	res =3D sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %l=
u \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -389,7 +389,9 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task_cpu(task));
+		task_cpu(task),
+		task->rt_priority,
+		task->policy);
 	if(mm)
 		mmput(mm);
 	return res;

--=-4l5uRDdCW4xyUt11DtC8--

