Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFIVQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFIVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:15:59 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:43425 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S262095AbTFIVPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:15:50 -0400
Subject: Re: memtest86 on the opteron
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Dan Carpenter <dcarpenter@penguincomputing.com>,
       linux-kernel@vger.kernel.org, ppokorny@penguincomputing.com
In-Reply-To: <20030609211823.GA2182@suse.de>
References: <Pine.LNX.4.33.0306091320500.2640-100000@ddcarpen1.penguincompting.com>
	 <20030609211823.GA2182@suse.de>
Content-Type: multipart/mixed; boundary="=-JXwGAmiC4/4tovDQ5iCc"
Organization: 
Message-Id: <1055194161.32291.11.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 14:29:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JXwGAmiC4/4tovDQ5iCc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-06-09 at 14:18, Dave Jones wrote:

> Any reason to restrict it to a single stepping ?
> This means you have to upgrade memtest every time a new model
> is released, which seems a bit of a pain.

This is the patch I use, which seems to make sense, since I don't know
of any other steppings.  No point in parameterising the code until you
have some parameters.

	<b

--=-JXwGAmiC4/4tovDQ5iCc
Content-Disposition: inline; filename=memtest.patch
Content-Type: text/plain; name=memtest.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== init.c 1.2 vs edited =====
--- 1.2/init.c	Mon Jun  9 14:25:40 2003
+++ edited/init.c	Mon Jun  9 14:27:42 2003
@@ -403,16 +403,12 @@
 			l1_cache = cpu_id.cache_info[3];
 			l1_cache += cpu_id.cache_info[7];
 		case 15:
-			switch (cpu_id.model) {
-			case 5:
-				cprint(LINE_CPU, 0, "AMD Opteron");
-				off = 11;
-				l1_cache = cpu_id.cache_info[3];
-				l1_cache += cpu_id.cache_info[7];
-				l2_cache = (cpu_id.cache_info[11] << 8);
-				l2_cache += cpu_id.cache_info[10];
-				break;
-			}
+			cprint(LINE_CPU, 0, "AMD Opteron");
+			off = 11;
+			l1_cache = cpu_id.cache_info[3];
+			l1_cache += cpu_id.cache_info[7];
+			l2_cache = (cpu_id.cache_info[11] << 8);
+			l2_cache += cpu_id.cache_info[10];
 		}
 		break;
 

--=-JXwGAmiC4/4tovDQ5iCc--

