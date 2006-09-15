Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWIOTCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWIOTCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWIOTCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:02:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:33371 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWIOTCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:02:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=iKflg1hg8DDz6PIPxz/wSrmj581Gk/QCzTucD8ef0GiJME2GYDTABgG9bhTF3jmRpROmgSlV/e7IafNLAHSztYPZYzelBbLPrGuotDhFLXcx8qO302u+4pHxUhvgGZW4x2Wc8g8Ml51H3MkvgSIwA+ty0mdj05bSP9tRwU+OOMY=
Message-ID: <450AF8D6.8090208@gmail.com>
Date: Fri, 15 Sep 2006 13:02:46 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [RFC-patch] Doc/lockdep-design:  explain display of {state-bits}
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please offer corrections / wording improvements as appropriate.
In particular, the ".+-? " table could be more illuminating - I lack the
knowledge to make the right inferences..

(or just take it, and run with it ;-)

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

--- doc-touches/Documentation/lockdep-design.txt~	2006-09-14 11:49:47.000000000 -0600
+++ doc-touches/Documentation/lockdep-design.txt	2006-09-15 12:46:34.000000000 -0600
@@ -36,6 +36,28 @@
 
 - 'ever used'                                       [ == !unused        ]
 
+When mutex rules are violated, these 4 state bits are presented in the
+mutex error messages, inside curlies.  A contrived example:
+
+   modprobe/2287 is trying to acquire lock:
+    (&sio_locks[i].lock){--..}, at: [<c02867fd>] mutex_lock+0x21/0x24
+
+   but task is already holding lock:
+    (&sio_locks[i].lock){--..}, at: [<c02867fd>] mutex_lock+0x21/0x24
+
+
+The bit position indicates hardirq, softirq, hardirq-read,
+softirq-read respectively, and the character displayed in each
+indicates:
+
+   '.'	 used
+   '+'  used in irqs
+   '-'  enabled in irqs
+   '?'  used and enabled (bits 3,4)
+
+Unused mutexes cannot be part of the cause of an error.
+
+
 Single-lock state rules:
 ------------------------
 


