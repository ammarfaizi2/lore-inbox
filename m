Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVKDFke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVKDFke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbVKDFke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:40:34 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:43703 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161074AbVKDFkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:40:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] I8K: convert to seqfile
Date: Fri, 4 Nov 2005 00:40:30 -0500
User-Agent: KMail/1.8.3
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor@mail.ru>
References: <200506260103.j5Q13ovn020970@hera.kernel.org> <20051104041902.GA23618@redhat.com> <20051104044118.GF7992@ftp.linux.org.uk>
In-Reply-To: <20051104044118.GF7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040040.31457.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 23:41, Al Viro wrote:
> On Thu, Nov 03, 2005 at 11:19:02PM -0500, Dave Jones wrote:
> > The missing '?' field is puzzling though. Looking at the diff,
> > this should work.  Is this a shortfalling of seq_file perhaps ?
> 
> dmi_get_system_info() returns "" instead of "?" now, apparently...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Oops! I have that field in my BIOS so I never noticed the problem...

I wonder if something like the patch below will fix it.

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/i8k.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: work/drivers/char/i8k.c
===================================================================
--- work.orig/drivers/char/i8k.c
+++ work/drivers/char/i8k.c
@@ -99,7 +99,9 @@ struct smm_regs {
 
 static inline char *i8k_get_dmi_data(int field)
 {
-	return dmi_get_system_info(field) ? : "N/A";
+	char *dmi_data = dmi_get_system_info(field);
+
+	return dmi_data && *dmi_data ? dmi_data : "?";
 }
 
 /*

