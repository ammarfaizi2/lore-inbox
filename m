Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135967AbRDTQxt>; Fri, 20 Apr 2001 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135976AbRDTQxm>; Fri, 20 Apr 2001 12:53:42 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:42487 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135967AbRDTQxY>; Fri, 20 Apr 2001 12:53:24 -0400
Message-ID: <3AE068E7.72116BFB@tac.ch>
Date: Fri, 20 Apr 2001 18:50:47 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200301380.5165-100000@age.cs.columbia.edu> <3AE05F5A.7942C824@tac.ch> <3AE061A5.FDB4CD5C@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Roberto Nibali wrote:
> >
> > > This was a special case, which btw had nothing to do with the starfire
> > > driver itself. The user needed to support more than 8 eth ports, which
> > > 2.2 complains about, and more than 16 eth ports, which 2.2 simply doesn't
> > > allow without further changes.
> >
> > I made the changes and I was able to load 4 quadboards, 2 3com cards and
> > 1 eepro100 (onboard) and I did some tests and it works fine. However the
> > starfire driver seems not to initialize more then 4 quadboards. I put in
> > 5 and he doesn't initialize it and the others don't work although they
> > get initialized.
> 
> If all five show up in 'lspci', then starfire driver should be able to
> register all five.  [if it doesn't, it is probably a starfire bug]

No, it's not a bug but thank you for this tip. It's just a put-on limitation
in the driver itself:

--- starfire.c~	Fri Apr 20 18:48:05 2001
+++ starfire.c	Fri Apr 20 18:27:20 2001
@@ -308,7 +308,7 @@
 	void (*resume)(struct pci_dev *dev);	/* Device woken up */
 };
 
-#define PCI_MAX_MAPPINGS 16
+#define PCI_MAX_MAPPINGS 32
 static struct pci_driver_mapping drvmap [PCI_MAX_MAPPINGS] = { { NULL, } , };
 
 #define __devinit			__init

This cures my problem. I've checked this and it seems as if Ion copied
this from the sound/emu10k1/emu_wrapper.c code, where I understand that
nobody will have more then 16 times the same soundcard. Ion, do I break
something with this? If not, could you please adjust your driver?

Thanks to all of you for your help. I learned a lot today.
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
