Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264421AbTDPNzs (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTDPNzs 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:55:48 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:16900 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264421AbTDPNzi (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 09:55:38 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Udo Hoerhold <maillists@goodontoast.com>
Subject: Re: SoundBlaster Live! with kernel 2.5.x
Date: Wed, 16 Apr 2003 15:07:25 +0100
User-Agent: KMail/1.5.9
References: <200304160140.23873.alistair@devzero.co.uk> <200304160029.22234.maillists@goodontoast.com>
In-Reply-To: <200304160029.22234.maillists@goodontoast.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dOWn+a3bW6Hm4kg"
Message-Id: <200304161507.25641.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dOWn+a3bW6Hm4kg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 April 2003 05:29, you wrote:
>
> OK, I was using ALSA, but I tried OSS instead.  I don't get the popping
> sounds anymore, but I don't get any sound at all.
>

Add an entry to the kernel bugzilla detailing the ALSA trouble. See Robert's 
post about checking logs and dmesg for errors.

> udo:~$ dmesg | grep EMU10K
> Creative EMU10K1 PCI Audio Driver, version 0.20, 20:58:14 Apr 15 2003
> emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xdf80-0xdf9f, IRQ 10
>
> Maybe this is not a kernel problem now, although 2.4.20 worked without any
> other configuration.  I'm running KDE, and I don't have emu-tools, but
> maybe I can poke around and see if I can find the problem.

I'm surprised by this, because Rui recently updated the 2.5 emu10k1 sources to 
match the 2.4.20 sources. There are very few difference (2.4.20 used in 
both). Make sure you don't have anything "alsa" compiled in anyway (is that 
even possible?).

I, myself, would like to use ALSA with my emu10k1, but presently the software 
tone controls have the most awful artifacts you can imagine (and are 
substantially inferior to the tone control dsp from the emu-tools package..) 
and the rear-speaker routings in ALSA do not scale with the master PCM slider 
(which only changes the front speakers). I used to have this problem in OSS, 
too, and it was due to routing problems, but I cannot see any emu10k1 
specific routing utilities in alsa-utils or alsa-tools (?) that do this. Nor 
should I have to, optimal settings should be the default, as is with the OSS 
driver.

Are these problems being worked on, or are these bugs I should report? At the 
present time, the ALSA driver is not a technically suitable for the ageing 
OSS driver. And it hasn't been since the original emu10k1 driver back in the 
pre-0.9.x days, so I find it difficult to believe there's a quick fix.

The emu-tools may be required to enable some of the routing in the new driver, 
I'm not sure. What I've done is install the emu tools, (edit the Makefile to 
install to /usr not /usr/local) move "emu-script" to /usr/bin (/etc is silly) 
and used the attached emu10k1.conf.

For managing the volume, I use umix from sourceforge.net (but anything similar 
e.g. aumix should suffice) and I've included a working volume profile from 
umix (I also had to hack the emu-script to use umix and not aumix; it's not 
very well designed).

I hope this helps.

Cheers,
Alistair.

--Boundary-00=_dOWn+a3bW6Hm4kg
Content-Type: text/plain;
  charset="iso-8859-1";
  name="umixrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="umixrc"

# Umix config file
[global]
device=/dev/sound/mixer
config=/etc/umixrc
plugindir=/usr/lib/umix
ui=ncurses
driver=OSS

[mixers]
# Creative SBLive - Emu10k1, OSS
mixer=/dev/sound/mixer
{
	vol 86:86  
	bass 100:100  
	treble 91:91  
	pcm 64:64  
	speaker 0:0  
	line 32:32 R
	mic 0:0 P
	cd 0:0 P
	igain 1:1 P
	ogain 68:68  
	line1 0:0 P
	phin 0:0 P
	phout 0:0  
	video 0:0 P
}

--Boundary-00=_dOWn+a3bW6Hm4kg
Content-Type: text/plain;
  charset="iso-8859-1";
  name="emu10k1.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="emu10k1.conf"

##
## This file is used to configure emu10k1's emu-script
##

CARD_IS_5_1=no
USE_DIGITAL_OUTPUT=no
ENABLE_TONE_CONTROL=yes

# Note, it's safe to say yes to the next option even if you're not going
# to use it. When this option is enabled, the driver can autodetects AC3
# data and behaves normally with normal audio.
# (Saying yes causes some of the soundcard's resourses to be used up)
AC3PASSTHROUGH=yes

# Change this to yes to enable the Livedrive midi port and IR remote 
# control.
ENABLE_LIVEDRIVE_IR=no

# Most Lives have their analog front signals inverted. If you have
# problems with your setup (low bass), try changing this to 'yes'. (This
# option has no effect with digital setups)
INVERT_REAR=no

#Multichannel playback (for 4 - 6 channel setups)
MULTICHANNEL=yes

# On 5.1 cards in multichannel mode, should the multichannel data be fed
# to the sub as well?  You probably don't want this if you have a
# speaker set like the DTT2200 which already feeds all channels to the
# sub in hardware.
ROUTE_ALL_TO_SUB=no

# By default, the front analog channels have a +12dB boost applied to
# them by the AC'97 mixer. If you encounter clipping, or find that the
# volume of the front speakers is too high in a multichannel setup, try
# changing this to 'no'.
ANALOG_FRONT_BOOST=no



# Surround
##################

# Some wavs, or mp3 are surround sound encoded the next two
# options can be used to decode these in hardware.
# (select on or the other, not both)

# passive matrix surround decoder 
SURROUND=no

# Active matrix surround decoder
PROLOGIC=no


# Extra Inputs 
#################

## This connector is mounted on the card itself
ENABLE_CD_Spdif=no  # Volume control is 'Digital1' in aumix/gmix/kmix

# The next four inputs are found on Livedrives, some of these may also
# be inputs on the older add-on daughter cards.

ENABLE_OPTICAL_SPDIF=no # Volume control is 'Digital2'
ENABLE_LINE2_MIC2=no    # Volume control is 'Line2'
ENABLE_RCA_SPDIF=no     # Volume control is 'Digital3'
ENABLE_RCA_AUX=no       # Volume control is 'line3'


--Boundary-00=_dOWn+a3bW6Hm4kg
Content-Type: application/x-shellscript;
  name="emu-script"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="emu-script"

#!/bin/bash -e
#
#     emu-script  --  A setup script
#
#     Author: Daniel Bertrand
#     Last Update:   Sept 30, 2001
#     Version:       0.7
#
# Description:
# -----------
# You can use this script to automatically configure the card 
# on module load
#
# To do so, add the following line to your module.config (or conf.module) file
# (and remove the leading '#'):
# 
# post-install emu10k1 /usr/local/etc/emu-script
#
# if you want to save mixer levels, you can use the following:
# 
# post-install emu10k1 /usr/local/etc/emu-script restore
# pre-remove emu10k1 /usr/local/etc/emu-script save
#
# configuration is done in the file 'emu10k1.conf'
#
# Requirements:
# ------------
# This script needs the following to be installed:
#
# -the emu10k1 tools: 
#      emu-config, emu-dspmgr and the dsp .bin files
# -aumix (installed by default on many Linux distros)
# 
#
# Optional argument processing:
# This script takes arguments which can override the settings in the
# config file. The following flags are supported:
#
# -d [yes|no]	use the digital output
# -t [yes|no]	enable the tone controls
# -3 [yes|no]	enable ac3 passthrough
# -i [yes|no]	enable livedrive ir
# -r [yes|no]	invert rear channels
# -m [yes|no]	enable multichannel mode
# -s [yes|no]	route all multichannel signals to sub
# -b [yes|no]	enable the 12dB front analog boost
#
# I don't include command line switches for enabling the various inputs
# or selecting if the card is 5.1 since I can't see being able to set or
# unset these on the fly being particularly useful.

# Default location of programs: 
BASE_PATH=/usr
DSPPATH=$BASE_PATH/share/emu10k1

DSPMGR=$BASE_PATH/bin/emu-dspmgr
CONFIG=$BASE_PATH/bin/emu-config

DRIVER_VERSION=` $DSPMGR  -q` 
 
SAVEARGS="$@"

load(){

# Source configurations
  . $BASE_PATH/etc/emu10k1.conf

# Pick up any coomand line overrides
while getopts d:t:i:r:m:s:b: OPT $SAVEARGS; do
	case "$OPT" in
	d)
		USE_DIGITAL_OUTPUT=$OPTARG
		;;
	t)
		ENABLE_TONE_CONTROL=$OPTARG
		;;
	3)
		AC3PASSTHROUGH=$OPTARG
		;;
	i)
		ENABLE_LIVEDRIVE_IR=$OPTARG
		;;
	r)
		INVERT_REAR=$OPTARG
		;;
	m)
		MULTICHANNEL=$OPTARG
		;;
	s)
		ROUTE_ALL_TO_SUB=$OPTARG
		;;
	b)
		ANALOG_FRONT_BOOST=$OPTARG
		;;
	*)
		exit 1
		;;
	esac
	shift 2
