Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTIYRhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTIYRgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:36:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4760 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261429AbTIYReq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:34:46 -0400
Message-Id: <200309251733.h8PHXWpV013559@death.ibm.com>
To: shmulik.hen@intel.com
cc: "Chad N. Tindel" <chad@tindel.net>, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
Subject: Re: [Bonding-announce] [PATCH SET][bonding] cleanup 
In-Reply-To: Message from Shmulik Hen <shmulik.hen@intel.com> 
   of "Thu, 25 Sep 2003 20:11:53 +0300." <200309252011.53960.shmulik.hen@intel.com> 
Date: Thu, 25 Sep 2003 10:33:31 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	[removed bonding-announce from cc:]

>On Thursday 25 September 2003 07:47 pm, Chad N. Tindel wrote:
>> > patch 4 - remove dead code, old compatibility stuff and redundant
>> >           checks.
>>
>> I'm a bit concerned about doing some of this stuff in the 2.4
>> series.  That compatibility stuff is there for a reason, and was
>> set to be removed in 2.6.  Perhaps we shouldn't be doing stuff this
>> drastic until 2.6 because of the risk of breaking users.
>
>That's the word I got from Jay in response to the " [Kernel-janitors] 
>old ioctl definitions in 2.5" thread.
>
>>Jay Vosburgh <fubar@us.ibm.com> wrote:
>>	I was going to add it on to the end of the clean up set, but
>> if you want to do it, go ahead.  Nobody seems to have objected to
>> removing the _OLD stuff, which I view as a good thing.

	My thinking here is that any ifenslave old enough (two years
or more) to still be using the OLD ioctl values is unlikely to work
with the current kernel driver, and if somebody did try it, it's
better to have the call fail outright than perform weird and
mysterious rituals in kernel memory.  I have trouble envisioning an
scenario where a user would be using the latest 2.4.23 kernel, but an
ifenslave from, what, 2.2.15? 2.4.5? or so.

	Separately, recent ifenslaves have compatibility code within
them to cover the great "ifenslave calling sequence change" from April
or so.  As much as I love the sleek new slimmed down ifenslave, I'm
not absolutely sure we can nuke that compatibility stuff within
ifenslave.  I really, really wanna, but I'm not sure if it will cause
problems for end users.  This is the upgrade scenario that prompted
the creation of the whole "ABI version" and compat stuff in the first
place; if we don't have to worry about that, then the simpler
ifenslave can be used, and I think the ethtool ABI version hack can go
away (since we wouldn't need an ABI version if there's only one).

	Comments?

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
