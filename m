Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbTGSQNl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 12:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbTGSQNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 12:13:41 -0400
Received: from ns.tasking.nl ([195.193.207.2]:32270 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S266051AbTGSQNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 12:13:40 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva>
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: Re: Linux 2.4.22-pre7
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <3b8b.3f19716a.4a88c@altium.nl>
Date: Sat, 19 Jul 2003 16:27:22 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
| Here goes -pre7.
| 
| This is a feature freeze, only bugfixes will be accepted from now on.

OK, do you accept the following bugfix for /proc/cmdline?

--- linux-2.4.21/fs/proc/proc_misc.c.orig	Fri Jun 27 11:35:06 2003
+++ linux-2.4.21/fs/proc/proc_misc.c	Fri Jun 27 11:37:15 2003
@@ -423,9 +423,9 @@
 				 int count, int *eof, void *data)
 {
 	extern char saved_command_line[];
-	int len;
+	int len = 0;
 
-	len = snprintf(page, count, "%s\n", saved_command_line);
+	proc_sprintf(page, &off, &len, "%s\n", saved_command_line);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
Since kernel version 2.4.19, a read() from /proc/cmdline with a
non-zero offset doesn't work anymore: try "dd bs=1 < /proc/cmdline".
Because of this bug, the following fails in ash and the busybox shell:

  $ read line < /proc/cmdline

I've posted this fix to lkml in januari, and sent it to you several
times, but got no reaction. Alan Cox included this patch in version
2.4.21pre5-ac4 of his tree. Could you please include this obvious fix
in 2.4.22?

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

