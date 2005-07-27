Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVG0Qmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVG0Qmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVG0Qhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:37:33 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:56330 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261302AbVG0Qf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 12:35:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=OOxVWCcwiGomwIuHjrG5BMJaM521qxU0GEviyRBgnfG8BSzk7r3l6DURyB5WQ5o+hNAxDrdtCcsa+5SYlhcvFMFkL3rrJbf7IYUO9fyCnQlkdGVn6PkGMXzVgC2dPwmLVDEovnf0OLJVffRdrkSJh7q01MXpmZLPqepMF90nNnY=
Message-ID: <42E7AF99.8070509@gmail.com>
Date: Wed, 27 Jul 2005 16:00:25 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] Real-Time Preemption V0.7.51-38: fix compile bug
 in drivers/block/paride/pseudo.h
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, built against kernel version 2.6.13-rc3, fixes a small bug in
drivers/block/paride/pseudo.h which prevents its related drivers from being
compiled successfully when RT patch (version 0.7.51-38) is compiled in.
This is due to the new definition of DEFINE_SPINLOCK macro, which does not
longer accept additional attributes.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- ./drivers/block/paride/pseudo.h.orig 2005-03-02 21:39:37.000000000 +0000
+++ ./drivers/block/paride/pseudo.h	 2005-07-27 15:37:50.000000000 +0000
@@ -43,7 +43,7 @@
 static int ps_tq_active = 0;
 static int ps_nice = 0;

-static DEFINE_SPINLOCK(ps_spinlock __attribute__((unused)));
+static  __attribute__((unused)) DEFINE_SPINLOCK(ps_spinlock);

 static DECLARE_WORK(ps_tq, ps_tq_int, NULL);




Regards,
-- 
					Luca


