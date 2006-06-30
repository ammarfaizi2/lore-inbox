Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932966AbWF3Rnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbWF3Rnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932963AbWF3Rnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:43:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60550 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932899AbWF3Rnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:43:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       Sam Vilain <sam@vilain.net>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: strict isolation of net interfaces
References: <1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net>
	<44A450D1.2030405@fr.ibm.com>
	<20060630023947.GA24726@sergelap.austin.ibm.com>
	<44A517B4.4010500@fr.ibm.com>
	<m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
	<20060630161442.GA27210@sergelap.austin.ibm.com>
Date: Fri, 30 Jun 2006 11:41:59 -0600
In-Reply-To: <20060630161442.GA27210@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 30 Jun 2006 11:14:42 -0500")
Message-ID: <m1k66ybkwo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> This whole debate on network devices show up in multiple network namespaces
>> is just silly.  The only reason for wanting that appears to be better
> management.
>
> A damned good reason.  

Better management is a good reason.  But constructing the management in 
a way that hampers the implementation and confuses existing applications is
a problem.

Things are much easier if namespaces are completely independent.

Among other things the semantics are clear and obvious.

> Clearly we want the parent namespace to be able
> to control what the child can do.  So whatever interface a child gets,
> the parent should be able to somehow address.  Simple iptables rules
> controlling traffic between it's own netdevice and the one it hands it's
> children seem a good option.

That or we setup the child and then drop CAP_NET_ADMIN.

>> We have deeper issues like can we do a reasonable implementation without a
>> network device showing up in multiple namespaces.
>
> Isn't that the same issue?

I guess I was thinking from the performance and cleanliness point of
view.

>> If we can get layer 2 level isolation working without measurable overhead
>> with one namespace per device it may be worth revisiting things.  Until
>> then it is a side issue at best.
>
> Ok, and in the meantime we can all use the network part of the bsdjail
> lsm?  :)

If necessary.  But mostly we concentrate on the fundamentals and figure
out what it takes to take the level 2 stuff working.

Eric

