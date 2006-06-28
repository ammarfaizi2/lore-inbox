Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWF1OFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWF1OFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWF1OFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:05:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24547 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1423337AbWF1OFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:05:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, Andrey Savochkin <saw@swsoft.com>,
       dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>, Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<44A1AF37.3070100@vilain.net>
	<m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
	<44A21F7A.5030807@vilain.net>
	<m1r719ixb6.fsf@ebiederm.dsl.xmission.com> <44A251F2.70707@fr.ibm.com>
Date: Wed, 28 Jun 2006 08:03:41 -0600
In-Reply-To: <44A251F2.70707@fr.ibm.com> (Cedric Le Goater's message of "Wed,
	28 Jun 2006 11:54:58 +0200")
Message-ID: <m1bqsdidhe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>> Despite what it might look like unix domain sockets do not live in the
>> filesystem.  They store a cookie in the filesystem that roughly
>> corresponds to the port number of an AF_INET socket.  When you open a
>> socket the lookup is done by the cookie retrieved from the filesystem.
>
> unix domain socket lookup uses a path_lookup for sockets in the filesystem
> namespace and a find_by_name for socket in the abstract namespace.

Right.  And the abstract namespace does nothing with the current
filesystem.

>> So except for their cookies unix domain sockets are always in the
>> network stack.
>
> what is that cookie ? the file dentry and mnt ref ?

The socket entry in the filesystem but really the socket
inode number in that entry.  This entry has nothing to with dentry's
or mount refs so if I read the correctly every path to that socket
should yield the same entry.

> so, ok, the resulting struct sock is part of the network namespace but
> there is a bridge with the filesystem namespace which does not prevent
> other namespaces to do a lookup. the lookup routine needs to be changed,
> this is any way necessary for the abstract namespace.

Yep.

> I think we're reaching the limits of namespaces. It would be much easier
> with a container id in each kernel object we want to isolate.

Nope.  Except for the fact that names are peculiar (sockets, network
device names, IP address, routes...) the network stack splits quite cleanly.

I did all of this in a proof of concept mode several months ago and
the code is still sitting in my git tree on kernel.org.  I even got
the generic stack reference counting fixed.

Eric
