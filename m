Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264032AbRF1TbB>; Thu, 28 Jun 2001 15:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264071AbRF1Tau>; Thu, 28 Jun 2001 15:30:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27785 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264032AbRF1Tah>;
	Thu, 28 Jun 2001 15:30:37 -0400
Message-ID: <3B3B8601.2FEA031E@mandrakesoft.com>
Date: Thu, 28 Jun 2001 15:31:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerhard Mack <gmack@innerfire.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Patrick Dreker <patrick@dreker.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.10.10106281224250.26067-100000@innerfire.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack wrote:
> 
> On Thu, 28 Jun 2001, Jeff Garzik wrote:
> 
> > Linus Torvalds wrote:
> > > Things like version strings etc sound useful, but the fact is that the
> > > only _real_ problem it has ever solved for anybody is when somebody thinks
> > > they install a new kernel, and forgets to run "lilo" or something. But
> > > even that information you really get from a simple "uname -a".
> > >
> > > Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
> > > that we have quota version "dquot_6.4.0"? No. Do we want to get the
> > > version printed for every single driver we load? No.
> > >
> > > If people care about version printing, it (a) only makes sense for modules
> > > and (b) should therefore maybe be done by the module loader. And modules
> > > already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
> > > on their own.  modprobe can do it if it wants to.
> >
> > As Alan said, driver versions are incredibly useful.  People use update
> > their drivers over top of kernel drivers all the time.  Vendors do it
> > too.  "Run dmesg and e-mail me the output" is 1000 times more simple for
> > end users.
> 
> Why not a generic way to query the drivers for version info from
> userspace?

For NICs at least, there's already a generic way... :)

Sigh, in my technically correct heart I know putting driver versions in
dmesg is probably not the best thing, but it makes support -so- -much-
easier that I am not inclined to change the existing code.

FWIW, all the NIC drivers I mess with (most originated from Becker)
should print out:

<one line version>
eth0: short product name, base addr, MAC addr, irq
eth1: ...
eth2: ...

I grant you there are tons of exceptions even in NIC drivers, but that
is the goal I am striving for.  One line version, plus one line per
registered netif.

FWIW I find usb and parport messages exceptionally verbose, but some of
that is probably related to KERN_DEBUG being set in the bootloader or
kernel/printk.c or somewhere...

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
