Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWGMSQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWGMSQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWGMSQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:16:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15774 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030266AbWGMSQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:16:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
Date: Thu, 13 Jul 2006 12:14:25 -0600
In-Reply-To: <20060713174721.GA21399@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Thu, 13 Jul 2006 12:47:21 -0500")
Message-ID: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Rather than try to store (uid, namespace) on the filesystem, I like the
> idea of doing something like
>
> 	mount --bind -o ro --uidswap 500,1001 --uidswap 501,0 /home /home
>
> In other words, when you unshare the user namespace, nothing
> filesystem-related changes unless you also unshare the fs-namespace and
> set uid info on the vfsmount.  This is fully backward-compatible and
> should have no overhead if you don't need the feature.

Maybe.  I really think the sane semantics are in a different uid namespace.
So you can't assumes uids are the same.  Otherwise you can't handle open
file descriptors or files passed through unix domain sockets.

A user namespace is fundamentally about breaking the assumption that
you can test to see if two users are the same by comparing uids.
If you don't want to break that assumption don't use a user namespace.

Mapping uids is a separate but related problem that we probably need to
tackle in a generic manner, usable for network filesystems.

Eric
