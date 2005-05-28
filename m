Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVE1Tys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVE1Tys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVE1Tys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 15:54:48 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:8455 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261178AbVE1Tyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 15:54:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=BQcd4alJ22jWLXSi9NXsimCb1dTFyyVY6R5NnfllUqko7GDQh1UYMTfq0FYFjbIiWHbX8lo3y3KOPD1v3KB5c0hwAKOxsLlDMzz8naJ6mEFV+e0oi6fsNeqwpWuheQBzL5ry5qhsFUONj2RKgAr39DUzYsRseBRxG9Lg9vgU84k=
Message-ID: <4298CC82.9010901@gmail.com>
Date: Sat, 28 May 2005 15:54:42 -0400
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

