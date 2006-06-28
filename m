Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423247AbWF1JzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423247AbWF1JzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423248AbWF1JzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:55:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:23522 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423247AbWF1JzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:55:08 -0400
Message-ID: <44A251F2.70707@fr.ibm.com>
Date: Wed, 28 Jun 2006 11:54:58 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Sam Vilain <sam@vilain.net>, Andrey Savochkin <saw@swsoft.com>,
       dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>, Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>	<20060627215859.A20679@castle.nmd.msu.ru>	<44A1AF37.3070100@vilain.net>	<m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>	<44A21F7A.5030807@vilain.net> <m1r719ixb6.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r719ixb6.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Despite what it might look like unix domain sockets do not live in the
> filesystem.  They store a cookie in the filesystem that roughly
> corresponds to the port number of an AF_INET socket.  When you open a
> socket the lookup is done by the cookie retrieved from the filesystem.

unix domain socket lookup uses a path_lookup for sockets in the filesystem
namespace and a find_by_name for socket in the abstract namespace.

> So except for their cookies unix domain sockets are always in the
> network stack.

what is that cookie ? the file dentry and mnt ref ?

so, ok, the resulting struct sock is part of the network namespace but
there is a bridge with the filesystem namespace which does not prevent
other namespaces to do a lookup. the lookup routine needs to be changed,
this is any way necessary for the abstract namespace.

I think we're reaching the limits of namespaces. It would be much easier
with a container id in each kernel object we want to isolate.

C.
