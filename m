Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSJZGgs>; Sat, 26 Oct 2002 02:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261879AbSJZGgs>; Sat, 26 Oct 2002 02:36:48 -0400
Received: from ns.suse.de ([213.95.15.193]:33550 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261886AbSJZGgr>;
	Sat, 26 Oct 2002 02:36:47 -0400
To: Jon Grimm <jgrimm2@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.5.44: Still has KVM + Mouse issues
References: <3DB9DA64.E48C8C5B@us.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Oct 2002 08:43:02 +0200
In-Reply-To: Jon Grimm's message of "26 Oct 2002 02:27:31 +0200"
Message-ID: <p738z0lu2dl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Grimm <jgrimm2@us.ibm.com> writes:

> 	If a fix is available I'd love to test it out as I still see strange
> behavior 
> with an Intellimouse and my MasterView CS-104 KVM switch (yep its
> old).   
> 
> 	With a few trusty printks, it looks like after I switch away & back 
> into 2.5.44, the mouse is now sending 3 byte packets instead of the 4 it 
> previously was.  

I had the same problem also with an MasterView KVM and intellimouse.
They seem to have some problems in the mouse protocol implementation
in the switch.

The mouse can be identified through the KVM as a Intellimouse, but when
actually talking later some bytes get dropped. It actually said on the
wrapping that it should work with Intellimouse, but I think they
lied (or Windows uses some different way to initialise the mouse that 
works)

Boot with psmouse_noext, that should fix it. It runs the intellimouse as a 
plain PS/2 mouse. You lose the additional mouse buttons and the scroll wheel, 
but they never worked through that KVM anyways.

-Andi
