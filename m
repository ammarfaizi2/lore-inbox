Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUG0TOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUG0TOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUG0TOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:14:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37264 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266565AbUG0TMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:12:15 -0400
Subject: [PATCH] add core dump file name pattern option for cpu id
From: Josh Aas <josha@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1090955660.20503.13.camel@coetzee.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 14:14:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 15:14, Joshua Aas wrote:
> Normally core dumps can be blamed on a program itself. However, core
> dumps can also be the result of faulty hardware. Tracking down what
CPU
> a failure occurred on usually requires that hardware be powered off
> piece by piece until no core dumps occur (on big machines this can
take
> a long time). Another option is to run the test pinned to each CPU
until
> the core dump occurs, but this can also take a long time on big
> machines. It would be very beneficial if the kernel was capable of
> making the CPU ID of the CPU the core dump occurred on available
> somehow. The following patch adds an option (%c) to the core dump file
> naming pattern convention for putting the CPU ID into core dump file
> names.
> 
> Signed-off-by: Josh Aas <josha@sgi.com>

---------------------------------------------------------
--- a/fs/exec.c	2004-07-13 14:32:24.000000000 -0500
+++ b/fs/exec.c	2004-07-15 13:16:17.000000000 -0500
@@ -1276,6 +1276,14 @@ void format_corename(char *corename, con
 					goto out;
 				out_ptr += rc;
 				break;
+			/* cpu id */
+			case 'c':
+				rc = snprintf(out_ptr, out_end - out_ptr,
+					      "%d", smp_processor_id());
+				if (rc > out_end - out_ptr)
+					goto out;
+				out_ptr += rc;
+				break;
 			default:
 				break;
 			}
---------------------------------------------------------

Is there any reason this couldn't be taken into the kernel? I didn't get
any response at all and it seems to be a safe and useful patch. Any
feedback would be appreciated.

Signed-off-by: Josh Aas <josha@sgi.com>

--
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068


