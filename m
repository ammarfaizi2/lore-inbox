Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUHKP3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUHKP3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268083AbUHKP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:29:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:1716 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268082AbUHKP3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:29:36 -0400
Message-ID: <411A3B1F.3010800@suse.de>
Date: Wed, 11 Aug 2004 17:28:31 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
       seife@suse.de, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
References: <20040811085326.GA11765@elf.ucw.cz>	 <1092215024.2816.8.camel@laptop.fenrus.com>	 <20040811090622.GC674@elf.ucw.cz> <1092235779.5028.93.camel@dhcppc4>
In-Reply-To: <1092235779.5028.93.camel@dhcppc4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Wed, 2004-08-11 at 05:06, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>>.adds possibility to react to
>>>>critical overtemp: it tries to call /sbin/overtemp, and only if
>>
>>that fails calls /sbin/poweroff.
> 
> 
> Does /sbin/overtemp exist anyplace, or is this a proposal
> to create it?  What might it do?

save some user info, suspend, standby, extreme throttling?
It should be somehow configurable in userspace.

For my opinion it would be nicest if kernel just throws a thermal event 
to /proc/acpi/event (it already does this, but immediately shuts down) 
and acpid or others should decide whether shutdown/suspend/standby or 
whatever should be done next.
I have a machine with a broken DSDT which sets the critical tp to 200°C, 
there always must be some HW shutdown..., or do you think this is too risky?

Some other related thing:
Why are no thermal events thrown if active/passive trip points are 
reached/sub-ceeded?
The only way at the moment to figure out in userspace whether the system 
is actively cooled or even slowed down by throttling (passive) is by 
polling /proc/acpi/thermal/*/state. Isn't the purpose of thermal events 
exactly for this?
I think about a possiblity to notify user if machine is slowed down.


       Thomas
