Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268387AbUHXVlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268387AbUHXVlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUHXVik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:38:40 -0400
Received: from holomorphy.com ([207.189.100.168]:25990 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268369AbUHXVhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:37:32 -0400
Date: Tue, 24 Aug 2004 14:37:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824213723.GZ2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040824205621.GU2793@holomorphy.com> <20040824212345.GX2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824212345.GX2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 02:23:45PM -0700, William Lee Irwin III wrote:
> fs/reiser4/plugin/pseudo/pseudo.c: In function `get_rwx':
> fs/reiser4/plugin/pseudo/pseudo.c:603: warning: comparison is always false due to limited range of data type

This one is a real bug.


Index: mm4-2.6.8.1/fs/reiser4/plugin/pseudo/pseudo.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/plugin/pseudo/pseudo.c	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/fs/reiser4/plugin/pseudo/pseudo.c	2004-08-24 14:33:40.794688832 -0700
@@ -600,7 +600,7 @@
 			struct iattr newattrs;
 
 			down(&host->i_sem);
-			if (rwx == (mode_t) -1)
+			if (rwx == (umode_t)~0)
 				rwx = host->i_mode;
 			newattrs.ia_mode =
 				(rwx & S_IALLUGO) | (host->i_mode & ~S_IALLUGO);
