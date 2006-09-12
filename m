Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWILSGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWILSGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWILSGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:06:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27670 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030331AbWILSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:06:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AN5kxybSuZk0aJni8ytddCGPRxsAe8ak+NqBVoggJTcucb30NfD9H2S3GEiB16vo/TiHzjhWnJTQajGLyYWx29CBPWkWzlCCefYCR1RWI+K1KcmYVkKGwSq6AwtXih7eZfKJW2GugT2JrbHYTtJKjF/PRlKtFgIWkowsML8c8Kk=
Date: Tue, 12 Sep 2006 20:05:22 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zach.brown@oracle.com,
       rmk+kernel@arm.linux.org.uk
Subject: [-mm patch] arm build fail: vfpsingle.c
Message-ID: <20060912200522.GN3775@slug>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912000618.a2e2afc0.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 12:06:18AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> 
Hi,

It looks like Zach Brown's patch pr_debug-check-pr_debug-arguments
worked as inteded. That is, it doesn't "allow completely incorrect code
to build." :).

The arm build fails with the following message:
  CC      arch/arm/vfp/vfpsingle.o
  arch/arm/vfp/vfpsingle.c: In function `__vfp_single_normaliseround':
  arch/arm/vfp/vfpsingle.c:201: error: `func' undeclared (first use in
  this function)
  arch/arm/vfp/vfpsingle.c:201: error: (Each undeclared identifier is
  reported only once
  arch/arm/vfp/vfpsingle.c:201: error: for each function it appears in.)
  make[1]: *** [arch/arm/vfp/vfpsingle.o] Error 1
  make: *** [arch/arm/vfp] Error 2

The following patch fixes the issue by using func only when DEBUG is
defined.

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- 2.6.18-rc6-mm2/arch/arm/vfp/vfpsingle.c~	2006-09-12 19:57:50 +0000
+++ 2.6.18-rc6-mm2/arch/arm/vfp/vfpsingle.c	2006-09-12 19:58:07 +0000
@@ -198,8 +198,10 @@ u32 vfp_single_normaliseround(int sd, st
 	vfp_single_dump("pack: final", vs);
 	{
 		s32 d = vfp_single_pack(vs);
+#ifdef DEBUG
 		pr_debug("VFP: %s: d(s%d)=%08x exceptions=%08x\n", func,
 			 sd, d, exceptions);
+#endif
 		vfp_put_float(d, sd);
 	}
 
