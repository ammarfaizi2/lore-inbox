Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293664AbSCAThb>; Fri, 1 Mar 2002 14:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293665AbSCAThW>; Fri, 1 Mar 2002 14:37:22 -0500
Received: from bof.de ([195.4.223.10]:45842 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S293661AbSCAThK>;
	Fri, 1 Mar 2002 14:37:10 -0500
Date: Fri, 1 Mar 2002 20:44:00 +0100
From: Patrick Schaaf <bof@bof.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches.
Message-ID: <20020301204400.B24565@oknodo.bof.de>
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <3C7FD3C2.9674ADD7@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7FD3C2.9674ADD7@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 02:17:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 02:17:22PM -0500, Jeff Garzik wrote:
> Ben Greear wrote:
> > --- linux-2.4.16/drivers/net/eepro100.c Mon Nov 12 18:47:18 2001
> > +++ linux/drivers/net/eepro100.c        Tue Dec 18 11:36:11 2001
> > @@ -510,12 +510,12 @@
> >   static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
> >          22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
> >          0, 0x2E, 0,  0x60, 0,
> > -       0xf2, 0x48,   0, 0x40, 0xf2, 0x80,              /* 0x40=Force full-duplex */
> > +       0xf2, 0x48,   0, 0x40, 0xfa, 0x80,              /* 0x40=Force full-duplex */
> >          0x3f, 0x05, };
> >   static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
> >          22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
> >          0, 0x2E, 0,  0x60, 0x08, 0x88,
> > -       0x68, 0, 0x40, 0xf2, 0x84,              /* Disable FC */
> > +       0x68, 0, 0x40, 0xfa, 0x84,              /* Disable FC */
> >          0x31, 0x05, };
> 
> hmmm. hmmm. hmmm.
> 
> I am sorely tempted to drop this patch, simply because it's changing one
> magic number to another.  One key question I have is, what the fsck does
> this patch really do???  If it turns on VLAN [de-]tagging
> unconditionally, for example, that's unacceptable.

This patch, from all I know using it, does exactly one thing: it permits
receiving (and sending) slightly larger frames, for setting the MTU on the
base interface to 1504, so the VLAN interfaces themselves can run the
normal 1500 byte MTU.

I have been using the patch to this end on several eepro100 based systems,
over the last year, with no surprises.

I agree that such an array of magic constants is very very undesirable.

best regards
  Patrick
