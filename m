Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWIHH4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWIHH4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWIHH4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:56:54 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20648 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWIHH4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OIu/hgx5tLWJMWqQkZAoNBleyQND5Ems8x2bTZzXuhoQn0fMoP6znjquqfll6z0ZCY71mTeSBVkR/VOsClj/35qFfHoGvTDxuW814CbN4pTEQJswGnmlfFtKOSYBHMUsKndEjXaNUok593xRPpZeiIPLab/dfT0aoM9NznL3eKA=
Message-ID: <a44ae5cd0609080056m61b43318tfe5b0034ef3081f@mail.gmail.com>
Date: Fri, 8 Sep 2006 00:56:51 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.18-rc5-git1 + "ieee1394: nodemgr" patches -- BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
Cc: LKML <linux-kernel@vger.kernel.org>, linux1394-devel@lists.sourceforge.net
In-Reply-To: <450119D1.7070504@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609071821h515753f5wdd3ceecc39434e91@mail.gmail.com>
	 <450119D1.7070504@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Miles Lane wrote:
> ...
> > Things went pretty well, until I ran
> > "pccardctl eject" and then popped out the Firewire card.
> ...
> > BUG: unable to handle kernel NULL pointer dereference at virtual
> > address 00000000
> ...
> > EIP is at dv1394_remove_host+0x17/0xad [dv1394]
> ...
> > Call Trace:
> > [<f91788c2>] __unregister_host+0x17/0x79 [ieee1394]
> > [<f9178945>] highlevel_remove_host+0x21/0x42 [ieee1394]
> > [<f9177e65>] hpsb_remove_host+0x37/0x56 [ieee1394]
> > [<f912c9f2>] ohci1394_pci_remove+0x41/0x1cd [ohci1394]
> > [<c10c5d24>] pci_device_remove+0x16/0x28
> > [<c111dcbd>] __device_release_driver+0x5a/0x72
> > [<c111de8f>] device_release_driver+0x1b/0x29
> > [<c111d705>] bus_remove_device+0x78/0x8a
> > [<c111c8a7>] device_del+0xe9/0x11a
> > [<c111c8e0>] device_unregister+0x8/0x10
> > [<c10c3ee5>] pci_remove_bus_device+0x39/0xcf
> > [<c10c3f95>] pci_remove_behind_bridge+0x1a/0x2d
> > [<f910d5ae>] socket_shutdown+0x89/0xdd [pcmcia_core]
> > [<f910d675>] pcmcia_eject_card+0x56/0x65 [pcmcia_core]
> ...
>
> Looks like the last word on
> http://bugzilla.kernel.org/show_bug.cgi?id=2228 isn't spoken. Maybe the
> bug can be fixed in dv1394 itself, or maybe we need to rework the
> ieee1394 core's *_remove_host sequence.
>
> Checking the 1394 driver stack's conduct during card hot-ejection is in
> my long-term to-do list. Hopefully someone else can look at it sooner.
> But I suggest you open a new bugzilla bug so we don't lose track.
>
> I suppose the temporary workaround is to unload dv1394 before card ejection.

Thanks,

I created the bug report:  http://bugzilla.kernel.org/show_bug.cgi?id=7121

Best wishes,
        Miles
