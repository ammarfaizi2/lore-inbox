Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWIHPbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIHPbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIHPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:31:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:29580 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750758AbWIHPbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:31:10 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Dave Hansen <haveblue@us.ibm.com>
To: rohitseth@google.com
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <1157501878.11268.77.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>
	 <1157501878.11268.77.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 08:30:50 -0700
Message-Id: <1157729450.26324.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 17:17 -0700, Rohit Seth wrote:
> I'm wondering why not have different processes to serve different
> domains on the same physical server...particularly when they have
> different database to work on.

This is largely because this is I think how it is done today, and it has
a lot of disadvantages.  They also want to be able to account for
traffic on the same database.  Think of a large web hosting environment
where you charged everyone (hundreds or thousands of users) by CPU and
I/O bandwidth used at all levels of a given transaction.

> Is the amount of memory that you save by
> having a single copy that much useful that you are even okay to
> serialize the whole operation (What would happen, while the request for
> foo.com is getting worked on, there is another request for
> foo_bar.com...does it need to wait for foo.com request to get done
> before it can be served).

Let's put it this way.  Enterprise databases can be memory pigs.  It
isn't feasible to run hundreds or thousands of copies on each machine.  

-- Dave

