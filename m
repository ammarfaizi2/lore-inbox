Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTF3IJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbTF3IJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:09:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35343 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265157AbTF3IJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:09:20 -0400
Date: Mon, 30 Jun 2003 09:23:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rol@as2917.net, cfriesen@nortelnetworks.com, paulus@samba.org,
       linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [BUG]: problem when shutting down ppp connection since 2.5.70
Message-ID: <20030630092337.B32593@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, rol@as2917.net,
	cfriesen@nortelnetworks.com, paulus@samba.org,
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-net@vger.kernel.org
References: <3EFFA1EA.7090502@nortelnetworks.com> <005e01c33ecd$e20ce6e0$4100a8c0@witbe> <20030630090507.A32593@flint.arm.linux.org.uk> <20030630.010337.74723316.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030630.010337.74723316.davem@redhat.com>; from davem@redhat.com on Mon, Jun 30, 2003 at 01:03:37AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 01:03:37AM -0700, David S. Miller wrote:
>    From: Russell King <rmk@arm.linux.org.uk>
>    Date: Mon, 30 Jun 2003 09:05:07 +0100
>    
>    People with PCMCIA cards have been reporting the same thing.  It sounds
>    like something's up with the netdev layer, and it has persisted until
>    2.5.73 thus far.
> 
> If there are bugs in pcmcia drivers, they are _really_ going to show
> now.  The change is that 'rmmod' is allowed even if the device is
> "up".  We don't grab/drop module reference counts when the device is
> brought up/down.  We simply "down" up net devices at
> unregister_netdevice() time.
> 
> So if a device is racey, it's going to be "really" racey now.
> 
> If people mention which devices give the problems (with current
> kernels, we've fixed a lot of bugs as of late) the drivers can
> be audited for register/unregister bugs.

The thread I replied to is about pppoe devices, so it isn't limited to
PCMCIA, although that seems to be the most popular subset which causes
the problem.

Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> Summary:
> On 2.5.70 and later kernels, shutting down a pppoe connection causes
> pppd to hang and results in a usage count stuck at 1.

John M Flinchbaugh <glynis@butterfly.hjsoft.com> wrote:
> i still see it with both my 3c574_cs and my orinoco_cs in 2.5.73.

bvermeul@blackstar.nl wrote:
> I'm having some problems with 2.5.71 (latest bk yesterday I believe).
> All works well (pcmcia works as advertised, with one tiny blip on
> the horizon), except when I want to reboot, when I get the following
> message:
>
> unregister_netdevice: waiting for eth1 to become free. Usage count = 1
>
> The net device is an Orinoco mini-pci card (eg, cardbus minipci interface
> with built-in orinoco card), and it is down.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