done

#set some variables
if [ "$USE_DIGITAL_OUTPUT" = yes ]; then
    FRONT="Digital"
    CENTER="Digital Center"
    LFE="Digital LFE"
else
    FRONT="Front"
    CENTER="Analog Center"
    LFE="Analog LFE"
fi

##function to enable an input
enable_input(){
    INPUT=$@
    $DSPMGR -a"$INPUT:$FRONT" -a"$INPUT:Rear"

}
input_volume(){
    INPUT=$1
    VOLUME=$2

    $DSPMGR -p"$VOLUME Vol" -l"$INPUT" -f$DSPPATH/vol_2.bin -c"Vol_L" -m"${VOLUME}_l" -c"Vol_R" -m"${VOLUME}_r"
}    

#Start by clearing everything and stopping the FX8010
$DSPMGR -x -z


#
# Livedrive and other special inputs can be enabled here by un-commenting
# the appropriate lines
# 


if [ "$ENABLE_CD_Spdif" = yes ]; then
    enable_input "CD-Spdif"
    input_volume "CD-Spdif" "dig1"
fi

if [ "$ENABLE_OPTICAL_SPDIF" = yes ]; then
    enable_input "Opt. Spdif"
    input_volume "Opt. Spdif" "dig2"
fi
if [ "$ENABLE_LINE2_MIC2" = yes ]; then 
    enable_input "Line2/Mic2"
    input_volume "Line2/Mic2" "line2"
