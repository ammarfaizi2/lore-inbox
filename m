Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVCANxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVCANxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCANxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:53:54 -0500
Received: from zamok.crans.org ([138.231.136.6]:52128 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261907AbVCANxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:53:10 -0500
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: 2.6.11-rc5-mm1
References: <20050301012741.1d791cd2.akpm@osdl.org>
Date: Tue, 01 Mar 2005 14:53:05 +0100
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 1 Mar 2005 01:27:41 -0800")
Message-ID: <871xazxyke.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@osdl.org> disait derni=C3=A8rement que :

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/=
2.6.11-rc5-mm1/
>
>
> - Lots of tuning/balancing changes in the CPU scheduler.  Mainly targetted
>   at larger SMT/SMP/NUMA machines.  It's going to be hard to work out whe=
ther
>   these are a net benefit.
>
> - A pcmcia update which obsoletes cardmgr (although cardmgr still works) =
and
>   makes pcmcia work more like regular hotpluggable devices.  See the
>   changelong in pcmcia-dont-send-eject-request-events-to-userspace.patch =
for
>   details.
>
> - A new reiser4 code drop.

By the way, I got an strange warning compiling fs/reiser4/plugin/ctail.c
obvious fix is attached

fs/reiser4/plugin/item/ctail.c: In function `check_ctail':
fs/reiser4/plugin/item/ctail.c:250: attention : l'adresse de =C3=82=C2=AB c=
tail_ok =C3=82=C2=BB sera toujours =C3=83=C2=A9valu=C3=83=C2=A9e comme =C3=
=83=C2=A9tant =C3=82=C2=AB true =C3=82=C2=BB
fs/reiser4/plugin/item/ctail.c: In function `convert_ctail':
fs/reiser4/plugin/item/ctail.c:1669: attention : l'adresse de =C3=82=C2=AB =
coord_is_unprepped_ctail =C3=82=C2=BB sera toujours =C3=83=C2=A9valu=C3=83=
=C2=A9e comme =C3=83=C2=A9tant =C3=82=C2=AB true =C3=82=C2=BB

Signed-off-by: Mathieu Segaud <mathieu.segaud@crans.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix-reiser4-build.patch

--- fs/reiser4/plugin/item/ctail.c	2005-03-01 14:32:10.750179296 +0100
+++ fs/reiser4/plugin/item/ctail.c.new	2005-03-01 14:46:15.282790824 +0100
@@ -247,7 +247,7 @@
 reiser4_internal int
 check_ctail (const coord_t * coord, const char **error)
 {
-	if (!ctail_ok) {
+	if (!ctail_ok(coord)) {
 		if (error)
 			*error = "bad cluster shift in ctail";
 		return 1;

--=-=-=


-- 
What would you expect to gain from XIP besides being buzzword
compliant?

	- Erik Mouw on linux-arm-kernel

--=-=-=--
