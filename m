Return-Path: <linux-kernel-owner+w=401wt.eu-S965068AbWL2RqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWL2RqG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWL2RqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:46:05 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49964 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965067AbWL2RqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:46:04 -0500
Date: Fri, 29 Dec 2006 18:45:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Stoilov <mstoilov@odesys.com>
cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kobject_add unreachable code
In-Reply-To: <45955217.5050405@odesys.com>
Message-ID: <Pine.LNX.4.61.0612291843510.9799@yvahk01.tjqt.qr>
References: <4594BA09.1080509@odesys.com> <87k60azu8b.fsf@goat.bogus.local>
 <45954D19.5020905@odesys.com> <45955217.5050405@odesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 29 2006 09:36, Martin Stoilov wrote:
> Olaf Dietsche wrote:
>> Martin Stoilov <mstoilov@odesys.com> writes:
>>     
>>> The following code in kobject_add
>>>     if (!kobj->k_name)
>>>         kobj->k_name = kobj->name;
>>>     if (!kobj->k_name) {
>>>         pr_debug("kobject attempted to be registered with no name!\n");
>>>         WARN_ON(1);
>>>         return -EINVAL;
>>>     }
>>>
>>> doesn't look right to me. The second 'if' statement looks useless after
>>> the assignment in the first one. May be it was meant to be like:
>>> if (!*kobj->k_name)
>>>       
>> The second test is true, if kobj->name is NULL as well.
>
>I don't understand how would that ever be true? kobj->name is a buffer inside kobj:
>
>struct kobject {
>    const char      * k_name;
>    char            name[KOBJ_NAME_LEN];
>
>kobj->name will not be NULL, even if kobj itself is NULL.

So you probably found a bug. Maybe this was intended then?

     if (!kobj->k_name)
         kobj->k_name = kobj->name;
     if (*kobj->k_name == '\0') {
         pr_debug("kobject attempted to be registered with no name!\n");
         WARN_ON(1);
         return -EINVAL;
     }


	-`J'
-- 
