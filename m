Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWF1G5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWF1G5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWF1G5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:57:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18612 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932749AbWF1G5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:57:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sam Vilain <sam@vilain.net>
Cc: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>,
       Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<44A1AF37.3070100@vilain.net>
	<m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
	<44A21F7A.5030807@vilain.net>
Date: Wed, 28 Jun 2006 00:55:25 -0600
In-Reply-To: <44A21F7A.5030807@vilain.net> (Sam Vilain's message of "Wed, 28
	Jun 2006 18:19:38 +1200")
Message-ID: <m1r719ixb6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> Eric W. Biederman wrote:
>> In general it is possible to get file descriptors opened by someone
>> else because unix domain sockets allow file descriptor passing.  Similarly
>> I think there are cases in both unshare and fork that allows you to sockets
>> open before you entered a namespace.
>>   
>
> This is an interesting point; it is known to be possible to do this on a
> traditional system, because with a Unix Domain socket, the other end is
> always in the same Unix Domain.
>
> However what we're doing is saying that, well, the other end of the
> socket might not be in the same Unix Domain. In fact, we've already
> smashed to pieces this monolithic concept of a Unix Domain, to the point
> where the other end might be in a different network domain, but is in
> the same filesystem domain, for instance. Does it get to pass file
> descriptors through?

Despite what it might look like unix domain sockets do not live in the
filesystem.  They store a cookie in the filesystem that roughly
corresponds to the port number of an AF_INET socket.  When you open a
socket the lookup is done by the cookie retrieved from the filesystem.
So except for their cookies unix domain sockets are always in the
network stack.

Which means it is a royal pain to create a unix domain socket between
namespaces.  Which is the generally desired behavior.

> We would appear to be stretching the definition of "Unix Domain"
> somewhat if we allow these sockets to exist between network namespaces.
> Maybe it doesn't matter; this is just a VFS namespace feature/caveat.

Unless I am mistaken this is something that can only be created (given
my describe semantics) when you create the container.  So if you want
it you got it but you can't create it if you never had it.

Eric
