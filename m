Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271829AbTHDPtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271831AbTHDPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:49:49 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:26558 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S271829AbTHDPtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:49:43 -0400
Date: Mon, 4 Aug 2003 07:50:26 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-test1, PCMCIA cards require two insertions
Message-ID: <20030804155026.GB10269@iarc.uaf.edu>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030725210242.GH15537@iarc.uaf.edu> <20030802173352.A1895@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802173352.A1895@flint.arm.linux.org.uk>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

Earlier I reported:

> On Fri, Jul 25, 2003 at 01:02:42PM -0800, Christopher Swingley wrote:
> > I'm running 2.6.0-test1 on an SiS based laptop with all the PCMCIA 
> > network and serial drivers built into the kernel.  When the system boots 
> > with a PCMCIA cardbus card in place, the card doesn't show up.  I unplug 
> > the card and plug it back in, and then the kernel "sees" it and it 
> > works.  If I unplug it again, I have to go through a plug - unplug - 
> > plug cycle before it recognizes it.  As if it only recognizes the card 
> > on even numbered insertion events.

Still behaves the same way with a stock 2.6.0-test2.  I applied the 
patch you included to 2.6.0-test2.  Same strange dual-insertion behavior 
was noted.

Also, I have another laptop, Intel based, that doesn't show this 
behavior.  So it's something to do with this one.

> Hmm, weird - I'm not seeing that behaviour here.  Can you report back
> with kernel messages with the following patch applied please?

Here's what happens on the console.  If you want kern.log, let me know 
and I'll send that along.  I don't see anything different between them.

After the laptop finishes booting, the PCMCIA network card (tulip 
driver) is not running.

I remove the card:

    parse_events: socket df5cd82c thread df60e060 events 00000080
    socket df5cd82c status 00001c00

I insert the card:

    parse_events: socket df5cd82c thread df60e060 events 00000080
    socket df5cd82c status 00001c80
    socket_insert: skt df5cd82c
    socket_setup: skt df5cd82c status 00001c80
    socket_reset: skt df5cd82c
    Linux Tulip driver version 1.1.13 (May 11, 2002)
    <rest of tulip driver stuff snipped>

I remove the card:

    parse_events: socket df5cd82c thread df60e060 events 00000080
    socket df5cd82c status 00001c00
    socket_remove: skt df5cd82c
    socket_shutdown: skt df5cd82c status 00001c80
 
I insert the card:

    (nothing at all)

I remove the card:

    parse_events: socket df5cd82c thread df60e060 events 00000080
    socket df5cd82c status 00001c00

I insert the card:

    parse_events: socket df5cd82c thread df60e060 events 00000080
    socket df5cd82c status 00001c80
    socket_insert: skt df5cd82c
    socket_setup: skt df5cd82c status 00001c80
    socket_reset: skt df5cd82c
    Linux Tulip driver version 1.1.13 (May 11, 2002)
    <rest of tulip driver stuff snipped>

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

