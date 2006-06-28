Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWF1DkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWF1DkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWF1DkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:40:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15249 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751070AbWF1DkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:40:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>, Herbert Poetzl <herbert@13thfloor.at>,
       Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060627131136.B13959@castle.nmd.msu.ru>
	<44A0FBAC.7020107@fr.ibm.com>
	<20060627133849.E13959@castle.nmd.msu.ru>
	<44A1149E.6060802@fr.ibm.com>
	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
	<20060627234210.GA1598@ms2.inr.ac.ru>
Date: Tue, 27 Jun 2006 21:38:14 -0600
In-Reply-To: <20060627234210.GA1598@ms2.inr.ac.ru> (Alexey Kuznetsov's message
	of "Wed, 28 Jun 2006 03:42:10 +0400")
Message-ID: <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:

> Hello!
>
>> It may look weird, but do application really *need* to see eth0 rather
>> than eth858354?
>
> Applications do not care, humans do. :-)
>
> What's about applications they just need to see exactly the same device
> after migration. Not only name, but f.e. also its ifindex. If you do not
> create a separate namespace for netdevices, you will inevitably end up
> with some strange hack sort of VPIDs to translate (or to partition) ifindices
> or to tell that "ping -I eth858354 xxx" is too coimplicated application
> to survive migration.


Actually there are applications with peculiar licensing practices that
do look at devices like eth0 to verify you have the appropriate mac, and
do really weird things if you don't have an eth0.

Plus there are other cases where it can be simpler to hard code things
if it is allowable. (The human factor)  Otherwise your configuration
must be done through hotplug scripts.

But yes there are misguided applications that care.

Eric
