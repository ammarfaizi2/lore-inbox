Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVCIN0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVCIN0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVCIN0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:26:22 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:25014 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262363AbVCINZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:25:28 -0500
Subject: I/O and Memory accounting...
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Jay Lan <jlan@engr.sgi.com>
Date: Wed, 09 Mar 2005 14:25:23 +0100
Message-Id: <1110374723.10590.116.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/03/2005 14:34:30,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/03/2005 14:34:37,
	Serialize complete at 09/03/2005 14:34:37
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  In the ChangeLog-2.6.11 file I read that the enhanced I/O accounting
data patch and the enhanced memory accounting data collection patch were
added. It's cool but I don't see how this stuff is used because
information is never dump in a file or send to an accounting application
(or I miss something). 
 
  Maybe we should update the ac_io in the "struct acct"? Thus, values
will be dump in the accounting file. Maybe it could be something like:

--- acct.c.orig	2005-03-09 14:17:07.000000000 +0100
+++ acct.c	2005-03-09 14:18:20.000000000 +0100
@@ -477,8 +477,8 @@ static void do_acct_process(long exitcod
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
-	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
-	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
+	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
+	ac.ac_rw = encode_comp_t(0);
 	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
 				     current->group_leader->min_flt);
 	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +


For memory and read/write syscall we may add new fields. 

Best regards,
Guillaume

