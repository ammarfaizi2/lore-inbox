Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWC1FCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWC1FCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWC1FCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:02:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:18657 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751237AbWC1FCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:02:10 -0500
Date: Mon, 27 Mar 2006 06:45:17 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: devel@openvz.org, Sam Vilain <sam@vilain.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Mishin Dmitry <dim@sw.ru>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
Message-ID: <20060327124517.GA16114@sergelap.austin.ibm.com>
References: <20060321061333.27638.63963.stgit@localhost.localdomain> <1142967011.10906.185.camel@localhost.localdomain> <44206B58.5000404@vilain.net> <1142976756.10906.200.camel@localhost.localdomain> <4420885F.5070602@vilain.net> <m1bqvzq7de.fsf@ebiederm.dsl.xmission.com> <44241214.7090405@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44241214.7090405@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> Just to make it more clear: my understanding of word "nested" means that
> if you have, for example, a nested IPC namespace, than parent can see
> all the resources (sems, shms, ...) of it's children and have some
> private, while children see only its own set of private resources. But
> it doesn't look like you are going to implement anything like this.
> So what is nesting then? Ability to create namespace? To delegate it
> some part of own resource limits?

Nesting simply means that any child ns can create child namespaces of
it's own.

In particular, the following scenario should be perfectly valid:

	Machine 1                    Machine 2
	  Xen VM1.1                    Xen VM2.1
	    vserv 1.1.1                  vserv2.1.1
	      cont1.1.1.1                  cont2.1.1.1
	      cont1.1.1.2                  cont2.1.1.2
	      cont1.1.1.n                  cont2.1.1.n
	    vserv 1.1.2                  vserv2.1.2
	      cont1.1.2.1                  cont2.1.2.1
	      cont1.1.2.2                  cont2.1.2.2
	      cont1.1.2.n                  cont2.1.2.n
	  Xen VM1.2                    Xen VM2.2
	    vserv 1.2.1                  vserv2.2.1
	      cont1.2.1.1                  cont2.2.1.1
	      cont1.2.1.2                  cont2.2.1.2
	      cont1.2.1.n                  cont2.2.1.n
	    vserv 1.2.2                  vserv2.2.2
	      cont1.2.2.1                  cont2.2.2.1
	      cont1.2.2.2                  cont2.2.2.2
	      cont1.2.2.n                  cont2.2.2.n

where containers are used for each virtual server and each container,
so that we can migrate entire VMs, entire virtual servers, or any
container.

> >>>>Perhaps we can get a ruling from core team on this one, as it's
> >>>>aesthetics :-).
> I propose to use "namespace" naming.
> 1. This is already used in fs.
> 2. This is what IMHO suites at least OpenVZ/Eric
> 3. it has good acronym "ns".

I agree.

-serge
