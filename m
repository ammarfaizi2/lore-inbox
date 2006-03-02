Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751960AbWCBIlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbWCBIlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbWCBIlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:41:42 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:56008 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751960AbWCBIll convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:41:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uOgvpyT8uOMqYSWGL6+w9wHcSno3uVW218AC+HFHAReO7Ln8aYYHkWQSfyTzMwuhtLzTNNkNy0B9XJ2NJTkXZ44ocoEG/Py9A0sJTZUxW1kA1O8CEgtT1okT76YhnfGwAhIEpCPf9/cuJIrTDeIIBVCTeObwJCNqYa6bd0C8uhY=
Message-ID: <c38b25e50603020041w405c5f93i611dcb7954dfbbef@mail.gmail.com>
Date: Thu, 2 Mar 2006 00:41:40 -0800
From: "Anush Elangovan" <anush.e@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Define BITS_PER_BYTE to fix compilation error in 2.6.15.5
Cc: chrisw@sous-sol.org, gregkh@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like mm/mempolicy.c requires BITS_PER_BYTE, which is not defined
in 2.6.15.5. Patch below fixes the issue. 2.6.16rc5 seems to have the
#define

Signed-off-by: Anush Elangovan (anush.e@gmail.com)

diff -rup linux-2.6.15.5/include/linux/types.h
linux-2.6.15.5_fix/include/linux/types.h
--- linux-2.6.15.5/include/linux/types.h        2006-03-01
14:37:27.000000000 -0800
+++ linux-2.6.15.5_fix/include/linux/types.h    2006-03-01
23:39:43.000000000 -0800
@@ -8,6 +8,8 @@
        (((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
        unsigned long name[BITS_TO_LONGS(bits)]
+
+#define BITS_PER_BYTE 8
 #endif

 #include <linux/posix_types.h>
