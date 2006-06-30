Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933016AbWF3SXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016AbWF3SXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWF3SXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:23:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27352 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933002AbWF3SXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:23:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: hadi@cyberus.ca
Cc: Andrey Savochkin <saw@swsoft.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Dave Hansen <haveblue@us.ibm.com>, Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, devel@openvz.org,
       viro@ftp.linux.org.uk, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net>
	<1151626552.8922.70.camel@jzny2>
	<20060630114551.A20191@castle.nmd.msu.ru>
	<1151675452.5270.10.camel@jzny2>
Date: Fri, 30 Jun 2006 12:22:24 -0600
In-Reply-To: <1151675452.5270.10.camel@jzny2> (hadi@cyberus.ca's message of
	"Fri, 30 Jun 2006 09:50:52 -0400")
Message-ID: <m13bdmbj1b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

>> > > Then the pragmatic question becomes how to correlate what you see from
>> > > `ip addr list' to guests.
>> > 
>> > on the host ip addr and the one seen on the guest side are the same.
>> > Except one is seen (on the host) on guest0-eth0 and another is seen 
>> > on eth0 (on guest).
>> 
>> Then what to do if the host system has 10.0.0.1 as a private address on eth3,
>> and then interfaces guest1-tun0 and guest2-tun0 both get address 10.0.0.1
>> when each guest has added 10.0.0.1 to their tun0 device?
>
> Yes, that would be a conflict that needs to be resolved. If you look at
> ip addresses as also belonging to namespaces, then it should work, no?
> i am assuming a tag at the ifa table level.

Yes.  The conception is that everything belongs to the namespace,
so it looks like you have multiple instances of the network stack.

Which means through existing interfaces it would be a real problem
if a network device showed up in more than one network stack as
that would confuse things.

Basically the reading and configuration through existing interfaces
is expected to be in the namespace as well which is where the difficulty
shows up.

When you get serious about splitting up roots powers this becomes a real
advantage.  Because you might want to have one person responsible for
what would normally be eth0 and another person responsible for eth1.

Anyway Jamal can you see the problem the aliases present to the implementation?

Eric
