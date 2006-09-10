Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWIJNA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWIJNA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWIJNA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:00:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:31140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932116AbWIJNAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:00:25 -0400
X-Authenticated: #20559227
Date: Sun, 10 Sep 2006 15:00:31 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/2] ieee1394: ohci1394: endianess bug in verbose debug log
Message-ID: <20060910130031.GA2492@localhost>
References: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.e9e9aee005df0fb6@s5r6.in-berlin.de>
X-Spoken-Languages: en, de
X-URL: http://www.wolfgangpfeiffer.com
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan, Hi All

Success, on the PowerBook5,8, Stefan. ... :) At least it looks so to me ...

And this:
Sorry for the delay: I had to leave the house yesterday for work --
with no access to computers in that time. And yes, I had a few fights
with 'make' that also took some time ... :) 


On Fri, Sep 08, 2006 at 01:55:24AM +0200, Stefan Richter wrote:
> This fixes a debug macro on some big endian machines.  Related code is
> touched up too to make it harder to introduce such bugs in the future.
> 
>  - ieee1394: ohci1394: fix endianess bug in debug message
>  - ieee1394: ohci1394: more obvious endianess handling
> 
> Wolfgang, could you test and send an ACK?  The tlabel in each "Packet
> received from node" message should match that of the previous "Packet
> sent to node" line.  Example of a wrong log:
> http://www.wolfgangpfeiffer.com/disable-irm.kern.log.when.fw.disk.is.switched.on.txt

Seems with your patched ohci1394.ko tlabels from sent/received don't
differ anymore. Here's a fresh log with the patched and recompiled
ohci1394: 
http://wolfgangpfeiffer.com/kern.log.06-09-10.when.fw.disk.is.switched.on.txt

I repeated the test a few times. And I always saw the same results as
to the identical tlabels. So log above is just one of a few I did the
last minutes. 

Ugly notes, for later reference:
-----------------------------
$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld
-----------------------


The script I used (IIRC with the syntax shamelessly lifted from various
files in my local /etc/ :)

------------------------------------
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.060910.sh; \
/home/shorty/scripts/scsi.stop.sh; \
/home/shorty/scripts/scsi.start.sh; \

sleep 2; \
/home/shorty/kernel-factory/git.make.test/git.060822/linux-2.6/scripts/ver_linux; \

cat /dev/null > /var/log/kern.log; \
echo "===> NOW SWITCH ON THE FW DISK <===="; \
sleep 70; \
ls /dev/sda*; \

if [ -f   /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt ]; then
    rm -f /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    cp /var/log/kern.log /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    chown shorty.shorty /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
else
    cp /var/log/kern.log /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    chown shorty.shorty  /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
fi


--------------------------------------




And this should be the latest output from the script above, slightly
reformatted (line wrappings, etc.) for better readability:

--------------------------------------------------------
# /home/shorty/scripts/ieee.test.060910.sh
+ /bin/sh -nv /home/shorty/scripts/ieee.test.060910.sh
#!/bin/sh -x
/bin/sh -nv /home/shorty/scripts/ieee.test.060910.sh; \
/home/shorty/scripts/scsi.stop.sh; \
/home/shorty/scripts/scsi.start.sh; \

sleep 2; \
/home/shorty/kernel-factory/git.make.test/git.060822/linux-2.6/scripts/ver_linux; \

cat /dev/null > /var/log/kern.log; \
echo "===> NOW SWITCH ON THE FW DISK <===="; \
sleep 70; \
ls /dev/sda*; \

if [ -f   /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt ]; then
    rm -f /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    cp /var/log/kern.log /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    chown shorty.shorty /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
else
    cp /var/log/kern.log /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
    chown shorty.shorty  /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
fi

+ /home/shorty/scripts/scsi.stop.sh
+ /bin/sh -n /home/shorty/scripts/scsi.stop.sh
+ rmmod raw1394
+ rmmod eth1394
+ rmmod ohci1394
+ rmmod sbp2
+ rmmod ieee1394
+ /home/shorty/scripts/scsi.start.sh
+ /bin/sh -n /home/shorty/scripts/scsi.start.sh
+ modprobe ieee1394 disable_irm=0
+ sleep 2
+ modprobe ohci1394
+ sleep 2
+ modprobe sbp2
+ sleep 2
+ modprobe raw1394
+ sleep 2
+ chown root.shorty /dev/raw1394
+ sleep 2
+ /home/shorty/kernel-factory/git.make.test/git.060822/linux-2.6/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debby1-6 2.6.18-rc4-ieeeverbose-gef7d1b24-dirty #1 Tue Aug 22
22:18:50 CEST 2006 ppc GNU/Linux
 


Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
pcmcia-cs              3.2.8
PPP                    2.4.4
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   100


Modules Loaded raw1394 sbp2 eth1394 ohci1394 ieee1394 bluetooth radeon
drm ipv6 xt_multiport iptable_nat ip_nat xt_state ip_conntrack
xt_tcpudp iptable_filter ip_tables x_tables therm_adt746x sr_m od
cpufreq_powersave cpufreq_performance scsi_mod apm_emu joydev
appletouch snd_aoa_codec_onyx snd_aoa_fabric_layout snd_aoa usbhid
pcmcia firmware_class snd_aoa_i2sbus snd_pcm_oss snd_pcm
snd_page_alloc snd_mixer_oss snd_seq_dummy snd_seq_oss snd_seq_midi
snd_rawmidi snd_seq_midi_event ide_cd cdrom snd_seq snd_timer
snd_seq_device yenta_socket rsrc_nonstatic pcmcia_core snd ohci_hcd
sungem sungem_phy evd ev ehci_hcd soundcore snd_aoa_soundbus
i2c_powermac uninorth_agp agpgart pmac_zilog serial_core usbcore


+ cat /dev/null
+ echo '===> NOW SWITCH ON THE FW DISK <===='
===> NOW SWITCH ON THE FW DISK <====
+ sleep 70
+ ls '/dev/sda*'
ls: /dev/sda*: No such file or directory
+ '[' -f /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt ']'
+ rm -f /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
+ cp /var/log/kern.log /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
+ chown shorty.shorty /home/shorty/kern.log.06-09-10.when.fw.disk.is.switched.on.txt
------------------------------------------------



> The received tlabel was always 48 on this Apple AluBook 5,8.

Thanks Stefan for your work. Please let me know if I can help any more
with tests.

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
