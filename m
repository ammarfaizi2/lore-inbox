Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVHYAKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVHYAKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVHYAKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:10:50 -0400
Received: from ozlabs.org ([203.10.76.45]:60574 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932397AbVHYAKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:10:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
Date: Thu, 25 Aug 2005 10:10:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>, benh@kernel.crashing.org,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
In-Reply-To: <20050824162959.GC25174@austin.ibm.com>
References: <20050823231817.829359000@bilge>
	<20050823232143.003048000@bilge>
	<20050823234747.GI18113@austin.ibm.com>
	<1124898331.24668.33.camel@sinatra.austin.ibm.com>
	<20050824162959.GC25174@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> The meta-issue that I'd like to reach consensus on first is whether
> there should be any hot-plug recovery attempted at all.  Removing
> hot-plug-recovery support will make many of the issues you raise 
> to be moot.

Yes, this probably the thorniest issue we have.

My feeling is that the unplug half of it is probably fairly
uncontroversial, but the replug half is a can of worms.  Would you
agree with that?

Is it udev that handles the hotplug notifications on the userspace
side in all cases (do both RHEL and SLES use udev, for instance)?
How hard is it to add a new sort of notification, on the kernel side
and in udev?

I think what I'd like to see is that when a slot gets isolated and the
driver doesn't have recovery code, the kernel calls the driver's
unplug function and generates a hotplug event to udev.  Ideally this
would be a variant of the remove event which would say "and by the
way, please try replugging this slot when you've finished handling the
remove event" or something along those lines.

Thoughts?

Paul.

