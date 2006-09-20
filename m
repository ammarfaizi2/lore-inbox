Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWITURq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWITURq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWITURq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:17:46 -0400
Received: from smtp-out.google.com ([216.239.45.12]:24813 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750726AbWITURg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:17:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=jtwBZDOgD2woxuP2+ZQ3Q4QzjO1aSyLb/Gay9SntmqXY/tIB5yExIqff/IP4X4QnU
	9f93x8A9oCZj3mdmUhpIA==
Message-ID: <6599ad830609201317r42e381c7u3ed9a29a3571970c@mail.google.com>
Date: Wed, 20 Sep 2006 13:17:25 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: sekharan@us.ibm.com, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
In-Reply-To: <20060920131151.4a810be2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <20060920131151.4a810be2.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> Paul M. wrote:
> > Rather than adding a new process container abstraction, wouldn't it
> > make more sense to change cpuset to make it more extensible (more
> > separation between resource controllers), possibly rename it to
> > "containers",
>
> Without commenting one way or the other on the overall advisability
> of this (for lack of sufficient clues), if we did this and renamed
> "cpusets" to "containers", we would still want to export the /dev/cpuset
> interface to just the CPU/Memory controllers.  Perhaps the "container"
> pseudo-filesystem could optionally be mounted with a "cpuset" option,
> that just exposed the cpuset relevant interface, or some such thing.

Absolutely - I was thinking that as a first cut, any subsystem (e.g.
cpusets, res_groups, etc) that wanted to use per-task containers could
declare what files it wanted a container dir populated with, so you
could have it looking just like cpusets if you wanted to, and mount it
on /dev/cpuset and use it exactly as before. If you then added the
res_group patch to your kernel, you would also get the appropriate
resource group files appearing in each directory, but the cpuset
support would work as before.

Longer term we'd probably want to figure out a better naming
partitioning scheme, or maybe just a convention that each directory
entry was prefixed with the subsystem name. Also, maybe have a
convention that control files and subcontainer names be in different
namespaces (e.g. all control files start with ".", all subcontainer
names start with something else).

Paul
