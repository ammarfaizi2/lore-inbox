Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSAXP7W>; Thu, 24 Jan 2002 10:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAXP7F>; Thu, 24 Jan 2002 10:59:05 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:60846 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287177AbSAXP6r>; Thu, 24 Jan 2002 10:58:47 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Rasmus Hansen <moffe@amagerkollegiet.dk>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 16:58:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124155853Z287177-13996+11274@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 12:40, Rasmus Hansen wrote:

Hello Rasmus,

I hope that I've extracted your name right?

>On Thu, 24 Jan 2002, Daniel Nofftz wrote:
>
> > On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:
> > 
> > > You see, I'm fiddleing with power saving quite some time.
> > 
> > oh ,.. by the way : does dmesg show somthing like "dissconect in via
> > northbridge enabled: kt133 chipset found " or something similar ?
> > (only if you have my patch ativated)
>
> I tried your patch. I get the message above (I have a KT133A). With only 
> APM enabled, it makes no difference; witch ACPI, temp goes from 47C -> 
> 38C without stability problems nor preformance drops.

This are very good numbers, which I've expected.

> However, after disabling APM and enabling ACPI, my system won't power 
> off anymore :-(

This should be easily solved.

I point on your distro's startup scripts. They only look if apm is enabled 
but _NOT ACPI...

Have a look into /etc/init.d/halt (taken from SuSE 7.3, LSB standard).

[-]
case "$0" in
        *halt)
                message="The system will be halted immediately."
                case `/bin/uname -m` in
                    i?86)
                        command="halt"
                        if test -e /proc/apm -o -e /proc/acpi ; then	<----!!!!
                            command="halt -p"
                        else
                            read cmdline < /proc/cmdline
                            case "$cmdline" in
                                *apm=smp-power-off*|*apm=power-off*)  
command="halt -p" ;;
                            esac
                        fi
                        ;;
                    *)
                        command="halt -p"
[-]

Expand the marked line with acpi like above.

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