fi
if [ "$ENABLE_RCA_SPDIF" = yes ]; then
    enable_input "RCA Spdif"
    input_volume "RCA Spdif" "dig3"
fi
if [ "$ENABLE_RCA_AUX" = yes ]; then
    enable_input "RCA Aux"
    input_volume "RCA Aux" "line3"
fi

if [ "$AC3PASSTHROUGH" = yes ]; then
    $DSPMGR -a"fx15:Digital L"
    $DSPMGR -a"fx15:Digital R"
    $DSPMGR -l"Digital" -f$DSPPATH/ac3pass.bin
fi


# Add common routes:

$DSPMGR -a"Pcm1:Rear" -a"Analog:ADC Rec"  -a"Analog:Rear" -a"Pcm:Rear"

#PCM volume gain
$DSPMGR -l"Pcm1" -l"Pcm" -f$DSPPATH/gain_4.bin

#Rear Volume Controls
#$DSPMGR -p"Master R" -l"Rear R" -f$DSPPATH/vol.bin -cVol -mvol_r
#$DSPMGR -p"Master L" -l"Rear L" -f$DSPPATH/vol.bin -cVol -mvol_l
$DSPMGR -p"Rear Vol R" -l"Rear" -f$DSPPATH/vol_2.bin -c"Vol_L" -mogain_l -c"Vol_R" -mogain_r

#digital/analog specific setup
if [ "$USE_DIGITAL_OUTPUT" = yes ]; then

    $DSPMGR -a"Analog:Digital"
    $DSPMGR -p"Digital Vol" -l"Digital" -f$DSPPATH/vol_2.bin -cVol_L -mvol_l -cVol_R -mvol_r
    
    enable_input "Pcm"
    input_volume "Pcm" "pcm"

#bogus routes to "ground" pcm to analog output:
    $DSPMGR -a"fx15:Front"
