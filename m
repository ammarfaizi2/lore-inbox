Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWITXWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWITXWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWITXWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:22:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:47395 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750931AbWITXWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:22:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=LDuJ/IzX/lhjh9d5mtuSHBoXxgzlqz2wKCHRDftdP7WHp/Vxc5NfZvCR4JbAenXHi
	pnq8nWqDeeM9xvuG0GlAg==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Paul Jackson <pj@sgi.com>
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060920155136.c35c874f.pj@sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <20060920155136.c35c874f.pj@sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 16:22:22 -0700
Message-Id: <1158794542.7207.10.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 15:51 -0700, Paul Jackson wrote:
> Seth wrote:
> > But am not sure
> > if this number of nodes can change dynamically on the running machine or
> > a reboot is required to change the number of nodes.
> 
> The current numa=fake=N kernel command line option is just boottime,
> and just x86_64.
> 

Ah okay.

> I presume we'd have to remove these two constraints for this to be 
> generally usable to containerize memory.
> 

Right.

> We also, in my current opinion, need to fix up the node_distance
> between such fake numa sibling nodes, to correctly reflect that they
> are on the same real node (LOCAL_DISTANCE).
> 
> And some non-trivial, arch-specific, zonelist sorting and reconstruction
> work will be needed.
> 
> And an API devised for the above mentioned dynamic changing.
> 
> And this will push on the memory hotplug/unplug technology.
> 

Yes, if we use the existing notion of nodes for other purposes then you
have captured the right set of changes that will be needed to make that
happen.  Such changes are not required for container patches as such.

> All in all, it could avoid anything more than trivial changes to the
> existing memory allocation code hot paths.  But the infrastructure
> needed for managing this mechanism needs some non-trivial work.
> 
> 
> > Though when you want to have in access of 100 containers then the cpuset
> > function starts popping up on the oprofile chart very aggressively.
> 
> As the linux-mm discussion last weekend examined in detail, we can
> eliminate this performance speed bump, probably by caching the
> last zone on which we found some memory.  The linear search that was
> implicit in __alloc_pages()'s use of zonelists for many years finally
> become explicit with this new usage pattern.
> 

Okay.

> 
> > Containers also provide a mechanism to move files to containers. Any
> > further references to this file come from the same container rather than
> > the container which is bringing in a new page.
> 
> I haven't read these patches enough to quite make sense of this, but I
> suspect that this is not a distinction between cpusets and these
> containers, for the basic reason that cpusets doesn't need to 'move'
> a file's references because it has no clue what such are.
> 

But container support will allow the certain files pages to come from
the same container irrespective of who is using them.  Something useful
for shared libs etc.

-rohit

> 
> > In future there will be more handlers like CPU and disk that can be
> > easily embeded into this container infrastructure.
> 
> This may be a deciding point.
> 



