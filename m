Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUCCKhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUCCKhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:37:45 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:30877 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262425AbUCCKho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:37:44 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Mar 2004 02:38:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Ben <linux-kernel-junk-email@slimyhorror.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: epoll and fork()
In-Reply-To: <4044A764.1030304@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0403030231110.25251-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Chris Friesen wrote:

> Davide Libenzi wrote:
> 
> > Sorry but what behaviour do you expect by unregistering an fd pushed by 
> > the parent from inside a child? Events work exactly the same. Since the 
> > context is shared, events are delivered only once.
> 
> For principle of least surprise, I would expect that the refcounts would 
> be bumped up so that the child could deregister without affecting the 
> parent.
> 
> Closing the fd in the child doesn't affect the fd in the parent. 
> Removing an fd from an fd_set in the child doesn't affect the fd_set in 
> the parent.  Unregistering an fd from an epoll set in the child 
> shouldn't affect the parent either.

There are two issues here. One is the fact that *explicitly* unregistering 
the fd in one task and expecting the other one to act as if it was 
registered could be considered a sign of a not clean interaction between 
parent and child. The ref-count thing would not work because it is the 
kernel that automatically and directly bumps the ref count, w/out calling 
any f_op->xxxx() (like for example use/release). So epoll would have to 
hook the file get function, detect if the fd is inside an epoll fd, and 
take proper action by bumping its count. IMO it is not worth even 
considering.



- Davide


