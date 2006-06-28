Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWF1RTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWF1RTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWF1RTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:19:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45472 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751489AbWF1RTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:19:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: hadi@cyberus.ca
Cc: Andrey Savochkin <saw@swsoft.com>, Dave Hansen <haveblue@us.ibm.com>,
       Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
	<1151502803.5203.101.camel@jzny2>
	<20060628181900.A31885@castle.nmd.msu.ru>
	<1151511455.5160.48.camel@jzny2>
Date: Wed, 28 Jun 2006 11:17:08 -0600
In-Reply-To: <1151511455.5160.48.camel@jzny2> (hadi@cyberus.ca's message of
	"Wed, 28 Jun 2006 12:17:35 -0400")
Message-ID: <m1d5ctfbe3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> writes:

> Andrey,
>
> On Wed, 2006-28-06 at 18:19 +0400, Andrey Savochkin wrote:
>> Hi Jamal,
>> 
>> On Wed, Jun 28, 2006 at 09:53:23AM -0400, jamal wrote:
>> > 
>
>> 
>> Seeing guestXX-eth0 interfaces by standard tools has certain attractive
>> sides.  But it creates a lot of undesired side effects.
>> 
>
> I apologize because i butted into the discussion without perhaps reading
> the full thread. 

This thread is serving as an educational vehicle, and the more people
from outside of our little biased group that begin to understand what
we are about the better.

>> For example, ntpd queries all network devices by the same ioctls as ifconfig,
>> and creates separate sockets bound to IP addresses of each device, which is
>> certainly not desired with namespaces.
>> 
>
> Ok, so the problem is that ntp in this case runs on the host side as
> opposed to the guest? This would explain why Eric is reacting vehemently
> to the suggestion.

Yes, that would be one problem case.

>> Or more subtle question: do you want hotplug events to be generated when
>> guest0-eth0 interface comes up in the root namespace, and standard scripts
>> to try to set some IP address on this interface?..
>> 
>
> yes, thats what i was thinking. Even go further and actually create
> guestxx-eth0 on the host (which results in creating eth0 on the guest)
> and other things.
>
>> In my opinion, the downside of this scheme overweights possible advantages,
>> and I'm personally quite happy with running commands with switched namespace,
>> like
>> vzctl exec guest0 ip addr list
>> vzctl exec guest0 ip link set eth0 up
>> and so on.
>
> Ok, above may be good enough and doesnt require any state it seems on
> the host side. 
> I got motivated when the word "migration" was mentioned. I understood it
> to be meaning that a guest may become inoperative for some reason and
> that its info will be transfered to another guest which may be local or
> even remote. In such a case, clearly one would need a protocol and the
> state of all guests sitting at the host. Maybe i am over-reaching. 

Not really.  Network namespaces while useful in their own right lay
the foundation for some more interesting applications.  Application
migration between machines in particular.

The biggest fundamental problem in migration is after checkpointing your
application you can not acquire the resources you need on the new machine 
because of name conflicts.

So for those of us concerned with migration a question we ask is can
we successfully import resource names that another machine has assigned without
consulting us.

The context for all of this goes to other discussion that we have been having
since January.  Breaking all of this into small pieces that can be merged and
tested a little at a time is a challenge.

Eric
