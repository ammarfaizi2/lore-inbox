Return-Path: <linux-kernel-owner+w=401wt.eu-S965159AbWL2Ut3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWL2Ut3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWL2Ut2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:49:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:60510 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965159AbWL2Ut1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:49:27 -0500
To: Martin Stoilov <mstoilov@odesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_add unreachable code
References: <4594BA09.1080509@odesys.com> <87k60azu8b.fsf@goat.bogus.local>
	<45954D19.5020905@odesys.com> <45955217.5050405@odesys.com>
From: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Date: Fri, 29 Dec 2006 21:49:18 +0100
In-Reply-To: <45955217.5050405@odesys.com> (Martin Stoilov's message of
 "Fri, 29 Dec 2006 09:36:23 -0800")
Message-ID: <87bqlmzaup.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Constant Variable,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Stoilov <mstoilov@odesys.com> writes:

> Martin Stoilov wrote:
>> Olaf Dietsche wrote:
>>   
>>> Martin Stoilov <mstoilov@odesys.com> writes:
>>>
>>>   
>>>     
>>>> The following code in kobject_add
>>>>     if (!kobj->k_name)
>>>>         kobj->k_name = kobj->name;
>>>>     if (!kobj->k_name) {
>>>>         pr_debug("kobject attempted to be registered with no name!\n");
>>>>         WARN_ON(1);
>>>>         return -EINVAL;
>>>>     }
>>>>
>>>> doesn't look right to me. The second 'if' statement looks useless after
>>>> the assignment in the first one. May be it was meant to be like:
>>>> if (!*kobj->k_name)
>>>>     
>>>>       
>>> The second test is true, if kobj->name is NULL as well.
>>>   
>>>     
>> And how would that ever be true? kobj->name is a buffer inside kobj:
>>
>> struct kobject <http://localhost/lxr/http/ident?i=kobject> {
>> 	const char              * k_name;
>> 	char                    name <http://localhost/lxr/http/ident?i=name>[KOBJ_NAME_LEN <http://localhost/lxr/http/ident?i=KOBJ_NAME_LEN>];
>>
>> kobj->name will not be NULL, even if kobj itself is NULL.
>>   
>
> Oops, I am sorry for sending badly formated text! Here it is:
>
> I don't understand how would that ever be true? kobj->name is a buffer inside kobj:
>
> struct kobject {
>     const char      * k_name;
>     char            name[KOBJ_NAME_LEN];
>
> kobj->name will not be NULL, even if kobj itself is NULL.

Shame on me! I just looked at kobject_add() without a clue about struct
kobject. You're right, of course.

Regards, Olaf.
