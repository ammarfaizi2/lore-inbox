Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161378AbWHDTZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161378AbWHDTZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWHDTZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:25:33 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54872 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161378AbWHDTZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:25:32 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=JUm0cJlY5cgtPA4RVmB4XSmJoJl9stjz9+2qMFlWX7NDW3jo/zQCgeFm8o7yahghg
	qfzh7Ak05MjYFv/iUm2Jg==
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management -
	A	cpu controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, haveblue@us.ibm.com, pj@sgi.com
In-Reply-To: <44D39BEE.9080304@watson.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <20060804153123.GB32412@in.ibm.com>  <44D36FB5.3050002@sw.ru>
	 <1154716024.7228.32.camel@galaxy.corp.google.com>
	 <44D39BEE.9080304@watson.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 04 Aug 2006 12:24:54 -0700
Message-Id: <1154719494.7228.65.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 15:11 -0400, Shailabh Nagar wrote:
> Rohit Seth wrote:
> 
> >>>The use cases I have heard of which would benefit such a feature is
> >>>(say) for database threads which want to change their "resource
> >>>affinity" status depending on which customer query they are currently handling. 
> >>>If they are handling a query for a "important" customer, they will want affinied
> >>>to a high bandwidth resource container and later if they start handling
> >>>a less important query they will want to give up this affinity and
> >>>instead move to a low-bandwidth container.
> > 
> > 
> > hmm, would it not be better to have a thread each in two different
> > containers for handling different kind of requests.  
> 
> Its possible but now you're effectively requiring the thread pool to
> expand as many times as service levels supported.
> 

Either increase the number of threads to match the number of security
levels OR have some kind of individual task priority changes.
Individual proceesses/tasks in a container should be able to have
different priorities.

> any long running job whose prioritization changes during its lifetime
> also benefits from being able to be moved.
> 

Moving a task (or any other resource for that matter) from one container
to another should be considered as an extreme step.  There are
associated resources like anon memeory etc. that need to also be
appropriately accounted in new container.

> 
> > Or if there is too
> > much of sharing between threads, then setting the individual priority
> > should help.
> > 

-rohit

