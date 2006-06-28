Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423352AbWF1OTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423352AbWF1OTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423354AbWF1OTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:19:05 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:6670 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1423352AbWF1OTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:19:02 -0400
Message-ID: <20060628181900.A31885@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 18:19:00 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: hadi@cyberus.ca
Cc: Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, sam@vilain.net, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com, serue@us.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com> <20060627160241.GB28984@MAIL.13thfloor.at> <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1151502803.5203.101.camel@jzny2>; from "jamal" on Wed, Jun 28, 2006 at 09:53:23AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamal,

On Wed, Jun 28, 2006 at 09:53:23AM -0400, jamal wrote:
> 
> On Wed, 2006-28-06 at 15:36 +0200, Herbert Poetzl wrote:
> 
> > note: personally I'm absolutely not against virtualizing
> > the device names so that each guest can have a separate
> > name space for devices, but there should be a way to
> > 'see' _and_ 'identify' the interfaces from outside
> > (i.e. host or spectator context)
> > 
> 
> Makes sense for the host side to have naming convention tied
> to the guest. Example as a prefix: guest0-eth0. Would it not
> be interesting to have the host also manage these interfaces
> via standard tools like ip or ifconfig etc? i.e if i admin up
> guest0-eth0, then the user in guest0 will see its eth0 going
> up.

Seeing guestXX-eth0 interfaces by standard tools has certain attractive
sides.  But it creates a lot of undesired side effects.

For example, ntpd queries all network devices by the same ioctls as ifconfig,
and creates separate sockets bound to IP addresses of each device, which is
certainly not desired with namespaces.

Or more subtle question: do you want hotplug events to be generated when
guest0-eth0 interface comes up in the root namespace, and standard scripts
to try to set some IP address on this interface?..

In my opinion, the downside of this scheme overweights possible advantages,
and I'm personally quite happy with running commands with switched namespace,
like
vzctl exec guest0 ip addr list
vzctl exec guest0 ip link set eth0 up
and so on.

Best regards

Andrey
