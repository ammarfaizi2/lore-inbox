Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWCVGn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWCVGn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWCVGnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:43:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21177 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750938AbWCVGnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:43:22 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	<1142967011.10906.185.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 21 Mar 2006 23:41:49 -0700
In-Reply-To: <1142967011.10906.185.camel@localhost.localdomain> (Dave
 Hansen's message of "Tue, 21 Mar 2006 10:50:11 -0800")
Message-ID: <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-03-21 at 18:13 +1200, Sam Vilain wrote:
>> Here is a work in progress of trying to extract some the core vserver
>> architecture and present it as an incremental set of patches.
>
> Hi Sam,
>
> These patches are certainly getting better and better broken out all the
> time.  Nice work.
>
> But, I worry that they just aren't generic enough yet.  I don't see any
> response from any of the other "container/namespace/vps" people.  I fear
> that this means that they don't look broadly useful enough, yet.

Not broadly useful is certainly my impression.
It feels to me like these patches are simply doing too much.

> That said, at this point, I'd just about rather have _anything_ merged
> than the nothing we have at this point.  As we throw patches back and
> forth, we can't seem to agree on even some very small points.  
>
> I also have a sinking feeling that everybody has gone back off and
> continues to develop their own out-of-tree functionality, deepening the
> patch divide.

I certainly have not.  I do feel that developing this just from the
top down is the wrong way to do this.  In some of the preliminary
patches we have found several pieces of code that we will have to
touch that is currently in need of a cleanup.  That is why I have
been cleaning up /proc.  sysctl is in need of similar treatment
but is in less bad shape.

Part of it is that I have stopped to look more closely at what
other people are doing and to look at alternative implementations.

One interesting thing I have manged to do is by using ptrace I
have implemented enter for the existing filesystem namespaces 
without having to modify the kernel.  This at least says
that enter and debugging are two faces of the same coin.

> Is there anything we could merge that we _all_ don't like?  I'm pretty
> convinced that no single solution will support Eric's, OpenVZ's, and
> VServer's _existing_ usage models.  Somebody is going to have to bend,
> or nothing will ever get merged.  Any volunteers? ;)

I don't think that is the case on the fundamentals.  I think with pids
I am an inch away from implementing a pid namespace that is both
recursive, efficient, and can map all of the pids into another pid
space if that is desirable.  Plus I can merge most of it incrementally
in the existing kernel, before I even allow for multiple pid spaces.

Which should reduce the patch for multiple pid namespaces to something
reasonable to talk about.

> What about going back to the very simple "struct container" on which to
> build?

I guess my problem there is that isn't something on which to build
that is something to hang things off of. 

Eric
