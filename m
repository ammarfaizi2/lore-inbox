Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWITTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWITTZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWITTZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:25:24 -0400
Received: from smtp-out.google.com ([216.239.45.12]:34527 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932303AbWITTZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:25:22 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=m2y0b4PwD7OBFlaKvWK1LidUzI9gYwMJOHYkbJWt9smXt65VI9E189cgsYGUWJ5aW
	AxkxAMCkb/FSl6W0MxwUA==
Message-ID: <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
Date: Wed, 20 Sep 2006 12:25:15 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org,
       "Christoph Lameter" <clameter@sgi.com>
In-Reply-To: <1158778496.6536.95.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> We had this discussion more than 18 months back and concluded that it is
> not the right thing to do. Here is the link to the thread:

Even if the resource control portions aren't totally compatible,
having two separate process container abstractions in the kernel is
sub-optimal, both in terms of efficiency and userspace management. How
about splitting out the container portions of cpuset from the actual
resource control, so that CKRM/RG can hang off of it too? Creation of
a cpuset or a resource group would be driven by creation of a
container; at fork time, a task inherits its parent's container, and
hence its cpuset and/or resource groups.

At its most crude, this could be something like:

struct container {
#ifdef CONFIG_CPUSETS
  struct cpuset cs;
#endif
#ifdef CONFIG_RES_GROUPS
  struct resource_group rg;
#endif
};

but at least it would be sharing some of the abstractions.

Paul
