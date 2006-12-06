Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760230AbWLFGJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760230AbWLFGJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760232AbWLFGJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:09:27 -0500
Received: from dvhart.com ([64.146.134.43]:46633 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760230AbWLFGJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:09:27 -0500
Message-ID: <45765DBB.7010703@mbligh.org>
Date: Tue, 05 Dec 2006 22:05:47 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tony@bakeyournoodle.com
Subject: Re: Device naming randomness (udev?)
References: <45735230.7030504@mbligh.org> <20061203231206.GA4413@atjola.homenet> <20061206054941.GD13118@suse.de>
In-Reply-To: <20061206054941.GD13118@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Dec 04, 2006 at 12:12:06AM +0100, Bj?rn Steinbrink wrote:
>> On 2006.12.03 14:39:44 -0800, Martin J. Bligh wrote:
>>> This PC has 1 ethernet interface, an e1000. Ubuntu Dapper.
>>>
>>> On 2.6.14, my e1000 interface appears as eth0.
>>> On 2.6.15 to 2.6.18, my e1000 interface appears as eth1.
>>>
>>> In both cases, there are no other ethX interfaces listed in
>>> "ifconfig -a". There are no modules involved, just a static
>>> kernel build.
>>>
>>> Is this a bug in udev, or the kernel? I'm presuming udev,
>>> but seems odd it changes over a kernel release boundary.
>>> Any ideas on how I get rid of it? Makes automatic switching
>>> between kernel versions a royal pain in the ass.
>> Just a wild guess here... Debian's (and I guess Ubuntu's) udev rules
>> contain a generator for persistent interface name rules. Maybe these
>> start working with 2.6.15 and thus the switch (ie. the kernel would call
>> it eth0, but udev renames it to eth1).
>> The generated rules are written to
>> /etc/udev/rules.d/z25_persistent-net.rules on Debian, not sure if its
>> the same for Ubuntu. Editing/removing the rules should fix your problem.
> 
> Yes, I'd place odds on this one.

Huh. Somehow there was this entry in /etc/iftab:

eth0 mac 00:0d:61:44:90:12 arp 1

But that's not my mac address. Damned if I know how that got there, but
if the persistent rules only work on later kernels, that'd explain it.
And indeed ... removing that entry makes it work more normally.

Thanks for the pointers - most helpful.

M.


