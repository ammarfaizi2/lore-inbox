Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSHSBVM>; Sun, 18 Aug 2002 21:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHSBVM>; Sun, 18 Aug 2002 21:21:12 -0400
Received: from mnh-1-18.mv.com ([207.22.10.50]:45316 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S316594AbSHSBVM>;
	Sun, 18 Aug 2002 21:21:12 -0400
Message-Id: <200208190228.VAA04400@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: James Morris <jmorris@intercode.com.au>
cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       Andi Kleen <ak@muc.de>, viro@math.psu.edu, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31 [version 2] 
In-Reply-To: Your message of "Sat, 17 Aug 2002 12:58:12 +1000."
             <Mutt.LNX.4.44.0208171249510.3437-100000@blackbird.intercode.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Aug 2002 21:28:18 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is still wrong.  You need to be checking fown->pid in the loop.

Same thing in send_sigurg.

				Jeff

@@ -469,6 +492,12 @@
 	struct task_struct * p;
 	int   pid	= fown->pid;
 	
+	if (!pid)
+		return;
+		
+	while (pid == PID_INVALID)
+		cpu_relax();
+	
 	read_lock(&tasklist_lock);
 	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
 		send_sigio_to_task(p, fown, fd, band);

