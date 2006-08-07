Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWHGScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWHGScW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWHGScW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:32:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7246 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932293AbWHGScV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:32:21 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=ubkiIAYxf249fr4AcDE+Ju0mypW9qNvEEQmg7E9K8Cq3yB6Vlr9EorPAc6RXu+2Fa
	XPnXYca1MJKp6fE3bgrag==
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A
	cpu controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
In-Reply-To: <44D76B43.5080507@sw.ru>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 07 Aug 2006 11:31:26 -0700
Message-Id: <1154975486.31962.40.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 20:33 +0400, Kirill Korotaev wrote:
> >> we already have the code to account page fractions shared between 
> >> containers.
> >> Though, it is quite useless to do so for threads... Since this numbers 
> >> have no meaning (not a real usage)
> >> and only the sum of it will be a correct value.
> >>
> > THat sort of accounting poses various horrible problems, which is
> > why we steered away from it. If you share pages between containers
> > (presumably billing them equal shares per user), what happens
> > when you're already at your limit, and one of your sharer's exits?
> you come across your limit and new allocations will fail.
> BUT! IMPORTANT!
> in real life use case with OpenVZ we allow sharing not that much data across containers:
> vmas mapped as private, i.e. glibc and other libraries .data section
> (and .code if it is writable). So if you use the same glibc and other executables
> in the containers then your are charged only a fraction of phys memory used by it.
> This kind of sharing is not that huge (<< memory limits usually),
> so the situation you described is not a problem
> in real life (at least for OpenVZ).
> 

I think it is not a problem for OpenVZ because there is not that much of
sharing going between containers as you mentioned (btw, this least
amount of sharing is a very good thing).  Though I'm not sure if one has
to go to the extent of doing fractions with memory accounting.  If the
containers are set up in such a way that there is some sharing across
containers then it is okay to be unfair and charge one of those
containers for the specific resource completely.

-rohit

