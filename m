Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVEGPJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVEGPJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVEGPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:09:09 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:18672
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S261412AbVEGPIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:08:54 -0400
Message-ID: <427CDA00.9040203@ev-en.org>
Date: Sat, 07 May 2005 16:08:48 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: oprofile: enabling cpu events
References: <20050507123956.53734.qmail@web60524.mail.yahoo.com>
In-Reply-To: <20050507123956.53734.qmail@web60524.mail.yahoo.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000009070907000805020204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000009070907000805020204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

li nux wrote:
> I want to profile cpu events using oprofile, when i
> issue following command, it gives me an error saying
> that oprofile is in timer mode.
> What does it mean ?
> the link
> http://oprofile.sourceforge.net/docs/intel-piii-events.php3
> says event=CPU_CLK_UNHALTED is suppported for Pentium
> II processor.
> 
> Is there any way i can enable cpu events ?
> 
> # opcontrol --setup  --event=CPU_CLK_UNHALTED
> You cannot specify any performance counter events
> because OProfile is in timer mode.

The code has some "protection" against too new processors, the kernel 
folks prefer that you use older CPUs, or use newer kernels.

The patch that worked for me against 2.6.6 is attached.

Baruch

--------------000009070907000805020204
Content-Type: text/x-patch;
 name="oprofile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprofile.patch"

 arch/i386/oprofile/nmi_int.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.6/arch/i386/oprofile/nmi_int.c
===================================================================
--- 2.6.6.orig/arch/i386/oprofile/nmi_int.c
+++ 2.6.6/arch/i386/oprofile/nmi_int.c
@@ -313,7 +313,7 @@ static int __init p4_init(void)
 {
 	__u8 cpu_model = current_cpu_data.x86_model;
 
-	if (cpu_model > 3)
+	if (cpu_model > 100)
 		return 0;
 
 #ifndef CONFIG_SMP

--------------000009070907000805020204--
