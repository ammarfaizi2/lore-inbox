Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135802AbRD2PPX>; Sun, 29 Apr 2001 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135803AbRD2PPN>; Sun, 29 Apr 2001 11:15:13 -0400
Received: from alpo.casc.com ([152.148.10.6]:8175 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S135802AbRD2PO5>;
	Sun, 29 Apr 2001 11:14:57 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15084.12152.956561.490805@gargle.gargle.HOWL>
Date: Sun, 29 Apr 2001 11:12:56 -0400
To: esr@thyrsus.com
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
In-Reply-To: <20010427193501.A9805@thyrsus.com>
In-Reply-To: <20010427193501.A9805@thyrsus.com>
X-Mailer: VM 6.90 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric> I'm going to stick my neck out a mile and say that I think this
Eric> is a stable release.  Doing so, of course, is in reality a
Eric> clever plan which ensures that at least three embarrassing bugs
Eric> will be discovered within the next 24 hours...

I've just downloaded and installed cml-1.3.2 on my Dual processor PPro
200mhz, 128mb system.  Unfortunately, I set it up into a 2.4.4-pre7 +
patches tree, and it's now giving me the following when I do a 'make
config':

  [root@jfs linux]# make config
  rm -f include/asm
  ( cd include ; ln -sf asm-i386 asm)
  python -O scripts/cmlconfigure.py -DX86 -B 2.4.4-pre7 -W -i config.out
  rules.out
  ISA=y (deduced from X86)
  Side effects from config.out:
  NETDEVICES=m (deduced from ATALK)
  SOUND_OSS=m (deduced from SOUND_VIA82CXXX)
  SOUND_OSS=y (deduced from SOUND_YMFPCI_LEGACY)
  SOUND=y (deduced from SOUND_OSS)
  This configuration violates the following constraints:
  '((X86 and SMP) implies (RTC != n))'
  python -O scripts/configtrans.py -h include/linux/autoconf.h -s
  .config config.out


Which is a real PITA because now I have to edit my .config file to
have:

   CONFIG_RTC=y

in there.  Now when I do a 'make config' it comes up properly.  I
think this is a poor interface setup.  It should either

a.  Give more info on what to correct, such as the configuration line
    to edit and in which file.

b.  Print a warning, startup the configuration tool and put you at the
    problematic line, with the help section showing.  Or highlight this
    choice in some manner as being wrong and showing you how to ffix it.

This is a minor, but annoying problem and should be fixed ASAP before
public use.  

In general, I like what I do see, it's more interface issues that I
have so far. 

Now for some comments on the X interface.  

At the top-level, most stuff cannot be selected on/off, but you can
enter it.  But you also do have some y/m/n choices which seems wierd
and out of place.  For example, "SCSI disk support" is a menu, but
"HAMRADIO: Amateur Radio support (NEW)" is a y/n choice.  It would
make more sense to me to have it down a level, with a simple entry to
"Hamradio support".  Once you go into that level, you would be asked
to have it turned on/off there.

This would remove some of the clutter at the top level.  

As a contrast, the USB entry doesn't ask Y/N for USB support, and when
I enter the directory, it has all these options listed.  I thought
that CML would suppres stuff (children, drivers, etc) if I didn't have
the top level selected.  In this case, I can't turn off USB support in
any manner, so I see all the children when I could care less about
them.

Also, the buttons on the right hand side for HELP, are wider when they
have text in them, but slightly narrower when they are blank.  They
should be the same width no matter what.  It looks ragged and ugly.

I don't like how it keeps changing the window size whenever you go
into a sub-level.  It should not re-size the main window at all, it
should just update the contents and give scroll bars if needed for
both up/down scolling and side to side.  Once the user has setup their
prefs, the CML code shouldn't keep it jumping all over the screen.

John

   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
