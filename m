Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277833AbRJLTlP>; Fri, 12 Oct 2001 15:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277832AbRJLTlE>; Fri, 12 Oct 2001 15:41:04 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:11782 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S277827AbRJLTkw>; Fri, 12 Oct 2001 15:40:52 -0400
Message-ID: <3BC7474A.41D2BBD2@delusion.de>
Date: Fri, 12 Oct 2001 21:40:58 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        emu10k1-devel@opensource.creative.com
Subject: Re: Linux 2.4.12-ac1
In-Reply-To: <Pine.LNX.4.33.0110122118460.3012-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa wrote:
> 
> Looking at your original e-mail I see there is something else wrong:
> you should have by default OGAIN and DIGITAL1 volume controls.
> 
> Are you loading the modules and only then starting the mixer application?
> Exiting/restarting the mixer doesn't change anything?

Actually I'm not using any sound modules, but have a monolithic kernel.
But I just discovered that the emu10k1 driver is not the culprit here.

[So we can take the discussion to emu10k1-devel and drop lkml]

The problem is interaction with emu-tools-0.9.2. The following boot script
was used to setup the DSP (and worked with previous sound drivers).

If you find something wrong with it, please let me know.

Regards,
-Udo.


# We want ADC mode
/usr/local/bin/emu-config -s"ADC"

# Disable/Clear
/usr/local/bin/emu-dspmgr -x -z

# CPU -> Front & Rear Speakers
/usr/local/bin/emu-dspmgr -a"Pcm:Front"
/usr/local/bin/emu-dspmgr -a"Pcm:Rear"
/usr/local/bin/emu-dspmgr -a"Pcm1:Front"
/usr/local/bin/emu-dspmgr -a"Pcm1:Rear"

# Boost PCM
/usr/local/bin/emu-dspmgr -p"Amplifier" -l"Pcm" -l"Pcm1" -f/usr/local/share/emu10k1/gain_4.bin

# Mic/Line/CD -> CPU
/usr/local/bin/emu-dspmgr -a"Analog:ADC Rec"

# Bass/Treble Controls
/usr/local/bin/emu-dspmgr -p"Bass/Treble-L" -l"Front L" -f/usr/local/share/emu10k1/tone-old.bin -cbass -mbass -ctreble -mtreble
/usr/local/bin/emu-dspmgr -p"Bass/Treble-R" -l"Front R" -f/usr/local/share/emu10k1/tone-old.bin -cbass -mbass -ctreble -mtreble

# Enable
/usr/local/bin/emu-dspmgr -y
