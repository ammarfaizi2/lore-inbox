Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWBHPme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWBHPme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWBHPme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:42:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:41814 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030381AbWBHPmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:42:33 -0500
Message-ID: <43EA11C5.5010908@sw.ru>
Date: Wed, 08 Feb 2006 18:44:05 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, Dmitry Mishin <dim@sw.ru>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>	<43E92602.8040403@vilain.net> <43E92AC9.3090308@watson.ibm.com> <m1oe1ia1c9.fsf@ebiederm.dsl.xmission.com> <43E9FC85.1000500@watson.ibm.com>
In-Reply-To: <43E9FC85.1000500@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My point was to mainly identify the performance culprits and provide
> an direct access to those "namespaces" for performance reasons.
> So we all agreed on that we need to do that..
After having looked at Eric's patch, I can tell that he does all these 
dereferences in quite the same amount.

For example, lot's of skb->sk->host->...
while in OpenVZ it would be econtainer()->... which is essentially 
current->container->...

So until someone did measurements it looks doubtfull that one solution 
is better than the another.

> Question now (see other's note as well), should we provide
> a pointer to each and every namespace in struct task.
> Seem rather wasteful to me as certain path/namespaces are not
> exercise heavily.

> Having one object "struct container" that still embodies all
> namespace still seems a reasonable idea.
> Otherwise identifying the respective namespace of subsystems will
> have to go through container->init->subsys_namespace or similar.
> Not necessarily bad either..

why not simply container->subsys_namespace?

Kirill




