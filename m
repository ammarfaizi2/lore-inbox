Return-Path: <linux-kernel-owner+w=401wt.eu-S965007AbWLTMEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWLTMEA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWLTMD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:03:58 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:60055 "EHLO
	thumbler.kulnet.kuleuven.ac.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964991AbWLTMCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:02:46 -0500
X-Greylist: delayed 2026 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 07:02:46 EST
Message-ID: <458956CB.7060004@joow.be>
Date: Wed, 20 Dec 2006 12:29:15 -0300
From: Pieter Palmers <pieterp@joow.be>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com>
In-Reply-To: <20061220005822.GB11746@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Hi,
> 
> Here's a new set of patches for the new firewire stack.  The changes
> since the last set of patches address the issues that were raised on
> the list and can be reviewed in detail here:
.. for some reason I didn't get patch 3/4 and 4/4 on the linux1394-devel 
list, so I'll reply to this one.

I would suggest a reordering of the interrupt flag checks. Currently the 
interrupts that are least likely to occur are checked first. I don't see 
why. I would reorder the check such that ISO interrupts are checked 
first, as they have the most stringent timing constraints and are most 
likely to occur (when using ISO traffic).

After processing the ISO interrupts (and maybe the Async ones), a bypass 
could be inserted to exit the interrupt handler when there are no other 
interrupts to be handled. All other interrupts are to report relatively 
rare events or errors (error handling still to be added I assume). The 
effective run-length of the interrupt handler would be shorter using 
such a bypass, especially in the case where there is a lot of ISO traffic.

I'm looking forward to your ISO implementation, and I hope to 
incorporate it into FreeBob really fast.

Pieter
