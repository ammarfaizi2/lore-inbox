Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSEKROL>; Sat, 11 May 2002 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316237AbSEKROK>; Sat, 11 May 2002 13:14:10 -0400
Received: from ns.suse.de ([213.95.15.193]:58637 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316235AbSEKROJ>;
	Sat, 11 May 2002 13:14:09 -0400
Date: Sat, 11 May 2002 19:14:06 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br,
        andre@linux-ide.org, vojtech@suse.cz
Subject: Re: Linux 2.5.14-dj2
Message-ID: <20020511191406.S5262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	marcelo@conectiva.com.br, andre@linux-ide.org, vojtech@suse.cz
In-Reply-To: <20020508225147.GA11390@suse.de> <4.1.20020511114723.009c8270@pop.cablewanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 04:46:09PM +0200, Rudmer van Dijk wrote:
 > proc.c: In function `show_cpuinfo':
 > proc.c:69: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > proc.c:69: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
 > proc.c:99: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
 > proc.c:99: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type

Yep, needs fixing (there are still quite a lot of these in the tree)

 > found a few other problems:
 > 1) the pio fix posted last week is not included in your tree or Linus' and

Erm. That went into my tree a while back, and a day or so later, into
one of Martin's IDE-5x patches.  It also went into Linus' tree a while
back. See changeset 1.513.1.14 at
http://linus.bkbits.net:8080/linux-2.5/cset@1.513.1.14?nav=index.html

 > I found this the hard way: severe filesystem damage and system lockup and a
 > kernel (2.4.19-pre8) panic because the root partition could not be mounted
 > (as reported before). 

Ah, 2.4.19 would be Marcelo's world.

 > The following patch fixes this, apllies with an offset of -2 lines:
 > -- begin patch --
 > --- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
 > +++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
 > @@ -202,7 +202,7 @@
 >  			ata_write_slow(drive, buffer, wcount);
 >  		else
 >  #endif
 > - 			ata_write_16(drive, buffer, wcount<<1);
 > + 			ata_write_16(drive, buffer, wcount);
 >  	}
 >  }

Yes, it does look like a variant of this patch is missing there too.
Andre, Confirm?  Line 112 looks suspect back there. Or is 2.4 doing
different voodoo with the wcount ?


 > 2) After boot the system is not responsive to the keyboard, logging in via
 > ssh and doing a `insmod psmouse` followed by a `rmmod psmouse` results in a
 > working keyboard...
 > before and after insmod there is no interrupt 1 listed in /proc/interrupts,
 > but after doing the rmmod it is listed: "  1:         52          XT-PIC
 > i8042"
 > the mouse interrupt is listed as " 12:        154          XT-PIC  i8042"
 > the following message was issued after `rmmod psmouse`: "input: AT Set 2
 > keyboard on isa0060/serio0"

Odd, That's one for Vojtech to think about 8-)

Thanks for the report.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
