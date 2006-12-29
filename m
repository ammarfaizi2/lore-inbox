Return-Path: <linux-kernel-owner+w=401wt.eu-S1755056AbWL2RPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbWL2RPW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbWL2RPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:15:22 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:20901 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbWL2RPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:15:21 -0500
Date: Fri, 29 Dec 2006 09:15:05 -0800
From: Martin Stoilov <mstoilov@odesys.com>
Subject: Re: kobject_add unreachable code
In-reply-to: <87k60azu8b.fsf@goat.bogus.local>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <45954D19.5020905@odesys.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
References: <4594BA09.1080509@odesys.com> <87k60azu8b.fsf@goat.bogus.local>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:
> Martin Stoilov <mstoilov@odesys.com> writes:
>
>   
>> The following code in kobject_add
>>     if (!kobj->k_name)
>>         kobj->k_name = kobj->name;
>>     if (!kobj->k_name) {
>>         pr_debug("kobject attempted to be registered with no name!\n");
>>         WARN_ON(1);
>>         return -EINVAL;
>>     }
>>
>> doesn't look right to me. The second 'if' statement looks useless after
>> the assignment in the first one. May be it was meant to be like:
>> if (!*kobj->k_name)
>>     
>
> The second test is true, if kobj->name is NULL as well.
>   
And how would that ever be true? kobj->name is a buffer inside kobj:

struct kobject <http://localhost/lxr/http/ident?i=kobject> {
	const char              * k_name;
	char                    name <http://localhost/lxr/http/ident?i=name>[KOBJ_NAME_LEN <http://localhost/lxr/http/ident?i=KOBJ_NAME_LEN>];

kobj->name will not be NULL, even if kobj itself is NULL.

> Regards, Olaf.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

-Martin
