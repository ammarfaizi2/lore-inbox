Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUHKVIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUHKVIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUHKVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:08:48 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:65194 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268222AbUHKVIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:08:46 -0400
Date: Wed, 11 Aug 2004 23:08:37 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Pavel Machek <pavel@suse.cz>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811210837.GA26037@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <411A3B1F.3010800@suse.de>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Renninger <trenn@suse.de> ha scritto:
> Len Brown wrote:
>> On Wed, 2004-08-11 at 05:06, Pavel Machek wrote:
>> 
>>>Hi!
>>>
>>>
>>>>>.adds possibility to react to
>>>>>critical overtemp: it tries to call /sbin/overtemp, and only if
>>>
>>>that fails calls /sbin/poweroff.
>> 
>> 
>> Does /sbin/overtemp exist anyplace, or is this a proposal
>> to create it?  What might it do?
> 
> save some user info, suspend, standby, extreme throttling?
> It should be somehow configurable in userspace.
> 
> For my opinion it would be nicest if kernel just throws a thermal event 
> to /proc/acpi/event (it already does this, but immediately shuts down) 
> and acpid or others should decide whether shutdown/suspend/standby or 
> whatever should be done next.

I think that /sbin/overtemp is better, acpid may not know what do.
Suppose that the kernel delivers the event to acpid (or hotplug) but
they aren't configured to handle that, your CPU will melt...

> I have a machine with a broken DSDT which sets the critical tp to 200°C, 
> there always must be some HW shutdown..., or do you think this is too risky?

It's more secure to call a program that can handle that for sure (ie.
/sbin/overtemp) and shutdown if it doesn't exist.

Luca
-- 
Home: http://kronoz.cjb.net
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook
