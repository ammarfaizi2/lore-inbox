Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423319AbWF1Ngn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423319AbWF1Ngn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932802AbWF1Ngn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:36:43 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:43243 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932795AbWF1Ngl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:36:41 -0400
Date: Wed, 28 Jun 2006 15:36:40 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060628133640.GB5088@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Dave Hansen <haveblue@us.ibm.com>,
	Ben Greear <greearb@candelatech.com>,
	Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, clg@fr.ibm.com,
	Andrew Morton <akpm@osdl.org>, dev@sw.ru, devel@openvz.org,
	sam@vilain.net, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060627133849.E13959@castle.nmd.msu.ru> <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com> <20060627160241.GB28984@MAIL.13thfloor.at> <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 09:38:14PM -0600, Eric W. Biederman wrote:
> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:
> 
> > Hello!
> >
> >> It may look weird, but do application really *need* to see eth0 rather
> >> than eth858354?
> >
> > Applications do not care, humans do. :-)
> >
> > What's about applications they just need to see exactly the same
> > device after migration. Not only name, but f.e. also its ifindex.
> > If you do not create a separate namespace for netdevices, you will
> > inevitably end up with some strange hack sort of VPIDs to translate
> > (or to partition) ifindices or to tell that "ping -I eth858354 xxx"
> > is too coimplicated application to survive migration.
> 
> 
> Actually there are applications with peculiar licensing practices that
> do look at devices like eth0 to verify you have the appropriate mac, and
> do really weird things if you don't have an eth0.
> 
> Plus there are other cases where it can be simpler to hard code things
> if it is allowable. (The human factor)  Otherwise your configuration
> must be done through hotplug scripts.
> 
> But yes there are misguided applications that care.

last time I pointed to such 'misguided' apps which 
made assumptions that are not necessarily true
inside a virtual environment (e.g. pstree, initpid)
the general? position was that those apps should
be fixed instead adding a 'workaround'

note: personally I'm absolutely not against virtualizing
the device names so that each guest can have a separate
name space for devices, but there should be a way to
'see' _and_ 'identify' the interfaces from outside
(i.e. host or spectator context)

best,
Herbert

> Eric
