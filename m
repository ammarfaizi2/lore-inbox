Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752185AbWAFCdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbWAFCdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWAFCdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:33:11 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:35295 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1752185AbWAFCdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:33:10 -0500
Date: Fri, 6 Jan 2006 11:33:07 +0900
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kdump: add dmesg gdbmacro into document
Message-ID: <20060106023306.GB18912@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add gdb macro which print the kernel ring buffer into kdump docs

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- 2.6/Documentation/kdump/gdbmacros.txt.orig	2006-01-06 10:47:06.000000000 +0900
+++ 2.6/Documentation/kdump/gdbmacros.txt	2006-01-06 10:47:46.000000000 +0900
@@ -177,3 +177,25 @@ document trapinfo
 	'trapinfo <pid>' will tell you by which trap & possibly
 	addresthe kernel paniced.
 end
+
+
+define dmesg
+	set $i = 0
+	set $end_idx = (log_end - 1) & (log_buf_len - 1)
+
+	while ($i < logged_chars)
+		set $idx = (log_end - 1 - logged_chars + $i) & (log_buf_len - 1)
+
+		if ($idx + 100 <= $end_idx) || \
+		   ($end_idx <= $idx && $idx + 100 < log_buf_len)
+			printf "%.100s", &log_buf[$idx]
+			set $i = $i + 100
+		else
+			printf "%c", log_buf[$idx]
+			set $i = $i + 1
+		end
+	end
+end
+document dmesg
+	print the kernel ring buffer
+end
