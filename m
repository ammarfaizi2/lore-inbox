Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291700AbSBNOkC>; Thu, 14 Feb 2002 09:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291692AbSBNOjz>; Thu, 14 Feb 2002 09:39:55 -0500
Received: from [63.204.6.12] ([63.204.6.12]:3068 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S291689AbSBNOjp>;
	Thu, 14 Feb 2002 09:39:45 -0500
Subject: [PATCH] memcmp() kernel janitor (was: memcmp() doesn't)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1013572286.1581.95.camel@keller>
In-Reply-To: <1013572286.1581.95.camel@keller>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 09:39:24 -0500
Message-Id: <1013697564.1764.8.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-12 at 22:51, Georg Nikodym wrote:

> I can supply patches in BK or regular form but I suspect it'd be easier
> for somebody "in the club" to simply make this change themselves.

At the prompting of Ingo Oeser, here's a patch.  A BK patch has already
been sent to Linus.

CSET comment:

  Fix generic memcmp() to correctly sign the return value.
  
  Non x86 architectures using memcmp() in situations where the sign
  of the return value matters would get the wrong answer (in 
  signed 8-bit arithmetic, 0 - 221 = 35, rather than the -221
  that many might assume/expect).

Patch:

--- a/lib/string.c	Thu Feb 14 09:33:48 2002
+++ b/lib/string.c	Thu Feb 14 09:33:48 2002
@@ -452,7 +452,7 @@
 int memcmp(const void * cs,const void * ct,size_t count)
 {
 	const unsigned char *su1, *su2;
-	signed char res = 0;
+	int res = 0;
 
 	for( su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
 		if ((res = *su1 - *su2) != 0)

