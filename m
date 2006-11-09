Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424116AbWKIQxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424116AbWKIQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424117AbWKIQxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:53:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424116AbWKIQxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:53:14 -0500
Date: Thu, 9 Nov 2006 08:49:37 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Olivier Nicolas <olivn@trollprod.org>, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64  irq 22: nobody cared
Message-ID: <20061109084937.52af8768@freekitty>
In-Reply-To: <20061109064956.GG4729@stusta.de>
References: <4551D12D.4010304@trollprod.org>
	<20061109064956.GG4729@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 07:49:56 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Wed, Nov 08, 2006 at 01:44:29PM +0100, Olivier Nicolas wrote:
> 
> > Hi,
> 
> Hi Olivier,
> 
> > 2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
> > without success.
> > 
> > Full details (.config, dmesg, /proc/interrupts) are in 
> > http://olivn.trollprod.org/2.6.19-rc5-irq.tar.gz
> 
> thanks for your report!
> 
> I might be wrong, but looking at the dmesg:
> - irq 22 is the hda_intel IRQ
> - the "irq 22: nobody cared" is immediately before the
>   "hda_intel: No response from codec, disabling MSI..."
> - in the routeirq case, the hda_intel IRQ as well as the
>   IRQ in the error message change to 21
> 
> So it might be related to the hda_intel MSI check.

More likely the MSI management routines don't work for disabling MSI.
I am debugging a problem where MSI doesn't work across suspend/resume,
I suspect the base MSI code needs fixing.


-- 
Stephen Hemminger <shemminger@osdl.org>
