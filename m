Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVAQO14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVAQO14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVAQO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:27:56 -0500
Received: from alog0089.analogic.com ([208.224.220.104]:25472 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262804AbVAQO1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:27:50 -0500
Date: Mon, 17 Jan 2005 09:27:10 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Peter Kruse <pk@q-leap.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Random packets loss under x86_64 - routing?
In-Reply-To: <41EBC449.3090503@q-leap.com>
Message-ID: <Pine.LNX.4.61.0501170913240.22065@chaos.analogic.com>
References: <41E7E6D7.10303@q-leap.com> <Pine.LNX.4.61.0501141129260.5840@chaos.analogic.com>
 <41EBC449.3090503@q-leap.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Peter Kruse wrote:

> Hello,
>
> thanks for your reply
>
> linux-os wrote:
> >
>> When they 'disappear', use `arp -d hostname` to delete the
>> entry from the ARP tables. Then see if you can ping it.
>> It is possible that the destination machine got re-routed
>> and the new router's HW address wasn't updated in the
>> ARP tables. If this is the case, I don't know hot to 'fix'
>> it, but it's a new data-point. When you have dynamic routing,
>> there needs to be some way to update the ARP tables even though
>> they eventually expire.
>
> There is no router between sender and destination host,
> they are on the same subnet and connected on the same switch.
>

I suggest that you may __think__ that there is no router.... But
for instance, I can't talk to my own printer here because
of some configuration changes made by the "Net Naz^M^M^M
Wizards" here. Same network, same wire. It gets "redirected".
Basically, everything on this wire is proxy-arped by the
default-route machine. There are duplicate packets on the
wire and redirections everywhere.

You can look at your ARP table with:

`cat /proc/net/arp`

>> The fact that `ping -r` works seems to show that the ARP table
>> has stale entries in it.
>>

The `ping -r` working shows that there were is either a bad
ARP table entry or too small a netmask so the device isn't
really on your network.

>
> Even directly after reboot when the arp table is empty?
>
> 	Peter
>

Just check it out. You'd be surprised what you may find.
Look at the ARP-table entry. Try to ping something that
doesn't respond. Look at the table again. That will tell
you what's happening. It's likely that there is an ARP
table entry from some 'router' that has been set to
proxy-ARP whatever it sees on the wire.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
