Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWF1RBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWF1RBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWF1Q7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:36 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:62991 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1751474AbWF1Q6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:58:50 -0400
Message-ID: <20060628205848.A1217@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 20:58:48 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: hadi@cyberus.ca
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Dave Hansen <haveblue@us.ibm.com>, Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, devel@openvz.org,
       sam@vilain.net, viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <20060628181900.A31885@castle.nmd.msu.ru> <1151511455.5160.48.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1151511455.5160.48.camel@jzny2>; from "jamal" on Wed, Jun 28, 2006 at 12:17:35PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 12:17:35PM -0400, jamal wrote:
> 
> On Wed, 2006-28-06 at 18:19 +0400, Andrey Savochkin wrote:
> > 
> > Seeing guestXX-eth0 interfaces by standard tools has certain attractive
> > sides.  But it creates a lot of undesired side effects.
> > 
> 
> I apologize because i butted into the discussion without perhaps reading
> the full thread. 

Your comments are quite welcome

> 
> > For example, ntpd queries all network devices by the same ioctls as ifconfig,
> > and creates separate sockets bound to IP addresses of each device, which is
> > certainly not desired with namespaces.
> > 
> 
> Ok, so the problem is that ntp in this case runs on the host side as

yes

> opposed to the guest? This would explain why Eric is reacting vehemently
> to the suggestion.

:)

And I actually do not want to distinguish host and guest sides much.
They are namespaces in the first place.
Parent namespace may have some capabilities to manipulate its child
namespaces, like donate its own device to one of its children.

But it comes secondary to having namespace isolation borders.
In particular, because most cases of cross-namespace interaction lead to
failures of formal security models and inability to migrate
namespaces between computers.

> 
> > Or more subtle question: do you want hotplug events to be generated when
> > guest0-eth0 interface comes up in the root namespace, and standard scripts
> > to try to set some IP address on this interface?..
> > 
> 
> yes, thats what i was thinking. Even go further and actually create
> guestxx-eth0 on the host (which results in creating eth0 on the guest)
> and other things.

This actually goes in the opposite direction to what I keep in mind.
I want to offload as much as possible of network administration work to
guests.  Delegation of management is one of the motivating factors
behind covering not only sockets but devices, routes, and so on by the
namespace patches.

> 
> > In my opinion, the downside of this scheme overweights possible advantages,
> > and I'm personally quite happy with running commands with switched namespace,
> > like
> > vzctl exec guest0 ip addr list
> > vzctl exec guest0 ip link set eth0 up
> > and so on.
> 
> Ok, above may be good enough and doesnt require any state it seems on
> the host side. 
> I got motivated when the word "migration" was mentioned. I understood it
> to be meaning that a guest may become inoperative for some reason and
> that its info will be transfered to another guest which may be local or
> even remote. In such a case, clearly one would need a protocol and the
> state of all guests sitting at the host. Maybe i am over-reaching. 

Migration will work inside the kernel, so it has full access
to whatever state information it needs.

Best regards

Andrey
