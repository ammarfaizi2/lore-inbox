Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTB0VvF>; Thu, 27 Feb 2003 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTB0VvF>; Thu, 27 Feb 2003 16:51:05 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:10283 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267135AbTB0VvD>; Thu, 27 Feb 2003 16:51:03 -0500
Date: Thu, 27 Feb 2003 16:01:13 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Message-ID: <118810000.1046383273@baldur.austin.ibm.com>
In-Reply-To: <20030227134403.776bf2e3.akpm@digeo.com>
References: <20030227025900.1205425a.akpm@digeo.com>
 <200302280822.09409.kernel@kolivas.org>
 <20030227134403.776bf2e3.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1923109384=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1923109384==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--On Thursday, February 27, 2003 13:44:03 -0800 Andrew Morton
<akpm@digeo.com> wrote:

>> ...
>> Mapped:       4294923652 kB
> 
> Well that's gotta hurt.  This metric is used in making writeback
> decisions.  Probably the objrmap patch.

Oops.  You're right.  Here's a patch to fix it.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

--==========1923109384==========
Content-Type: text/plain; charset=us-ascii; name="objmapped-2.5.63-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="objmapped-2.5.63-1.diff"; size=337

--- 2.5.63-objrmap/mm/rmap.c	2003-02-27 15:58:34.000000000 -0600
+++ 2.5.63-objfix/mm/rmap.c	2003-02-27 15:56:56.000000000 -0600
@@ -248,6 +248,8 @@
 			BUG();
 		if (PageSwapCache(page))
 			BUG();
+		if (atomic_read(&page->pte.mapcount) == 0)
+			inc_page_state(nr_mapped);
 		atomic_inc(&page->pte.mapcount);
 		return pte_chain;
 	}

--==========1923109384==========--

