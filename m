Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268844AbUHaRYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268844AbUHaRYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUHaRXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:23:43 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:28631 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S268757AbUHaRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:21:23 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Date: Wed, 1 Sep 2004 02:21:41 +0900
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aeb@cwi.nl>,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <200409010145.51224.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200409010145.51224.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409010221.41992.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the prof_buffer[] should have prepared another entry for
exceeded PC samplings.

--- 2.6-mm/kernel/profile.c.orig	2004-09-01 01:46:16.000000000 +0900
+++ 2.6-mm/kernel/profile.c	2004-09-01 01:58:02.549930824 +0900
@@ -44,7 +44,7 @@ void __init profile_init(void)
 		return;
  
 	/* only text is profiled */
-	prof_len = (_etext - _stext) >> prof_shift;
+	prof_len = ((_etext - _stext) >> prof_shift) + 1;
 	prof_buffer = alloc_bootmem(prof_len*sizeof(atomic_t));
 }
 

