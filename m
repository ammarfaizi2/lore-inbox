Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWCXWd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWCXWd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 17:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCXWdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 17:33:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36572 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751516AbWCXWdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 17:33:54 -0500
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 15:30:40 -0700
In-Reply-To: <20060324214029.GD22308@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 24 Mar 2006 22:40:29 +0100")
Message-ID: <m1slp7fpbj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> well, while /proc/mounts is a good example that it 'works'
> it isn't a good example for proper design, as the entire
> private namespaces lead to much obfuscation, and having
> the mounts per process, where they actually should be per
> namespace, and to hide the fact that there are different
> namespaces does not help either ...
>
> IMHO a much better design would be to have the namespace
> 'explicit' and link to that one, containig the mounts entry
> btw, this is something which should still be possible
> without breaking anything ...

Actually I agree.  That should work for everything except sysctl.

The tricky bit is going to be sticky a pid on the namespace group.
But the patch should be quite simple.

>> So I am trying to turn an ugly design choice into feature :)
>
> hmm, no, you are trying to multipy an ugly design :)

Well only a bit :)

I'm still trying to turn the fact that weird things wound
up in /proc into a feature.


> /proc/self -> YYY/
> /proc/mounts -> self/mounts
>
> (so far nothing new)
>
> /proc/YYY/namespace -> ../namespace-XXX/
> /proc/YYY/mounts -> namespace/mounts 
>
> (or alternatively)
>
> /proc/namespace -> namespace-XXX/
> /proc/mounts -> namespace/mounts

Yes. Something like that.  It will take a little thinking.
But something that doesn't go away when a process does.

>> In any event this appears to be a way to implement these things while
>> retaining backwards compatibility, with the current implementation,
>> and it looks like it can be implemented fairly cleanly.
>
> I don't see any differences regarding compatibility when
> things like namespaces get explicit ...

Agreed.

Eric
