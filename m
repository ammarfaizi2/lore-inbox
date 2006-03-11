Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWCKNbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWCKNbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWCKNbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 08:31:12 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:35004 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1750818AbWCKNbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 08:31:10 -0500
Subject: Re: [UPDATED PATCH] Re: [Lse-tech] Re: [Patch 7/7] Generic netlink
	interface (delay	accounting)
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
In-Reply-To: <20060310163927.GA6537@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141029060.5785.77.camel@elinux04.optonline.net>
	 <1141045194.5363.12.camel@localhost.localdomain>
	 <4403608E.1050304@watson.ibm.com>
	 <1141652556.5185.64.camel@localhost.localdomain>
	 <440C6AAA.9030301@watson.ibm.com>
	 <1141742282.5171.55.camel@localhost.localdomain>
	 <440F52FF.30908@watson.ibm.com> <20060309143759.GA4653@in.ibm.com>
	 <1142002433.5298.42.camel@jzny2>  <20060310163927.GA6537@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Sat, 11 Mar 2006 08:30:49 -0500
Message-Id: <1142083849.5184.69.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-03 at 22:09 +0530, Balbir Singh wrote:
> On Fri, Mar 10, 2006 at 09:53:53AM -0500, jamal wrote: 

> > On kernel->user (in the case of response to #a or async notifiation as
> > in #b) you really dont need to specify the TG/PID since they appear in
> > the STATS etc.
> 
> I see your point now. I am looking at other users of netlink like
> rtnetlink and I see the classical usage.
> 
> We can implement TLV's in our code, but for the most part the data we exchange
> between the user <-> kernel has all the TLV's listed in the enum above.
>
> The major differnece is the type (pid/tgid). Hence we created a structure
> (taskstats) instead of using TLV's.

Something to remember:

1) TLVs are essentially giving you the flexibility to send optionally
appearing elements. It is up to the receiver (in the kernel or user
space) to check for the presence of mandatory elements or execute things
depending on the presence of certain TLVs. Example in your case:
if the tgid TLV appears then the user is requesting for that TLV
if the pid appears then they are requesting for that
if both appear then it is the && of the two.
You should always ignore TLVs you dont understand - to allow for forward
compatibility.

2)  The "T" part is essentially also encoding (semantically) what size
the value is; the "L" part is useful for validation. So the receiver
will always know what the size of the TLV is by definition and uses the
L to make sure it is the right size. Reject what is of the wrong size.

cheers,
jamal

