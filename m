Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWBJGqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWBJGqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWBJGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:46:17 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37265 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751162AbWBJGqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:46:17 -0500
Date: Thu, 9 Feb 2006 22:46:12 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Claudio Martins <ctpm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: OCFS2 Filesystem inconsistency across nodes
Message-ID: <20060210064612.GE12046@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200602100536.02893.ctpm@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602100536.02893.ctpm@rnl.ist.utl.pt>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 10, 2006 at 05:36:02AM +0000, Claudio Martins wrote:
> 
>  (I'm posting this to lkml since ocfs2-users@oss.oracle.com doesn't seem
> to be accepting new subscription requests)
Thanks for testing this out :) There does indeed seem to be something wrong
with our mailing list, so thanks for pointing that out too.

<snip testing info>

>  At first I thought this might be caused by the metadata info being propagated 
> to the other nodes but the caches not being flushed to disk on the node that 
> wrote to a file. So I tested this by copying ~2GB sized files to try to cause 
> some memory pressure, yet with the same kind of disappointing results.
It definitely looks like the messages you're getting are due to some nodes
reading old or invalid metadata. If the cache is bad on the other nodes,
re-writing blocks from the same node won't necessarily make things better.

>  I'd like to know if anyone on the list has had the opportunity of testing 
> OCFS2 or had similar problems. OTOH, if I'm wrongly assuming something about 
> OCFS2 which I shouldn't be, please tell me and I'll apologise for wasting 
> your time ;-)
No, it doesn't seem like you're assuming any behavior that it shouldn't be
doing, so there's certainly something wrong going on. I have some
suggestions below. As far as testing goes, we have a pretty fair number of
folks running large production systems on this so I'd definitely say it's
getting tested ;) That said, things can always get temporarily broken,
which is where hearing from folks like you helps alot.

>  I'm willing to make any tests or apply any patches you want. I'll be trying 
> to keep the machines and the disk box for as many days as possible, so please 
> try to bug me if you think these are real bugs and you want me to test fixes 
> before 2.6.16 comes out.
>  If you need kernel .config or any other info please ask.
Great. We'll keep things simple at first. If I could get a copy of the
/etc/ocfs2/cluster.conf files from each node that'd be great. A full log of the
OCFS2 messages you see on each node, starting from mount to unmount would also
help. That includes any dlm_* messages - in particular the ones printed when
a node mounts and unmounts. If you're using any mount options it'd be
helpful to know those too.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
