Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWDHKKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWDHKKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWDHKKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 06:10:17 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:40164 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964821AbWDHKKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 06:10:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Kc1Qu+Rk9nJ2I5ZkiEF79LqLMuqfeStUovfwlDXEtSUoD1H0lAZjkPPePmX8ufoDCwDLpqoUswRLXCx6RzQdk/u2UNi4SQlFn0fMhiHNGLdN6QvjGhtxhvLbxQ1FNmY6pUmxPgQp0rEyc4h+zBvMvPyu+YU+PmqDFmRvI0BaqMg=
Message-ID: <2cd57c900604080310l454eec24m7298e01001f132af@mail.gmail.com>
Date: Sat, 8 Apr 2006 18:10:14 +0800
From: "Coywolf Qi Hunt" <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] represent-dirty__centisecs-as-jiffies-internally.patch comment fix
Cc: bart@samwel.tk, "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10168_31836365.1144491014957"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_10168_31836365.1144491014957
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

2006/3/25, akpm@osdl.org <akpm@osdl.org>:

> From: Bart Samwel <bart@samwel.tk>
>
> Make that the internal values for:
>
> /proc/sys/vm/dirty_writeback_centisecs
> /proc/sys/vm/dirty_expire_centisecs
>
> are stored as jiffies instead of centiseconds.  Let the sysctl interface =
do
> the conversions with full precision using clock_t_to_jiffies, instead of
> doing overflow-sensitive on-the-fly conversions every time the values are
> used.

> diff -puN mm/page-writeback.c~represent-dirty__centisecs-as-jiffies-inter=
nally mm/page-writeback.c
> --- devel/mm/page-writeback.c~represent-dirty__centisecs-as-jiffies-inter=
nally  2006-03-24 03:00:41.000000000 -0800
> +++ devel-akpm/mm/page-writeback.c      2006-03-24 03:00:41.000000000 -08=
00
> @@ -75,12 +75,12 @@ int vm_dirty_ratio =3D 40;
>   * The interval between `kupdate'-style writebacks, in centiseconds
>   * (hundredths of a second)

Bart,

You forgot to fix the comments. The attached patch fixes them.
--
Coywolf Qi Hunt

------=_Part_10168_31836365.1144491014957
Content-Type: text/x-patch; 
	name=represent-dirty__centisecs-as-jiffies-internally-comment-fix.diff; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: 0.1
Content-Disposition: attachment; filename="represent-dirty__centisecs-as-jiffies-internally-comment-fix.diff"


Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6dcce3a..75d7f48 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -72,13 +72,12 @@ int dirty_background_ratio = 10;
 int vm_dirty_ratio = 40;
 
 /*
- * The interval between `kupdate'-style writebacks, in centiseconds
- * (hundredths of a second)
+ * The interval between `kupdate'-style writebacks, in jiffies
  */
 int dirty_writeback_interval = 5 * HZ;
 
 /*
- * The longest number of centiseconds for which data is allowed to remain dirty
+ * The longest number of jiffies for which data is allowed to remain dirty
  */
 int dirty_expire_interval = 30 * HZ;
 

------=_Part_10168_31836365.1144491014957--
