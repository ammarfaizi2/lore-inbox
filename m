Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbREOXWw>; Tue, 15 May 2001 19:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261697AbREOXWm>; Tue, 15 May 2001 19:22:42 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:9947 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261696AbREOXWb>; Tue, 15 May 2001 19:22:31 -0400
Date: Tue, 15 May 2001 16:16:54 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: mjfrazer@somanetworks.com
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <047801c0dd95$231331e0$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The "eth0..N" naming is done RIGHT! 

Only if it's augmented by additional device IDs, such as the
"what 's the physical connection for this interface" sort of
primitive that's been mentioned.


> Nothing to do with the kernel but, one should then argue that the 
> current stuff in /etc/sysconfig/network-scripts is broken for hotplug as 
> placing a new network adapter into your bus will renumber your interfaces 
> causing them to be ifconfig'd wrongly.

Not just hotplug -- any configuration where these identifiers
can change "meaning" (which physical device?) over time.
For example, adding/removing/swapping hardware does it too.


>     You'd want to associate the IP 
> configuration stuff with the particular network interface, by MAC address. 

Bob Glamm had the right sort of idea:  if the kernel is going
to be assigning tool-visible device names, the tools need to
have and use additional device metadata, perhaps like this:

>  # start up networking 
>    for i in eth0 eth1 eth2; do 
>        identify device $i 
>        get configuration/config procedure for device $i identity 
>        configure $i 
>    done 

In fact that "identify" step is probably worth enabling for EVERY (!)
device, not just network interfaces.  (Which, since they don't show
up with major/minor device numbers today, are perhaps a bit offtopic
for the original thrust of this thread ... :)

I suppose that for network interface names, some convention for
interface ioctls would suffice to solve that "identify" step.  PCI
devices would return the slot_name, USB devices need something
like a patch I posted to linux-usb-devel a few months back.

- Dave





