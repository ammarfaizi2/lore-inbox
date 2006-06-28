Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWF1GTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWF1GTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWF1GTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:19:11 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:32175 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1030393AbWF1GTJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:19:09 -0400
Message-ID: <44A21F7A.5030807@vilain.net>
Date: Wed, 28 Jun 2006 18:19:38 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>,
       Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>	<20060627215859.A20679@castle.nmd.msu.ru>	<44A1AF37.3070100@vilain.net> <m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> In general it is possible to get file descriptors opened by someone
> else because unix domain sockets allow file descriptor passing.  Similarly
> I think there are cases in both unshare and fork that allows you to sockets
> open before you entered a namespace.
>   

This is an interesting point; it is known to be possible to do this on a
traditional system, because with a Unix Domain socket, the other end is
always in the same Unix Domain.

However what we're doing is saying that, well, the other end of the
socket might not be in the same Unix Domain. In fact, we've already
smashed to pieces this monolithic concept of a Unix Domain, to the point
where the other end might be in a different network domain, but is in
the same filesystem domain, for instance. Does it get to pass file
descriptors through?

We would appear to be stretching the definition of "Unix Domain"
somewhat if we allow these sockets to exist between network namespaces.
Maybe it doesn't matter; this is just a VFS namespace feature/caveat.

Sam.
