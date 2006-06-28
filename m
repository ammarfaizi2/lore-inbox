Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWF1EfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWF1EfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 00:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWF1EfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 00:35:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16333 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030371AbWF1EfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 00:35:24 -0400
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
Date: Tue, 27 Jun 2006 22:33:48 -0600
In-Reply-To: <44A1AF37.3070100@vilain.net> (Sam Vilain's message of "Wed, 28
	Jun 2006 10:20:39 +1200")
Message-ID: <m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> It sounds then like it would be a good start to have general socket
> namespaces, if it would merge more easily - perhaps then network device
> namespaces would fall into place more easily.


I guess I really see both sockets and devices as the fundamental
entities of a network namespace.  Sockets need to be tagged because
in the general case there is no guarantee that a socket that you are
using was created in the network namespace of your current process.

In general it is possible to get file descriptors opened by someone
else because unix domain sockets allow file descriptor passing.  Similarly
I think there are cases in both unshare and fork that allows you to sockets
open before you entered a namespace.

Since you can't create a new socket in a different network namespace
I can't see any real problems with allowing them to be used, but they
are something to be careful about in container creation code.

Something to examine here is that if both network devices and sockets
are tagged does that still allow implicit network namespace passing.

Eric
