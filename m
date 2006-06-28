Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423359AbWF1OXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423359AbWF1OXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423358AbWF1OXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:23:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33425 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1423356AbWF1OXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:23:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060627133849.E13959@castle.nmd.msu.ru>
	<44A1149E.6060802@fr.ibm.com>
	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	<20060628133640.GB5088@MAIL.13thfloor.at>
Date: Wed, 28 Jun 2006 08:21:38 -0600
In-Reply-To: <20060628133640.GB5088@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Wed, 28 Jun 2006 15:36:40 +0200")
Message-ID: <m1zmfxgy31.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> last time I pointed to such 'misguided' apps which 
> made assumptions that are not necessarily true
> inside a virtual environment (e.g. pstree, initpid)
> the general? position was that those apps should
> be fixed instead adding a 'workaround'

I agree that if it was solely misguided apps.  There would be
no justification.

One of the standard applications interfaces we support is renaming
a network interface.  So supporting those misguided apps is a actually
a side effect of supporting one the standard operations on a network interface.

Another way of looking at it is that the names of networking devices like the
names of devices in /dev are a user space policy (today).  In the
configuration of the networking stack historically we had those identifiers
hard coded.  It isn't until just recently that user space has been able to
cope with dynamically added/removed network devices.

As for initpid and friends.  In the context where you are simply isolating
pids and not doing a full pid namespaces it was felt that changing the few
user space applications that care was easier and probably worth doing anyway.

> note: personally I'm absolutely not against virtualizing
> the device names so that each guest can have a separate
> name space for devices, but there should be a way to
> 'see' _and_ 'identify' the interfaces from outside
> (i.e. host or spectator context)

Yep.  Basically that interface comes when we fix the sysfs support,
to support per namespace reporting.

Eric