else
    if [ "$INVERT_REAR" = yes ] ; then
	$DSPMGR -l"Rear L" -f$DSPPATH/inv.bin
	$DSPMGR -l"Rear R" -f$DSPPATH/inv.bin
    fi
    if [ "$ANALOG_FRONT_BOOST" = yes ] ; then
	$CONFIG -B on
    else
	$CONFIG -B off
    fi
    $DSPMGR -a"Pcm:Front"

# with older driver, pcm:front volume is handle by the ac97 chip
    if [ "$DRIVER_VERSION" = 0 ]; then
	$DSPMGR -v"Pcm L:Rear L" -mpcm_l
	$DSPMGR -v"Pcm R:Rear R" -mpcm_r
    else
	enable_input "Pcm"
	input_volume "Pcm" "pcm" 	
    fi
fi

if [ "$ENABLE_TONE_CONTROL" = yes ] ; then

    if [ "$DRIVER_VERSION" = 0 ] ; then
	TONE=tone-old.bin
    else
	TONE=tone.bin
    fi

    $DSPMGR -l"Pcm L" -f$DSPPATH/$TONE -cbass -mbass -ctreble -mtreble
#The next 3 'inherit' the oss control of the above line:
    $DSPMGR -l"Pcm R" -f$DSPPATH/$TONE 
    $DSPMGR -l"Pcm1 L" -f$DSPPATH/$TONE
    $DSPMGR -l"Pcm1 R" -f$DSPPATH/$TONE
fi


# Multichannel set-up:
#

if [ "$MULTICHANNEL" = yes ] ; then

    # 5.1 main routes
    $DSPMGR -a"fx8-9:$FRONT" -a"fx10-11:Rear" -a"fx12:$CENTER" -a"fx13:$LFE"

    # Subwoofer += low frequencies from other channels
    if [ "$ROUTE_ALL_TO_SUB" = yes ] ; then
	$DSPMGR -a"fx8-9:$LFE" -a"fx10-11:$LFE" -a"fx12:$LFE" 
    fi

    GAIN=$DSPPATH/gain_6.bin

    # Use the full dynamic range of all inputs
    $DSPMGR -l"fx8" -l"fx9" -l"fx10" -l"fx11" -l"fx12" -l"fx13" -f$GAIN
fi


## Surround Sound Setup
if [ "$SURROUND" = yes ] ; then
    if [ "$CARD_IS_5_1" = no ] ; then
	emu-dspmgr -l"Front L" -l"Front R" -l"Analog Center" -f$DSPPATH/c2f.bin
    fi
    $DSPMGR -l"Pcm L" -l"Pcm R" -l"Fx10" -l"Fx11" -l"Fx12" -f$DSPPATH/surround.bin
    $DSPMGR -r"Analog:Rear" -r"Pcm:Rear"
elif [ "$PROLOGIC" = yes ] ; then
    if [ "$CARD_IS_5_1" = no ] ; then
	emu-dspmgr -l"Front L" -l"Front R" -l"Analog Center" -f$DSPPATH/c2f.bin
    fi
    $DSPMGR -l"Pcm L" -l"Pcm R" -l"Fx10" -l"Fx11" -l"Fx12" -f$DSPPATH/prologic.bin
    $DSPMGR -r"Analog:Rear" -r"Pcm:Rear"
fi


# Need to toggle third output on 5.1 cards

if [ "$CARD_IS_5_1" = yes ] ; then
    if [ "$USE_DIGITAL_OUTPUT" = yes ] ; then
	$CONFIG -d
    else
	$CONFIG -a
    fi
fi

# See if we should enable IR

if [ "$ENABLE_LIVEDRIVE_IR" = yes ] ; then
     $CONFIG -i
fi

# Restart the FX8010
$DSPMGR -y

}

case "$1" in

	restore | restart)
                load
		# restore mixer settings
		/usr/bin/umix -l >/dev/null 2>&1
                ;;
        store | save | stop)
		# save mixer settings
		/usr/bin/umix -s >/dev/null 2>&1
		;;
        *)
		load
esac

--Boundary-00=_dOWn+a3bW6Hm4kg--

