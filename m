Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWCYSkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCYSkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWCYSkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:40:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56806 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750722AbWCYSku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:40:50 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	<1142967011.10906.185.camel@localhost.localdomain>
	<m1k6anq8uq.fsf@ebiederm.dsl.xmission.com> <44241224.9000200@sw.ru>
	<m13bh7io3i.fsf@ebiederm.dsl.xmission.com>
	<20060324210150.GA22308@MAIL.13thfloor.at>
	<m1u09nh7gb.fsf@ebiederm.dsl.xmission.com>
	<20060324214029.GD22308@MAIL.13thfloor.at>
	<m1slp7fpbj.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 25 Mar 2006 11:37:56 -0700
In-Reply-To: <m1slp7fpbj.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Fri, 24 Mar 2006 15:30:40 -0700")
Message-ID: <m1bqvufjzv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Herbert Poetzl <herbert@13thfloor.at> writes:
>
>> well, while /proc/mounts is a good example that it 'works'
>> it isn't a good example for proper design, as the entire
>> private namespaces lead to much obfuscation, and having
>> the mounts per process, where they actually should be per
>> namespace, and to hide the fact that there are different
>> namespaces does not help either ...
>>
>> IMHO a much better design would be to have the namespace
>> 'explicit' and link to that one, containig the mounts entry
>> btw, this is something which should still be possible
>> without breaking anything ...
>
> Actually I agree.  That should work for everything except sysctl.
>
> The tricky bit is going to be sticky a pid on the namespace group.
> But the patch should be quite simple.

Actually the tricky bit is that there is no way to list resources
that processes share, except for by looking at the processes.  Changing
that has performance implications and is at least slightly non-trivial.
Given that the primary upside is better debugging I'm not a fan.

I would much rather modify the interfaces to have double counts
and work like the network devices.  Where you get warnings when
someone is still using the device after it has been made to
go away.

I appreciate the concern, and I share it.  I just don't think
that right now there is a good mechanism to get better visibility.

Eric
