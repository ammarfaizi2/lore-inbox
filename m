Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWCXTxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWCXTxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWCXTxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:53:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48600 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932657AbWCXTx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:53:29 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, serue@us.ibm.com,
       sam@vilain.net
Subject: Re: [RFC][PATCH 1/2] Virtualization of UTS
References: <44242B1B.1080909@sw.ru> <44242CE7.3030905@sw.ru>
	<m18xqzk6cy.fsf@ebiederm.dsl.xmission.com> <442449F8.4050808@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 12:50:36 -0700
In-Reply-To: <442449F8.4050808@sw.ru> (Kirill Korotaev's message of "Fri, 24
 Mar 2006 22:35:20 +0300")
Message-ID: <m1acbfipv7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>> This patch introduces utsname namespace in system, which allows to have
>>> different utsnames on the host.
>>> Introduces config option CONFIG_UTS_NS and uts_namespace structure for this.
>> Ok.  It looks like we need to resolve the sysctl issues before we merge
>> either patch, into the stable kernel.
> I disagree with you. Right now we can have sysctl and proc for init namespaces
> only.
> And when sysctl and proc are virtualized somehow, we can fix all these.
> I simply don't expect /proc and sysctl to be done quickly. As we have very
> different approaches. And there is no any consensus. Why not to commit
> working/agreed parts then?

So getting this code into Andrews development tree (as long as he is willing
to accept it) looks very reasonable.  We can't change the interface
once we get into the stable kernel because that becomes part of the
ABI.

So all I am saying is that this code is clearly not yet ready for
the stable branch, because we plan to change the sysctl interface.

>> We also need to discuss the system call interface, as without one
>> the functionality is unusable :)
> I also don't see why it can be separated. There is an API in namespaces, and how
> it is mapped into syscalls is another question. At least it doesn't prevent us
> from commiting virtualization itself, agree?

Separating the patches makes a lot of sense.  Putting something into
the kernel without any in tree users is a problem.

Eric
