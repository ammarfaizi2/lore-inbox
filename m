Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVD1TVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVD1TVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVD1TVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:21:39 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:34646 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262239AbVD1TVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:21:30 -0400
Date: Thu, 28 Apr 2005 12:21:12 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050428192112.GA355@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050425165705.GA11938@redhat.com> <20050427214136.GC938@ca-server1.us.oracle.com> <20050428034550.GA10628@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428034550.GA10628@redhat.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:45:50AM +0800, David Teigland wrote:
> We were questioned for 32 being unnecessarily large when we started, which
> seems to make a case for it being configurable.
Agreed.

> Which means without EXPEDITE it could go on the waiting queue.  I suspect
> EXPEDITE was invented because most people want NL requests to work as you
> suggest, despite the rules.
Ok, fair enough -- as long as there's a way to immediately grant NL
requests, I'm happy :)

> Interesting, I was reading about this recently and wondered if people
> really used it.  I figured parent/child locks were probably a more common
> way to get similar benefits.
> 
> Just to clarify, though:  when the LOCAL resource is immediately created
> and mastered locally, there must be a resource directory entry added for
> it, right?  For us, the resource directory entry is added as part of a new
> master lookup (which is being skipped).  If you don't add a directory
> entry, how does another node that later wants to lock the same resource
> (without LOCAL) discover who the master is?
Yes, I believe LOCAL would always have to at least add a directory entry.
For the OCFS2 dlm which does not use a resource directory, the entry would
just exist on the creating node and other nodes would discover it later via
query.
 
> If I understand LOCAL correctly, it should be simple for us to do.  We'd
> still have a LOCAL request _send_ the lookup to create the directory
> entry, but we'd simply not wait for the reply.  We'd assume, based on
> LOCAL, that the lookup result indicates we're the master.
I assume then that you can do that without racing the node who sent the
LOCAL request and another node who comes in (just afterwards) for a master
lookup? I bet the answer to that question would come to me if I read more of
the code :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
