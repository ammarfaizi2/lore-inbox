Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWBHPfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWBHPfw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWBHPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:35:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:30847 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030378AbWBHPfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:35:51 -0500
Message-ID: <43EA1008.5040502@sw.ru>
Date: Wed, 08 Feb 2006 18:36:40 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
In-Reply-To: <43E8D160.4040803@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The pid-namespace (pspace) provides an approach of fully separate
> the allocation and maintenance of the pids and treating the <pspace,pid>
> tuple as an entity to uniquely identify a task and vice versa.
> As a result the logic of lookup can be pushed down the find_task_by_pid()
> lookup. There are specific cases where the init_task of a container or
> pspace needs to be checked to ensure that signals/waits and alike are 
> properly
> handled across pspace boundaries. I think this is an intuitive and clean 
> way.
> It also completely avoids the problem of having to think about all the 
> locations
> at the user/kernel boundary where a vpid/pid conversion needs to take 
> place.
> It also avoids the problems that logically vpids and pids are different 
> types and
> therefore it would have been good to have type checking automatically 
> identify
> problem spots.
> On the negative side, it does require to maintain a pidmap per pidspace.
Additional negative sides:
- full isolation can be inconvinient from containers management point of 
view. You will need to introduce new modified tools such as top/ps/kill 
and many many others. You won't be able to strace/gdb processes from the 
host also.
- overhead when virtualization is off, result is not the same.
- additional args everywhere (stack usage, etc.)

> The vpid approach has the drawbacks of having to identify the conversion 
> spots
> of all vpid vs. pid semantics. On the otherhand it does take advantage
> of the fact that no virtualization has to take place until a "container"
> has been migrated, thus rendering most of the vpid<->pid calls to be
> noops.
It has some other additional advantages:
- flexible: you can select full isolation or weak is required. I really 
believe this is very important.

> The container is just an umbrella object that ties every "virtualized" 
> subsystem
> together.
Yep. And containers were what I wanted to start with actually. Not VPIDs.

Kirill

