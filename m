Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269406AbUINMs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269406AbUINMs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUINMSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:18:42 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:2260 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S269327AbUINMOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:14:46 -0400
Subject: Re: [RFC][PATCH 2/2] ip multipath, bk head (EXPERIMENTAL)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "David S. Miller" <davem@davemloft.net>
Cc: lkml@einar-lueck.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20040913224232.4b979c7d.davem@davemloft.net>
References: <41457848.6040808@de.ibm.com>
	 <1095129624.1060.45.camel@jzny.localdomain>
	 <20040913224232.4b979c7d.davem@davemloft.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1095164075.1060.100.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Sep 2004 08:14:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 01:42, David S. Miller wrote:
> On 13 Sep 2004 22:40:24 -0400
> jamal <hadi@cyberus.ca> wrote:
> 
> > As long as whatever arrangement ensures that no packet reordering
> > happens, should be sane. Yes, current scheme is broken in some ways (but
> > guarantees packet ordering within a flow).
> 
> I think his changes ensure this as well, at least for local system
> sockets.  You'll only get a new hop each time a route lookup is
> performed, which is only done once per socket unless the path
> becomes "sick" and TCP decides to try and do a relookup of the
> destination.

I was worried more about forwarding path.

> I'm kind of ambivalent about these changes.  I definitely like the
> first patch which cleans up those huge functions in route.c :-)

Oh, yeah that looked good - thats why i didnt comment. Your call.

> But there are things I like about the current behavior, although I
> understand why people want things to work the way Einar is changing
> it to.

I think its a little broken but not unlike say CISCOs multipath when
they have caching. 
The general trend though is that now multipathing is getting more
interesting and the policy criteria is no longer loadbalancing alone.
An example interesting paper and newer devices showing up: 

"Experiences in Building A Multihoming Load Balancing System" by
Fanglu Guo, Jiawu Chen , Wei Li, Tzi-Cker Chiueh (State University of
New York at Stony Brook
url: http://www.ieee-infocom.org/2004/technicalprogram.htm

The idea proposed there is extensible to many other policy selections
(very easily implementable via tc actions).

cheers,
jamal


