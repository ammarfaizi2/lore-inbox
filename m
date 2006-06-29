Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWF2VHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWF2VHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWF2VHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:07:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:63664 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932551AbWF2VHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:07:19 -0400
Message-ID: <44A44124.5010602@vilain.net>
Date: Fri, 30 Jun 2006 09:07:48 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
MIME-Version: 1.0
To: hadi@cyberus.ca
Cc: Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com, serue@us.ibm.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060627133849.E13959@castle.nmd.msu.ru>	 <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>	 <20060627160241.GB28984@MAIL.13thfloor.at>	 <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>	 <44A1689B.7060809@candelatech.com>	 <20060627225213.GB2612@MAIL.13thfloor.at>	 <1151449973.24103.51.camel@localhost.localdomain>	 <20060627234210.GA1598@ms2.inr.ac.ru>	 <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>	 <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2>
In-Reply-To: <1151502803.5203.101.camel@jzny2>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
>> note: personally I'm absolutely not against virtualizing
>> the device names so that each guest can have a separate
>> name space for devices, but there should be a way to
>> 'see' _and_ 'identify' the interfaces from outside
>> (i.e. host or spectator context)
>>
>>     
>
> Makes sense for the host side to have naming convention tied
> to the guest. Example as a prefix: guest0-eth0. Would it not
> be interesting to have the host also manage these interfaces
> via standard tools like ip or ifconfig etc? i.e if i admin up
> guest0-eth0, then the user in guest0 will see its eth0 going
> up.

That particular convention only works if you have network namespaces and
UTS namespaces tightly bound.  We plan to have them separate - so for
that to work, each network namespace could have an arbitrary "prefix"
that determines what the interface name will look like from the outside
when combined.  We'd have to be careful about length limits.

And guest0-eth0 doesn't necessarily make sense; it's not really an
ethernet interface, more like a tun or something.

So, an equally good convention might be to use sequential prefixes on
the host, like "tun", "dummy", or a new prefix - then a property of that
is what the name of the interface is perceived to be to those who are in
the corresponding network namespace.

Then the pragmatic question becomes how to correlate what you see from
`ip addr list' to guests.

Sam.
