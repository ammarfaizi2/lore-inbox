Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbRBLUyu>; Mon, 12 Feb 2001 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRBLUyj>; Mon, 12 Feb 2001 15:54:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18706 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129858AbRBLUya>; Mon, 12 Feb 2001 15:54:30 -0500
Message-ID: <3A884D72.E0F3D354@transmeta.com>
Date: Mon, 12 Feb 2001 12:54:10 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <Pine.SOL.4.21.0102122025320.22949-100000@yellow.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> 
> Excellent plan: data centre sysadmins the world over will worship your
> name if it works...
> 
> What exactly do you have in mind: a bidirectional connection you could
> use to control everything from LILO/Grub onwards? Should be feasible,
> anyway.
> 
> I'd go with UDP for this, rather than raw Ethernet. Use DHCP to get the IP
> address(es) to connect to as console hosts? (That or a command line
> option...)
> 

Yes, that's my thinking too.  A DHCP/BOOTP option seems to be the obvious
way, and I'd hate to use non-obvious ways when there is a perfectly good
obvious way.

> The first thing is the kernel: just wrap around printk so as soon as eth0
> is up, you set up a session and start sending packets.

My thinking at the moment is to require kernel IP configuration (either
ip= or RARP/BOOTP/DHCP).  It seems to be the only practical way;
otherwise you miss too much at the beginning.  However, that mechanism is
already in place, and shouldn't be too hard to piggy-back on.

> I'll do a server to receive these sessions - simple text (no vt100 etc),
> one window per session - and work on the protocol spec. Anyone willing
> to do the client end of things - lilo, grub, kernel, etc??

I'll do PXELINUX, for sure.  I'd prefer to do the protocol spec, if you
don't mind -- having done PXELINUX I think I know the kinds of pitfalls
that you run into doing an implementation in firmware or firmware-like
programming (PXELINUX isn't firmware, but it might as well be.)

Doing it in LILO would be extremely difficult, since LILO has no ability
to handle networking, and no reasonable way to graft it on (you need a
driver for networking.)  GRUB I can't really comment on.

I might just decide to do the kernel as well.

Hmmm... this sounds like it's turning into a group effort.  Would you (or
someone else) like to set up a sourceforge project for this?  I would
prefer not to have to deal with that end myself.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
