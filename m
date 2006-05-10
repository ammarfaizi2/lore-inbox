Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWEJC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWEJC4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEJC4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:43 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:48957 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932397AbWEJC4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:18 -0400
Date: Tue, 9 May 2006 19:55:59 -0700
Message-Id: <200605100255.k4A2tx1b031712@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: eokerson@quicknet.net, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] ixj gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings,

drivers/telephony/ixj.c: In function 'ixj_pstn_state':
drivers/telephony/ixj.c:4847: warning: 'bytes.high' may be used uninitialized in this function
drivers/telephony/ixj.c: In function 'ixj_write_frame':
drivers/telephony/ixj.c:3448: warning: 'blankword.high' may be used uninitialized in this function
drivers/telephony/ixj.c:3448: warning: 'blankword.low' may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/telephony/ixj.c
===================================================================
--- linux-2.6.16.orig/drivers/telephony/ixj.c
+++ linux-2.6.16/drivers/telephony/ixj.c
@@ -3445,7 +3445,7 @@ static void ixj_write_frame(IXJ *j)
 {
 	int cnt, frame_count, dly;
 	IXJ_WORD dat;
-	BYTES blankword;
+	BYTES blankword = { .high = 0, .low = 0};
 
 	frame_count = 0;
 	if(j->flags.cidplay) {
@@ -3503,6 +3503,7 @@ static void ixj_write_frame(IXJ *j)
 					blankword.low = blankword.high = 0x00;
 					break;
 				case PLAYBACK_MODE_8LINEAR_WSS:
+				default:
 					blankword.low = blankword.high = 0x80;
 					break;
 				}
@@ -4844,7 +4845,7 @@ static char daa_int_read(IXJ *j)
 static char daa_CR_read(IXJ *j, int cr)
 {
 	IXJ_WORD wdata;
-	BYTES bytes;
+	BYTES bytes = { .high = 0, .low = 0};
 
 	if (!SCI_Prepare(j))
 		return 0;
@@ -4860,6 +4861,7 @@ static char daa_CR_read(IXJ *j, int cr)
 		bytes.high = 0xB0 + cr;
 		break;
 	case SOP_PU_PULSEDIALING:
+	default:
 		bytes.high = 0xF0 + cr;
 		break;
 	}
