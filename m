Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269694AbUICNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269694AbUICNrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUICNrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:47:11 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:55206 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S269694AbUICNq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:46:56 -0400
Date: Fri, 3 Sep 2004 15:47:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: minmax-removal arch/s390/kernel/debug.c
Message-ID: <20040903134731.GA3493@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: minmax-removal arch/s390/kernel/debug.c

Removes unnecessary min/max macros and changes calls to use
kernel.h macros instead.

Signed-off-by: Michael Veeck <michael.veeck@gmx.net>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/debug.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/debug.c linux-2.6-s390/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	Sat Aug 14 12:54:50 2004
+++ linux-2.6-s390/arch/s390/kernel/debug.c	Fri Sep  3 15:26:29 2004
@@ -24,7 +24,6 @@
 
 #include <asm/debug.h>
 
-#define MIN(a,b) (((a)<(b))?(a):(b))
 #define DEBUG_PROLOG_ENTRY -1
 
 /* typedefs */
@@ -435,7 +434,7 @@
 
 	while(count < len){
 		size = debug_format_entry(p_info);
-		size = MIN((len - count), (size - entry_offset));
+		size = min((len - count), (size - entry_offset));
 
 		if(size){
 			if (copy_to_user(user_buf + count, 
@@ -723,7 +722,7 @@
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
 	memset(DEBUG_DATA(active), 0, id->buf_size);
-	memcpy(DEBUG_DATA(active), buf, MIN(len, id->buf_size));
+	memcpy(DEBUG_DATA(active), buf, min(len, id->buf_size));
 	debug_finish_entry(id, active, level, 0);
 	spin_unlock_irqrestore(&id->lock, flags);
 
@@ -744,7 +743,7 @@
 	spin_lock_irqsave(&id->lock, flags);
 	active = get_active_entry(id);
 	memset(DEBUG_DATA(active), 0, id->buf_size);
-	memcpy(DEBUG_DATA(active), buf, MIN(len, id->buf_size));
+	memcpy(DEBUG_DATA(active), buf, min(len, id->buf_size));
 	debug_finish_entry(id, active, level, 1);
 	spin_unlock_irqrestore(&id->lock, flags);
 
@@ -789,7 +788,7 @@
 	curr_event=(debug_sprintf_entry_t *) DEBUG_DATA(active);
 	va_start(ap,string);
 	curr_event->string=string;
-	for(idx=0;idx<MIN(numargs,((id->buf_size / sizeof(long))-1));idx++)
+	for(idx=0;idx<min(numargs,(int)(id->buf_size / sizeof(long))-1);idx++)
 		curr_event->args[idx]=va_arg(ap,long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 0);
@@ -821,7 +820,7 @@
 	curr_event=(debug_sprintf_entry_t *)DEBUG_DATA(active);
 	va_start(ap,string);
 	curr_event->string=string;
-	for(idx=0;idx<MIN(numargs,((id->buf_size / sizeof(long))-1));idx++)
+	for(idx=0;idx<min(numargs,(int)(id->buf_size / sizeof(long))-1);idx++)
 		curr_event->args[idx]=va_arg(ap,long);
 	va_end(ap);
 	debug_finish_entry(id, active, level, 1);
@@ -1157,7 +1156,7 @@
 	}
 
 	/* number of arguments used for sprintf (without the format string) */
-	num_used_args   = MIN(DEBUG_SPRINTF_MAX_ARGS, (num_longs - 1));
+	num_used_args   = min(DEBUG_SPRINTF_MAX_ARGS, (num_longs - 1));
 
 	memset(index,0, DEBUG_SPRINTF_MAX_ARGS * sizeof(int));
 
