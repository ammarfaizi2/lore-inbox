Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSGBXdC>; Tue, 2 Jul 2002 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSGBXdB>; Tue, 2 Jul 2002 19:33:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24057 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314101AbSGBXdA>;
	Tue, 2 Jul 2002 19:33:00 -0400
Date: Tue, 2 Jul 2002 19:35:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal 
In-Reply-To: <32193.1025585595@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0207021922520.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jul 2002, Keith Owens wrote:

> For netfilter, the use count reflects the number of packets being
> processed.  Complex and potentially high overhead.

<blink>

_Why_???

If some rule in your chains needs a module foo, you probably want foo
to stay around until that rule is removed.  Even if there's no traffic
whatsoever.

So what's the problem with making use count equal to number of rules
referencing the module?  You need exclusion between chain changes and
chain traversing anyway...
 
> All of this requires that the module information be passed in multiple
> structures and assumes that all code is careful about reference
> counting the code it is about to execute.  There has to be a better
> way!

You know, I'd rather trust core code to do something right than expect
all drivers to follow any non-trivial rules (and "you should not block
in <areas>" _is_ non-trivial enough).

No comments on the network devices - I'll need to read through the code
to answer that one...

