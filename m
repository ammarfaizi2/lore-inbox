Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVCVFlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVCVFlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVCVFhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:37:42 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:31961 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262518AbVCVFc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:32:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=n2HTpBBmIk2eJQre6ddsTp7BdSKOfjri1ol/EMfE4lvIXp+lUEgbct7jRGdw6wwqKfBqq4K4I12pHJhLuQ+nQ7WaF/k6RInI1Va+oHNQU+M9ZR5N4eUSy7MNOMGKfh4Ug7wIG87qETD0bmNNisr1ZofnPz+i3zx47Jec39VpecQ=
Message-ID: <cb57165a050321213210961749@mail.gmail.com>
Date: Mon, 21 Mar 2005 21:32:50 -0800
From: All Linux <allinux@gmail.com>
Reply-To: All Linux <allinux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.12-rc1, ./drivers/base/platform.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest prepatch, 2.6.12-rc1, introduced the following change.

--- a/drivers/base/platform.c   2005-03-17 17:35:04 -08:00
+++ b/drivers/base/platform.c   2005-03-17 17:35:04 -08:00
@@ -131,7 +131,7 @@
         pdev->dev.bus = &platform_bus_type;
 
         if (pdev->id != -1)
-                snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u",
pdev->name, pdev->id);
+                snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%u",
pdev->name, pdev->id);
         else
                 strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);

It causes problem, as most platform files, for example,
arch/ppc/platforms/katana.c, still use the old name without ".". I do
not understand why bus_id "mpsc.0" is better than "mpsc0".
Please explain what is the benefit of introducing such a change,
before I can submit a patch for all those platform files to work with
this change.
Please CC me, as I am currently not in the list.

Thanks,

Lee
