Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWITT5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWITT5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWITT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:57:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:39655 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932351AbWITT5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:57:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=G3l10ZOxqTv96n9dtECrPadPnZEfaGyeYD6wW9kBXRt8ImPKwsrxBi85o2tseO2GN
	pboDhMtsYxGkmQAf2EU+A==
Message-ID: <6599ad830609201257m22605deei25ae6a0eadb6c516@mail.google.com>
Date: Wed, 20 Sep 2006 12:57:10 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <1158780923.6536.110.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <1158780923.6536.110.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > At its most crude, this could be something like:
> >
> > struct container {
> > #ifdef CONFIG_CPUSETS
> >   struct cpuset cs;
> > #endif
> > #ifdef CONFIG_RES_GROUPS
> >   struct resource_group rg;
> > #endif
> > };
>
> Won't it restrict the user to choose one of these, and not both.

Not necessarily - you could have both compiled in, and each would only
worry about the resource management that they cared about - e.g. you
could use the memory node isolation portion of cpusets (in conjunction
with fake numa nodes/zones) for memory containment, but give every
cpuset access to all CPUs and control CPU usage via the resource
groups CPU controller.

The generic code would take care of details like container
creation/destruction (with appropriate callbacks into cpuset and/or
res_group code, tracking task membership of containers, etc.

Paul
