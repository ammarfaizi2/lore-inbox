Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWIUBwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWIUBwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIUBwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:52:40 -0400
Received: from smtp-out.google.com ([216.239.33.17]:20309 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750973AbWIUBwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:52:39 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=PPTqEjfg+DQoJxnRfLJrnRAsJjP+ddglFV3tTtT+Inc9JS4c6hTptTuUMQJRuixjo
	kyUsoqHdRsL7bWiM01ojg==
Message-ID: <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
Date: Wed, 20 Sep 2006 18:52:30 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Paul Jackson" <pj@sgi.com>, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <1158803120.6536.139.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> Interesting. So you could set up the fake node with "guarantee" and let
> it grow till "limit" ?

Sure - that works great. (Theoretically you could do this all in
userspace - start by assigning  "guarantee" nodes to a
container/cpuset and when it gets close to its memory limit assign
more nodes to it. But in practice userspace can't keep up with rapid
memory allocators.

>
> BTW, can you do these with fake nodes:
>  - dynamic creation
>  - dynamic removal
>  - dynamic change of size

The current fake numa support requires you to choose your node layout
at boot time - I've been working with 64 fake nodes of 128M each,
which gives a reasonable granularity for dividing a machine between
multiple different sized jobs.

>
> Also, How could we account when a process moves from one node to
> another ?

If you want to do that (the systems I'm working on don't really) you
could probably do it with the migrate_pages() syscall. It might not be
that efficient though.

Paul
