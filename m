Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318742AbSHLQLa>; Mon, 12 Aug 2002 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318755AbSHLQLa>; Mon, 12 Aug 2002 12:11:30 -0400
Received: from hercules.egenera.com ([208.254.46.135]:39692 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318742AbSHLQL3>; Mon, 12 Aug 2002 12:11:29 -0400
Date: Mon, 12 Aug 2002 12:15:04 -0400
From: Phil Auld <pauld@egenera.com>
To: vire@math.psu.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.31 revert block_llseek to standard behavior
Message-ID: <20020812121504.C27650@vienna.EGENERA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

	Same patch against the 2.5.31 tree. 

Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
(http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
may have political baggage.

--- fs/block_dev.c.orig	Mon Aug 12 09:25:40 2002
+++ fs/block_dev.c	Mon Aug 12 09:26:14 2002
@@ -164,7 +164,7 @@
 			offset += file->f_pos;
 	}
 	retval = -EINVAL;
-	if (offset >= 0 && offset <= size) {
+	if (offset >= 0) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_version = ++event;



Thanks,

Phil

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
