Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWF3AQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWF3AQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWF3AQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:16:05 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:4786 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1750789AbWF3AQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:16:03 -0400
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Sam Vilain <sam@vilain.net>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com, serue@us.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <44A44124.5010602@vilain.net>
References: <20060627133849.E13959@castle.nmd.msu.ru>
	 <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	 <20060627160241.GB28984@MAIL.13thfloor.at>
	 <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	 <44A1689B.7060809@candelatech.com>
	 <20060627225213.GB2612@MAIL.13thfloor.at>
	 <1151449973.24103.51.camel@localhost.localdomain>
	 <20060627234210.GA1598@ms2.inr.ac.ru>
	 <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	 <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2>
	 <44A44124.5010602@vilain.net>
Content-Type: text/plain
Organization: unknown
Date: Thu, 29 Jun 2006 20:15:52 -0400
Message-Id: <1151626552.8922.70.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-30-06 at 09:07 +1200, Sam Vilain wrote:
> jamal wrote:

> > Makes sense for the host side to have naming convention tied
> > to the guest. Example as a prefix: guest0-eth0. Would it not
> > be interesting to have the host also manage these interfaces
> > via standard tools like ip or ifconfig etc? i.e if i admin up
> > guest0-eth0, then the user in guest0 will see its eth0 going
> > up.
> 
> That particular convention only works if you have network namespaces and
> UTS namespaces tightly bound. 

that would be one approach. Another less sophisticated approach is to
have no binding whatsoever, rather some translation table to map two
unrelated devices. 

>  We plan to have them separate - so for
> that to work, each network namespace could have an arbitrary "prefix"
> that determines what the interface name will look like from the outside
> when combined.  We'd have to be careful about length limits.
> 
> And guest0-eth0 doesn't necessarily make sense; it's not really an
> ethernet interface, more like a tun or something.
> 

it wouldnt quiet fit as a tun device. More like a mirror side of the 
guest eth0 created on the host side 
i.e a sort of passthrough device with one side visible on the host (send
from guest0-eth0 is received on eth0 in the guest and vice-versa).

Note this is radically different from what i have heard Andrey and co
talk about and i dont wanna disturb any shit because there seems to be
some agreement. But if you address me i respond because it is very
interesting a topic;->

> So, an equally good convention might be to use sequential prefixes on
> the host, like "tun", "dummy", or a new prefix - then a property of that
> is what the name of the interface is perceived to be to those who are in
> the corresponding network namespace.
>
> Then the pragmatic question becomes how to correlate what you see from
> `ip addr list' to guests.

on the host ip addr and the one seen on the guest side are the same.
Except one is seen (on the host) on guest0-eth0 and another is seen 
on eth0 (on guest).
Anyways, ignore what i am saying if it is disrupting the discussion.

cheers,
jamal 




