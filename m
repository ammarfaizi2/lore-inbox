Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUDQLjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUDQLjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:39:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:38921 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263937AbUDQLjo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:39:44 -0400
Date: Sat, 17 Apr 2004 21:39:18 +1000
To: Rolf Kutz <kutz@netcologne.de>, 244207@bugs.debian.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#244207: kernel-source-2.6.5: mwave gives warning on suspend
Message-ID: <20040417113918.GA4846@gondor.apana.org.au>
References: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20040417104311.9C13A1D802@jamaika.kutz.dyndns.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tags 244207 pending
quit

On Sat, Apr 17, 2004 at 12:43:11PM +0200, Rolf Kutz wrote:
> Package: kernel-source-2.6.5
> Version: 2.6.5-1
> Severity: normal
> 
> The mwave module gives the following warning on suspend:
> 
> Apr 16 09:55:13 localhost kernel: Device 'mwave' does not have a release() funct
> ion, it is broken and must be fixed.
> Apr 16 09:55:13 localhost kernel: Badness in device_release at drivers/base/core
> .c:85

Thanks for the report.

This patch should shut the warning up.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/char/mwave/mwavedd.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/mwave/mwavedd.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 mwavedd.c
--- a/drivers/char/mwave/mwavedd.c	28 Sep 2003 04:44:12 -0000	1.1.1.7
+++ b/drivers/char/mwave/mwavedd.c	17 Apr 2004 11:37:52 -0000
@@ -470,7 +470,13 @@
  * sysfs support <paulsch@us.ibm.com>
  */
 
-struct device mwave_device;
+static void mwave_device_release(struct device *dev)
+{
+}
+
+static struct device mwave_device = {
+	.release = mwave_device_release,
+};
 
 /* Prevent code redundancy, create a macro for mwave_show_* functions. */
 #define mwave_show_function(attr_name, format_string, field)		\

--k+w/mQv8wyuph6w0--
