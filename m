Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVF3QKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVF3QKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVF3QHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:07:04 -0400
Received: from web53506.mail.yahoo.com ([206.190.37.67]:62338 "HELO
	web53506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263003AbVF3QGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:06:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OpKD2dnworeg4PWg/UASvQyd8FkHduxEygHxdsFGlkVvL7WNgtpQ6JyOzwcuJLcKctaJmeByckIdE7uS4O6BYj+Lq2ZMloOcGy67nWPe1o9EAP9mZLnWflSrpFv/tXnmCtSAhwpLIqPa9ixj1T+Dbrbqq8Cvvit60WTRnAWSvT8=  ;
Message-ID: <20050630160608.39346.qmail@web53506.mail.yahoo.com>
Date: Thu, 30 Jun 2005 09:06:08 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: [TRIVIAL PATCH] Fix GCC4 warning in asm-ppc/time.h
To: lkml <linux-kernel@vger.kernel.org>, paulus@samba.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1366467806-1120147568=:33612"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1366467806-1120147568=:33612
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi
 GCC4 complains:

include/asm/time.h:61: warning: type qualifiers ignored on function
return type

when building CONFIG_6xx, so I propose this patch.

Signed off by: Roger Blofeld <blofeldus@yahoo.com>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1366467806-1120147568=:33612
Content-Type: text/plain; name="gcc4-asm-time.patch.txt"
Content-Description: 4252903260-gcc4-asm-time.patch.txt
Content-Disposition: inline; filename="gcc4-asm-time.patch.txt"

diff --git a/include/asm-ppc/time.h b/include/asm-ppc/time.h
--- a/include/asm-ppc/time.h
+++ b/include/asm-ppc/time.h
@@ -58,7 +58,7 @@ static __inline__ void set_dec(unsigned 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else

--0-1366467806-1120147568=:33612--
