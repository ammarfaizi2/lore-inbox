Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVE0UiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVE0UiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVE0UiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:38:25 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:24810 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262580AbVE0UiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:38:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=OTns7PN3onnjYNSMusEw7v1FHa5StOTq2QOVCoOwbpMYV9IPLH6YZv5PA4SUjg8OVrta10izZllkkbSA0evX16L5OqvquGT6/Puft7gpouRmaBZB89TRdqCc2iZRBm0V7Ioh0881pKTB9rCbD6XCobMi5vcqdxgi81xWbNd0Urs=
Message-ID: <4297853A.9030609@gmail.com>
Date: Fri, 27 May 2005 16:38:18 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI fan problems on HP pavilion desktop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up cpu clock modulation and ACPI fan support on my HP pavilion 
a302x, so it runs quieter when it's not doing anything (the fan is pretty loud). 
The cpufreq driver works great, but the ACPI fan driver not so good: it can turn 
the fan off but not back on again.

I changed these lines in drivers/acpi/power.c:

-       if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF)
-               return_VALUE(-ENOEXEC);
+       if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
+               ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+                       "Device [%s] says it's still on", resource->name));
+               resource->state = ACPI_POWER_RESOURCE_STATE_OFF;
+       }

and now I can turn the fan off and on again, so it works for me, but I want to 
figure out what's actually wrong so other people trying to run linux on this 
machine can have it Just Work(tm) for them. Is it just buggy hardware that 
doesn't comply with the ACPI spec? If so, is there some place where all the 
workarounds for hardware quirks are collected?

Keenan Pepper
