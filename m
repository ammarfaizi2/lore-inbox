Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318733AbSHLQD1>; Mon, 12 Aug 2002 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHLQD0>; Mon, 12 Aug 2002 12:03:26 -0400
Received: from hercules.egenera.com ([208.254.46.135]:28940 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318733AbSHLQDY>; Mon, 12 Aug 2002 12:03:24 -0400
Date: Mon, 12 Aug 2002 12:06:59 -0400
From: Phil Auld <pauld@egenera.com>
To: viro@math.psu.edu
Cc: marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19 revert block_llseek behavior to standard
Message-ID: <20020812120659.B27650@vienna.EGENERA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,
	I think this falls under the VFS umbrella, but I may be wrong. 

Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
(http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
may have political baggage.

--- fs/block_dev.c.orig	Mon Aug 12 09:23:19 2002
+++ fs/block_dev.c	Mon Aug 12 09:24:06 2002
@@ -175,7 +175,7 @@
 			offset += file->f_pos;
 	}
 	retval = -EINVAL;
-	if (offset >= 0 && offset <= size) {
+	if (offset >= 0) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_reada = 0;


Thanks,

Phil

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
