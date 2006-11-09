Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424149AbWKIROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424149AbWKIROH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424133AbWKIROG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:14:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:136 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424149AbWKIROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:14:02 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Olivier Nicolas <olivn@trollprod.org>,
       Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64  irq 22: nobody cared
References: <4551D12D.4010304@trollprod.org> <20061109064956.GG4729@stusta.de>
	<20061109084937.52af8768@freekitty>
Date: Thu, 09 Nov 2006 10:12:44 -0700
In-Reply-To: <20061109084937.52af8768@freekitty> (Stephen Hemminger's message
	of "Thu, 9 Nov 2006 08:49:37 -0800")
Message-ID: <m1d57wo86r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> On Thu, 9 Nov 2006 07:49:56 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
>
>> On Wed, Nov 08, 2006 at 01:44:29PM +0100, Olivier Nicolas wrote:
>> 
>> > Hi,
>> 
>> Hi Olivier,
>> 
>> > 2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
>> > without success.
>> > 
>> > Full details (.config, dmesg, /proc/interrupts) are in 
>> > http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz
>> 
>> thanks for your report!
>> 
>> I might be wrong, but looking at the dmesg:
>> - irq 22 is the hda_intel IRQ
>> - the "irq 22: nobody cared" is immediately before the
>>   "hda_intel: No response from codec, disabling MSI..."
>> - in the routeirq case, the hda_intel IRQ as well as the
>>   IRQ in the error message change to 21
>> 
>> So it might be related to the hda_intel MSI check.
>
> More likely the MSI management routines don't work for disabling MSI.

Well brand new MSI handling could be buggy, the disable hypothesis doesn't
make much sense on boot up.

> I am debugging a problem where MSI doesn't work across suspend/resume,
> I suspect the base MSI code needs fixing.

Rethinking the interfaces maybe I don't think the code is broken I think
most likely it is just not designed to do the right thing.  I remember
thinking how horrible that code is, when I read through it.

Eric

