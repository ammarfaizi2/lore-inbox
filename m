Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWAWOka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWAWOka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAWOka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:40:30 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:26304 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751451AbWAWOka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:40:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=O0qwc7jNeDwzZu+8cFoOtRji7fyerDM90zOxGlM75zbLpI1xQNUfTh4SZW8cbaEDzV21rVTU+mSHKpTUdg/jnHJatFUrq5Smu60KpEQKIXTJZdyGJsrLYxEDlkCWtjxfowIX9gxvxwwQ0IgHbZyNerj+D0bAD0mlCqT/tLvo5eQ=
Message-ID: <8e8498350601230640x49d8f866q@mail.gmail.com>
Date: Mon, 23 Jan 2006 23:40:28 +0900
From: Tetsuo Takata <takatan.linux@gmail.com>
To: akpm@osdl.org
Subject: [PATCH] enable XFS write barrier
Cc: linux-kernel@vger.kernel.org, doubt@developer.osdl.jp
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_332_8088272.1138027228273"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_332_8088272.1138027228273
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SSBmb3VuZCBvdXQgdGhhdCB0aGUgcS0+b3JkZXJlZCBpcyBub3QgYmVpbmcgc2V0IHByb3Blcmx5
IG9uIFhGUy4KCgpJJ20gdGVzdGluZyB0aGUgd3JpdGUgYmFycmllciBzdXBwb3J0IG9mIFhGUy4K
SSBydW4gdGhlIHRlc3Qgb24ga2VybmVsIDIuNi4xNi1yYzEtZ2l0NC4KYnV0IEkgZm91bmQgb3V0
IHRoYXQgdGhlICItbyBiYXJyaWVyIiBvcHRpb24gaXMgYXV0b21hdGljYWxseSBkaXNhYmxlZApp
biBteSBlbnZpcm9ubWVudC4KRm9yIHRoaXMgcmVhc29uIEkgY291bGQgbm90IHRlc3QgdGhlIHdy
aXRlIGJhcnJpZXIncyBleGVjdXRpb24gcGF0aC4KClRoZSBlcnJvciBtZXNzYWdlIGluICIvdmFy
L2xvZy9tZXNzYWdlcyIgaXM6CkZpbGVzeXN0ZW0gInNkYjEiOiBEaXNhYmxpbmcgYmFycmllcnMs
IG5vdCBzdXBwb3J0ZWQgYnkgdGhlIHVuZGVybHlpbmcgZGV2aWNlCgoKVGhpcyBwYXRjaCBmaXhl
cyB0aGVzZSBidWdzLgoKCkJlc3QgcmVnYXJkcywKClRldHN1byBUYWthdGEK
------=_Part_332_8088272.1138027228273
Content-Type: application/octet-stream; name=2.6.16-rc1-git4-sd.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.16-rc1-git4-sd.patch"

The patch below fixes the aforementioned problem.

Signed-off-by: Tetsuo Takata <takatatt@intellilink.co.jp>
---

diff -urpN linux-2.6.16-rc1-git4/block/ll_rw_blk.c linux-2.6.16-rc1-git4-fixed/block/ll_rw_blk.c
--- linux-2.6.16-rc1-git4/block/ll_rw_blk.c	2006-01-23 21:29:12.000000000 +0900
+++ linux-2.6.16-rc1-git4-fixed/block/ll_rw_blk.c	2006-01-23 22:05:11.000000000 +0900
@@ -332,6 +332,7 @@ int blk_queue_ordered(request_queue_t *q
 		return -EINVAL;
 	}
 
+	q->ordered = ordered;
 	q->next_ordered = ordered;
 	q->prepare_flush_fn = prepare_flush_fn;


------=_Part_332_8088272.1138027228273--
