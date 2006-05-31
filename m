Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWEaKEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWEaKEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 06:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEaKEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 06:04:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:21324 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964924AbWEaKEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 06:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ijBCTqNmjZ6k7Q4vBZwA3bKUe0Bw/zY9oanD6OxtUlIRrt/g5PiW8Y6caMXnMfgFSzCxfQYtpXsvHKUkmThp6ZoCwmUrES7PURm5hHRijklGCcGm6qfQHL3pKyBdC8FnoYa5RYWVnWiYQ6tS6vxhvRG7p3nFv1AFs2iPZaZwgU8=
Message-ID: <447D6A28.4060909@gmail.com>
Date: Wed, 31 May 2006 13:04:24 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 12/12] input: use -ENOSPC instead of -ENOMEM in iforce
 when device full
References: <20060530105705.157014000@gmail.com>	<20060530110137.412646000@gmail.com> <20060530220205.103536b1.rdunlap@xenotime.net>
In-Reply-To: <20060530220205.103536b1.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 30 May 2006 13:57:17 +0300 Anssi Hannula wrote:
> 
> 
>>Use -ENOSPC instead of -ENOMEM when the iforce device doesn't have enough free
>>memory for the new effect. All other drivers are already been using -ENOSPC,
>>so this makes the behaviour coherent.
> 
> 
> Could all of the others be wrong?
> 

They could.

> ENOSPC: No space left on device
> ENOMEM: Not enough space [!?!?!?] or Out of memory
> 

Hmm, I thought -ENOMEM is "Out of memory" and only to be used when the
system is out of memory, not some internal memory chip in external device.

Does someone have an idea which one should be used?

> 
>>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
>>
>>---
>> drivers/input/joystick/iforce/iforce-ff.c |    8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)
>>
>>Index: linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c
>>===================================================================
>>--- linux-2.6.17-rc4-git12.orig/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:55:12.000000000 +0300
>>+++ linux-2.6.17-rc4-git12/drivers/input/joystick/iforce/iforce-ff.c	2006-05-26 16:57:13.000000000 +0300
>>@@ -47,7 +47,7 @@ static int make_magnitude_modifier(struc
>> 			iforce->device_memory.start, iforce->device_memory.end, 2L,
>> 			NULL, NULL)) {
>> 			mutex_unlock(&iforce->mem_mutex);
>>-			return -ENOMEM;
>>+			return -ENOSPC;
>> 		}
>> 		mutex_unlock(&iforce->mem_mutex);
>> 	}
>>@@ -80,7 +80,7 @@ static int make_period_modifier(struct i
>> 			iforce->device_memory.start, iforce->device_memory.end, 2L,
>> 			NULL, NULL)) {
>> 			mutex_unlock(&iforce->mem_mutex);
>>-			return -ENOMEM;
>>+			return -ENOSPC;
>> 		}
>> 		mutex_unlock(&iforce->mem_mutex);
>> 	}
>>@@ -120,7 +120,7 @@ static int make_envelope_modifier(struct
>> 			iforce->device_memory.start, iforce->device_memory.end, 2L,
>> 			NULL, NULL)) {
>> 			mutex_unlock(&iforce->mem_mutex);
>>-			return -ENOMEM;
>>+			return -ENOSPC;
>> 		}
>> 		mutex_unlock(&iforce->mem_mutex);
>> 	}
>>@@ -157,7 +157,7 @@ static int make_condition_modifier(struc
>> 			iforce->device_memory.start, iforce->device_memory.end, 2L,
>> 			NULL, NULL)) {
>> 			mutex_unlock(&iforce->mem_mutex);
>>-			return -ENOMEM;
>>+			return -ENOSPC;
>> 		}
>> 		mutex_unlock(&iforce->mem_mutex);
>> 	}
>>
>>--
> 
> 
> 
> ---
> ~Randy


-- 
Anssi Hannula

