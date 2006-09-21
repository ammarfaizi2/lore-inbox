Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWIUAmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWIUAmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWIUAmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:42:35 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21560 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750864AbWIUAme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:42:34 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=fSrJSlxffO0f1uEpqjoyNSpVxKAZDesokcCmT0qj/TojeROaMlR8+/w1jJFvjlvRN
	TZe66uSz5XdJIIl3BWhYw==
Message-ID: <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
Date: Wed, 20 Sep 2006 17:42:22 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
In-Reply-To: <20060920173638.370e774a.pj@sgi.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> Chandra wrote:
> > AFAICS, That doesn't help me in over committing resources.
>
> I agree - I don't think cpusets plus fake numa ... handles over commit.
> You might could hack up a cheap substitute, but it wouldn't do the job.

I have some patches locally that basically let you give out a small
set of nodes initially to a cpuset, and if memory pressure in
try_to_free_pages() passes a specified threshold, automatically
allocate one of the parent cpuset's unused memory nodes to the child
cpuset, up to specified limit. It's a bit ugly, but lets you trade of
performance vs memory footprint on a per-job basis (when combined with
fake numa to give lots of small nodes).

Paul
