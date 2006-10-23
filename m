Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWJWVkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWJWVkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWJWVkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:40:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33775 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752023AbWJWVkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rctAPoKz92t7e+hkjC0gcrNiS1b2sIYowaamVeXCu0/c1ff4xjGGm1PfCRRhg5QdMf2RAV+I26d5FMKzdOranbs92zj1wHgNjSlBrO4WXavjXON6rHmjX7G0lVmVefd5X3WySQOaF6vS8vgpo8TO7Bi3cuYdmBFMPXdhNti7pVA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH] Fix use of uninitialized variable in drivers/video/sis/init301.c::SiS_DDC2Delay()
Date: Mon, 23 Oct 2006 23:42:07 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
References: <200610232326.11288.jesper.juhl@gmail.com> <Pine.LNX.4.64N.0610231425510.9588@attu2.cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610231425510.9588@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232342.07458.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 23:26, David Rientjes wrote:
> On Mon, 23 Oct 2006, Jesper Juhl wrote:
> 
> > The variable 'j' is used uninitialized in the loop. Fix by initializing it to zero.
> > 
[snip]
> 
> I doubt this patch compile tested.
> 
You are right. I hang my head in shame and admit I did not compile test this one.
Fixed patch below.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/sis/init301.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
index f13fadd..45a5969 100644
--- a/drivers/video/sis/init301.c
+++ b/drivers/video/sis/init301.c
@@ -445,7 +445,8 @@ #endif
 void
 SiS_DDC2Delay(struct SiS_Private *SiS_Pr, unsigned int delaytime)
 {
-   unsigned int i, j;
+   unsigned int i;
+   unsigned int j = 0;
 
    for(i = 0; i < delaytime; i++) {
       j += SiS_GetReg(SiS_Pr->SiS_P3c4,0x05);


