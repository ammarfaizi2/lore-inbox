Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWBCKxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWBCKxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWBCKxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:53:55 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:45717 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932197AbWBCKxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=CgEBuc+/hCZgSfkClPecD0e/78F5q9JRuqKY6ueYFC1oHBO9+xxK+R73WRfR2cVHj3p4/3NmInuGOEM4VRr9OWw8/P7Ncaj7/1cGhmuxV5t47d3U57qxgwTWtgCXM0AL8Uwbo6zIpHZ/IyFun3eszutaAuy7/c1lft7xUYzTSCY=;
Date: Fri, 3 Feb 2006 13:52:02 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
Message-ID: <20060203105202.GA21819@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138899951.29030.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This is an interesting approach.  Could you elaborate a bit on on why
> you need the two different approaches?  What conditions cause the switch
> to the sparse approach?
> 
> Also, if you could separate those two approaches out into two different
> patches, it would be much easier to get a grasp about what's going on.
> One of them is just an optimization, right?

Exactly. They are not two different "approaches", it is just a simple
optimization.

In our approach each process has pair of pids: one is global unique identifier
(read, it is real pid from viewpoint of kernel), another is virtual pid.
We just do not want to lose cycles allocating both of them all the time,
so we derive virtual pid from global one, it is automatically "virtually"
unique.

Switch to "sparse" mapping happens _only_ after migration, when a process
must be recreated with the same virtual pid, but with new global pid.


> Did you happen to catch Linus's mail about his preferred approach?  
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113874154731279&w=2

Of course. Logically, it would be final solution.

VPID approach is pragmatic: it does not modify existing logic, rather
it relies on it. So, it just allows to use virtual pids in a simple
and efficient way, which is enough for all known tasks.

Alexey
