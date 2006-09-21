Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWIUBgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWIUBgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWIUBgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:36:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:20291 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750954AbWIUBgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:36:16 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=t3faUgCDN1F3gsk1JMHbXBqhcM3A5RLSqjnKUYCCAYwWq17kR3emxzg0DBNQCKmR6
	/vS0G29kH5PKfVTmyhOMg==
Message-ID: <6599ad830609201836s66623229y42d7301056e4a4e8@mail.google.com>
Date: Wed, 20 Sep 2006 18:36:01 -0700
From: "Paul Menage" <menage@google.com>
To: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [ckrm-tech] [Lhms-devel] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, pj@sgi.com,
       lhms-devel@lists.sourceforge.net, rohitseth@google.com,
       devel@openvz.org, clameter@sgi.com
In-Reply-To: <20060921103302.b57d288d.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	 <1158775678.8574.81.camel@galaxy.corp.google.com>
	 <20060920155815.33b03991.pj@sgi.com>
	 <1158794808.7207.14.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201629220.1859@schroedinger.engr.sgi.com>
	 <20060921095100.25e02b5c.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060921103302.b57d288d.kamezawa.hiroyu@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> For example
>
> In following scenario,
> ==
> (1). add <pid> > /mnt/configfs/containers/my_container/add_task
> (2). <pid> does some work.
> (3). echo <pid> > /mnt/configfs/containers/my_container/rm_task
> (4). echo <pid> > /mnt/configfs/containers/my_container2/add_task
> ==
> (if fake-pgdat/memory-hotplug is used)
> The pages used by <pid> in (2) will be accounted in 'my_container' after (3).
> Is this user's wrong use of system ?

Yes. You can't use memory node partitioning for file pages in this way
unless you have strict controls over who can access the data sets in
question, and are careful to prevent people from moving between
containers. So it's not suitable for all uses of resource-isolating
containers.

Who is to say that the pages allocated in (2) *should* be reaccounted
to my_container2 after (3)? Some people might want that, other
(including me) might not.

Paul
