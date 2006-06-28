Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932820AbWF1Oww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932820AbWF1Oww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932818AbWF1Oww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:52:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43982 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932809AbWF1Owu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:52:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Ben Greear <greearb@candelatech.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060626192751.A989@castle.nmd.msu.ru>
	<44A00215.2040608@fr.ibm.com>
	<20060627131136.B13959@castle.nmd.msu.ru>
	<44A0FBAC.7020107@fr.ibm.com>
	<20060627133849.E13959@castle.nmd.msu.ru>
	<44A1149E.6060802@fr.ibm.com>
	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	<20060627160241.GB28984@MAIL.13thfloor.at>
	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	<44A1689B.7060809@candelatech.com>
	<20060627225213.GB2612@MAIL.13thfloor.at>
	<1151449973.24103.51.camel@localhost.localdomain>
Date: Wed, 28 Jun 2006 08:51:33 -0600
In-Reply-To: <1151449973.24103.51.camel@localhost.localdomain> (Dave Hansen's
	message of "Tue, 27 Jun 2006 16:12:52 -0700")
Message-ID: <m1mzbxgwp6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2006-06-28 at 00:52 +0200, Herbert Poetzl wrote:
>> seriously, what I think Eric meant was that it
>> might be nice (especially for migration purposes)
>> to keep the device namespace completely virtualized
>> and not just isolated ...
>
> It might be nice, but it is probably unneeded for an initial
> implementation.  In practice, a cluster doing
> checkpoint/restart/migration will already have a system in place for
> assigning unique IPs or other identifiers to each container.  It could
> just as easily make sure to assign unique network device names to
> containers.
>
> The issues really only come into play when you have an unstructured set
> of machines and you want to migrate between them without having prepared
> them with any kind of unique net device names beforehand.
>
> It may look weird, but do application really *need* to see eth0 rather
> than eth858354?

Actually there is a very practical reason we don't need to preserve device
names across a migration event between machines, is the only sane thing
to do is to generate a hotplug event that says you have removed the old
interface and added a new interface.

My expectation is that during migration you will wind up with add and
remove events for all of your hardware devices.  But most applications
because they do not access hardware devices directly will not care.

I haven't looked closely but I suspect this is one area where a container
style approach will be noticeably different from a Xen or Vmware style
approach.

Eric
