Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWIHVQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWIHVQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIHVQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:16:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:8022 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751260AbWIHVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:16:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=BSdZ8LZWved0PLoGod/dj7CusXDgb05zO8b2lt7lnPdlnGWQpOPx0DdT4pzBMpsWY
	xIp8QODCwp2vemzAk048A==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <4501A7DD.8040305@watson.ibm.com>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>
	 <1157501878.11268.77.camel@galaxy.corp.google.com>
	 <1157729450.26324.44.camel@localhost.localdomain>
	 <1157735437.1214.32.camel@galaxy.corp.google.com>
	 <4501A7DD.8040305@watson.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 08 Sep 2006 14:15:35 -0700
Message-Id: <1157750135.1214.94.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 13:26 -0400, Shailabh Nagar wrote:

> Also maintenability, licensing, blah, blah.
> Replicating the software stack for each service level one
> wishes to provide, if avoidable as it seems to be, isn't such a good idea.
> Same sort of reasoning for why containers make sense compared to Xen/VMWare
> instances.
> 

Having a container per service level seems like an okay thing to me.

> Memory resources, by their very nature, will be tougher to account when a
> single database/app server services multiple clients and we can essentially
> give up on that (taking the approach that only limited recharging can ever
> be achieved). 

What exactly you mean by limited recharging?  

As said earlier, if there is big shared segment on a server then that
can be charged to any single container.  And in this case moving a task
to different container may not fetch anything useful from memory
accounting pov.

> But cpu atleast is easy to charge correctly and since that will
> also indirectly influence the requests for memory & I/O, its useful to allow
> middleware to change the accounting base for a thread/task.
> 

That is not true.   It depends on IO size, memory foot print etc. etc.
You can move a task to different container, but it will not be cheap.

-rohit


