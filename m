Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWBHRSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWBHRSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWBHRSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:18:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53661 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030346AbWBHRSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:18:53 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, kuznet@ms2.inr.ac.ru, saw@sawoct.com,
       devel@openvz.org, Dmitry Mishin <dim@sw.ru>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<43EA1008.5040502@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 10:16:45 -0700
In-Reply-To: <43EA1008.5040502@sw.ru> (Kirill Korotaev's message of "Wed, 08
 Feb 2006 18:36:40 +0300")
Message-ID: <m1lkwl7oua.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Additional negative sides:
> - full isolation can be inconvinient from containers management point of
> view. You will need to introduce new modified tools such as top/ps/kill and many
> many others. You won't be able to strace/gdb processes from the host also.

Ok.  I have to pick a nit here.  Needing all new tools top/ps/kill was an artifact
of your implementation.  Mine does not suffer from it.

> - overhead when virtualization is off, result is not the same.
> - additional args everywhere (stack usage, etc.)

Agreed.  When using a PID namespace the code always behaves the same.
Which is with more arguments than the code used to have.
However the code always behaving the same is a tremendous advantage
for maintainability.

>> The vpid approach has the drawbacks of having to identify the conversion spots
>> of all vpid vs. pid semantics. On the otherhand it does take advantage
>> of the fact that no virtualization has to take place until a "container"
>> has been migrated, thus rendering most of the vpid<->pid calls to be
>> noops.
> It has some other additional advantages:
> - flexible: you can select full isolation or weak is required. I really believe
> this is very important.

I am willing to be convinced but so far there seem to be other solutions
like running gdb_stubs inside your container.  To address most of the issues.

In a fairly real sense mucking with a container from the outside appears
to be a sysadmin layering violation. 

>> The container is just an umbrella object that ties every "virtualized"
>> subsystem
>> together.
> Yep. And containers were what I wanted to start with actually. Not VPIDs.

The historical linux approach is to build things out of tasks sharing
resources that give the impression of containers not out containers
and their children.  I am still trying to understand why that model
does not work in this instance.

Eric

