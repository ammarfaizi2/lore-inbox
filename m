Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUEaD3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUEaD3a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 23:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUEaD33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 23:29:29 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48773
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264515AbUEaD32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 23:29:28 -0400
From: Rob Landley <rob@landley.net>
To: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: swappiness=0 makes software suspend fail.
Date: Sun, 30 May 2004 22:28:07 -0500
User-Agent: KMail/1.5.4
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@zip.com.au>,
       Stuart Young <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       seife@suse.de
References: <200405280000.56742.rob@landley.net> <20040530194731.GA895@elf.ucw.cz> <200405310123.22136.oliver@neukum.org>
In-Reply-To: <200405310123.22136.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405302228.08467.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 18:23, Oliver Neukum wrote:
> Am Sonntag, 30. Mai 2004 21:47 schrieb Pavel Machek:
> > > Until something like this goes through, please don't fuglify
> > > vmscan.c any more than it is... do the saving and restoring
> > > thing that Nigel suggested please.
>
> Isn't that a race condition with setting swapiness?

During suspend?  Not really.  If it's done from the userspace script, it's 
done before the suspend is triggered, and undone after suspend comes back.  
No problem there.  If it's done in the kernel, then all the userspace 
thingies that might play with it have already been frozen, it's never touched 
from interrupt context...  What would you be locking _against_?

Swappiness isn't really twiddled from a lot of places.  Maybe your init script 
touches it.  Other than that, you have to be root, and you pretty much have 
to do it manually.  Touching this tuning knob is about as common as touching 
/proc/sys/net/ipv4/tcp_ecn or /proc/sys/kernel/panic.

The failure condition is graceful, by the way.  The suspend doesn't free 
enough memory, and thus resumes userspace immediately.  Kind of annoying if 
you've packed away your laptop to let it power down (since it can take a good 
45 seconds to do so, depending on how fragmented your swap file and memory 
and such are...)

> 	Regards
> 		Oliver

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

