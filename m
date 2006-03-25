Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWCYLrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCYLrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWCYLrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:47:25 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:51917 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750761AbWCYLrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:47:24 -0500
Message-ID: <44252DC8.1060608@aei.ca>
Date: Sat, 25 Mar 2006 06:47:20 -0500
From: phantom <thephantom@aei.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tmpfs bug? Out of memory when not
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I do not know where to send this... as I am not sure what part of the 
kernel is involved... memory handling, swap, tmpfs, or something else...

I used to have no problem, but at around 2.6.9 or so I started to get 
some problems...

I use tmpfs for /tmp
/tmp on /tmp type tmpfs (rw,size=5G,nr_inodes=1M)

of course, I store the downloaded files from firefox there, so I end up 
with 100+ megs files...  I also do all the compilations there...

I have 1 gig ram and ~5 gig swap...

here is the problem: the kernel prefer to swap everything than to free 
the 500+ megs of cached data!! That would be "ok"  but from time to time 
it decide to simply kill something instead... but hey... I have 500 megs 
"free" that the kernel only need to release! Worse, I can't reproduce it 
at will... so it's totally random...

I agree that I have lots of stuff running:
apache2, apcupsd, cupsd, ddclient, dhcp, gpm, named, nfs, ntpd, oidentd, 
samba, sendmain, squid, sysklogd, vixie-cron, webmin
xorg, xchat, licq, amsn, gaim, firefox, xmms

that is the normal stuff... which take like 300-350 megs of ram iirc (I 
don't feel like rebooting to confirm the exact number, but less than 
400M...)

that run usually ok, except on rare occasion (happened 2 times I think 
in a few months)

the problem is when I start something else... then it's sure that in 2 
weeks I will have an OOM...  the extra is: any of: vmware (300M), 
azureus, amule, xmule, azureus, emerge, java applet sometime also 
trigger it...

it seems to happend when I have some big file in tmpfs... as if the 
kernel refuse to swap them

it also happend after a while... like 2 weeks... atleast that's when I 
notice it the most... but I can't say really... as I never reboot unless 
I update the kernel... so it may be earlier too...

what I noticed is: buffer + cache is always 500+ megs, when it go lower 
the kernel find something to swap and free some for the cache...

I just emptied about 200M from /tmp (remember, tmpfs)...  the cached is 
going back up...

as I said, I couln't reproduce it with very little knowledge of memory 
debugging... but I am ready to do anything...

as a side note, someone else in #gentoo undernet reported instability 
with tmpfs, he used to have /tmp in tmpfs too... he removed it and no 
more problems... this is what I think I will do, as I'm tired of the OOM...

I have inclued everything I could...

NOTE: the last OOM-killer invocation was like 2 days ago
I had the usual and started an emerge sync, firefox got killed...

---------------------
currently running:
apache2, apcupsd, cupsd, ddclient, dhcp, gpm, named, nfs, ntpd, oidentd, 
samba, sendmain, squid, sysklogd, vixie-cron, webmin
xorg, xchat, licq, amsn, gaim, firefox, xmms, eagle, vmware

kernel: vanilla 2.6.15.4

distro: Gentoo

my system:
Athlon Barton 2800+
2x512 ram
A7N8X deluxe board (so nforce2 chipset)
- ethernet nvnet
- ethernet 3c59x
- audio intel-8x0 (alsa)
- firewire (no module loaded)
- usb2
- disabled sata (jumper)
ethernet Linksys Gigabit Network Adapter (rev 12)
Promise fasttrack, as plain ide controller
Adaptec AIC-7892A U160/m
Radeon 9000pro (agp)

modules loaded:
Module                  Size  Used by
snd_mpu401              6792  1
ipt_REDIRECT            2304  0
snd_seq_midi            8608  0
snd_mpu401_uart         7424  1 snd_mpu401
snd_rawmidi            24160  2 snd_seq_midi,snd_mpu401_uart
snd_pcm_oss            47904  0
snd_mixer_oss          16960  1 snd_pcm_oss
snd_seq_oss            32640  0
snd_seq_midi_event      6976  2 snd_seq_midi,snd_seq_oss
snd_seq                48848  5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_seq_device          8588  4 snd_seq_midi,snd_rawmidi,snd_seq_oss,snd_seq
snd_intel8x0           30684  6
snd_ac97_codec         84128  1 snd_intel8x0
snd_ac97_bus            2304  1 snd_ac97_codec
snd_pcm                81544  4 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              23300  3 snd_seq,snd_pcm
snd                    53604  24 
snd_mpu401,snd_mpu401_uart,snd_rawmidi,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9760  1 snd
snd_page_alloc         10504  2 snd_intel8x0,snd_pcm
smbfs                  61112  0
fglrx                 447500  7
vmnet                  36132  5
vmmon                 104172  6
police                 10272  1
cls_u32                 8132  1
sch_ingress             3584  1
ipt_length              1856  1
ipt_tos                 1792  1
ipt_CLASSIFY            2304  14
sch_sfq                 5504  6
sch_cbq                16064  1
ipt_REJECT              5120  10
ipt_MASQUERADE          3456  1
ipt_state               2048  4
iptable_mangle          2880  1
iptable_filter          3072  1
ip_nat_ftp              3328  0
ip_conntrack_ftp        7408  1 ip_nat_ftp
iptable_nat             7620  1
ip_nat                 18028  4 
ipt_REDIRECT,ipt_MASQUERADE,ip_nat_ftp,iptable_nat
ip_conntrack_irc        6832  0
ip_conntrack           47244  7 
ipt_MASQUERADE,ipt_state,ip_nat_ftp,ip_conntrack_ftp,iptable_nat,ip_nat,ip_conntrack_irc
ip_tables              20224  10 
ipt_REDIRECT,ipt_length,ipt_tos,ipt_CLASSIFY,ipt_REJECT,ipt_MASQUERADE,ipt_state,iptable_mangle,iptable_filter,iptable_nat
eeprom                  6992  0
w83l785ts               6928  0
asb100                 20116  0
hwmon_vid               2624  1 asb100
i2c_nforce2             6400  0
i2c_dev                 9472  0
i2c_core               20432  5 eeprom,w83l785ts,asb100,i2c_nforce2,i2c_dev
lp                     11012  0
parport_pc             33348  1
parport                34696  2 lp,parport_pc
nvidia_agp              7644  1
agpgart                33224  2 fglrx,nvidia_agp
raid5                  23168  3
xor                    14472  1 raid5
raid1                  19008  1
3c59x                  41384  0
mii                     5312  1 3c59x
forcedeth              21572  0
skge                   35216  0
crc32                   4352  1 skge
usb_storage            33796  1
usblp                  12160  0


output of free:
              total       used       free     shared    buffers    cached
Mem:       1035644    1013820      21824          0      35592    464328
-/+ buffers/cache:     513900     521744
Swap:      4827492     588164    4239328


output of ps aux:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   1464   444 ?        S    Feb26   0:01 init [3]
root         2  0.0  0.0      0     0 ?        SN   Feb26   5:54 
[ksoftirqd/0]
root         3  0.0  0.0      0     0 ?        S<   Feb26   0:13 [events/0]
root         4  0.0  0.0      0     0 ?        S<   Feb26   0:00 [khelper]
root         5  0.0  0.0      0     0 ?        S<   Feb26   0:00 [kthread]
root         7  0.0  0.0      0     0 ?        S<   Feb26   0:02 [kblockd/0]
root         8  0.0  0.0      0     0 ?        S<   Feb26   0:00 [kacpid]
root       130  0.0  0.0      0     0 ?        S<   Feb26   0:00 [khubd]
root       178  0.0  0.0      0     0 ?        S    Feb26   0:11 [pdflush]
root       179  0.0  0.0      0     0 ?        S    Feb26   0:17 [pdflush]
root       181  0.0  0.0      0     0 ?        S<   Feb26   0:00 [aio/0]
root       765  0.0  0.0      0     0 ?        S<   Feb26   0:00 [kseriod]
root       180  0.0  0.0      0     0 ?        S    Feb26   1:15 [kswapd0]
root       868  0.0  0.0      0     0 ?        S<   Feb26   0:00 [scsi_eh_0]
root       961  0.0  0.0      0     0 ?        S    Feb26   0:16 [kjournald]
root      1235  0.0  0.0   1696   288 ?        S<s  Feb26   0:00 
/sbin/udevd --daemon
root      6771  0.0  0.0      0     0 ?        S<   Feb26   0:00 [md0_raid1]
root      6775  0.0  0.0      0     0 ?        S<   Feb26   0:00 [md1_raid5]
root      6779  0.0  0.0      0     0 ?        S<   Feb26   2:10 [md2_raid5]
root      6780  0.0  0.0      0     0 ?        S<   Feb26   1:07 [md3_raid5]
root      6807  0.0  0.0      0     0 ?        S    Feb26   0:07 [kjournald]
root      6808  0.0  0.0      0     0 ?        S<   Feb26   0:00 
[reiserfs/0]
root      6809  0.0  0.0      0     0 ?        S    Feb26   0:00 [kjournald]
root      6810  0.0  0.0      0     0 ?        S    Feb26   0:00 [kjournald]
root      6811  0.0  0.0      0     0 ?        S    Feb26   0:35 [kjournald]
root      6812  0.0  0.0      0     0 ?        S    Feb26   0:40 [kjournald]
root      7839  0.0  0.0   1500   588 ?        Ss   Feb26   0:00 
/usr/sbin/syslogd -m 0
root      7850  0.0  0.0   1464   216 ?        Ss   Feb26   0:00 
/usr/sbin/klogd -c 3 -2
root      9043  0.0  0.1  19532  1744 ?        Ss   Feb26   0:05 
/usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htapache    9044  0.0  0.0  18928   724 
?        S    Feb26   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D 
USERDIR -d /usr/lib/apache2 -f /etc/apache2/htroot      9085  0.0  0.0 
  1576   356 ?        Ss   Feb26   0:00 apcmain
apache    9182  0.0  0.1  19668  1528 ?        S    Feb26   0:00 
/usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htapache    9183  0.0  0.1  19668  1608 
?        S    Feb26   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D 
USERDIR -d /usr/lib/apache2 -f /etc/apache2/htapache    9184  0.0  0.1 
19668  1584 ?        S    Feb26   0:00 /usr/sbin/apache2 -D 
DEFAULT_VHOST -D PHP4 -D USERDIR -d /usr/lib/apache2 -f 
/etc/apache2/htapache    9185  0.0  0.1  19668  1568 ?        S    Feb26 
   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htapache    9186  0.0  0.1  19668  1468 
?        S    Feb26   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D 
USERDIR -d /usr/lib/apache2 -f /etc/apache2/htroot      9191  0.0  0.0 
  7492   908 ?        Ss   Feb26   0:00 /usr/sbin/smbd -D
root      9193  0.0  0.0   7468   188 ?        S    Feb26   0:00 
/usr/sbin/smbd -D
root      9194  0.0  0.1   4012  1076 ?        Ss   Feb26   0:06 
/usr/sbin/nmbd -D
root      9277  0.0  0.2   6928  2128 ?        Ss   Feb26   2:06 
/usr/sbin/cupsd
root      9341  0.0  0.2   6044  2748 ?        S    Feb26   0:38 
ddclient - sleeping for 240 seconds
root      9463  0.0  0.0   1672   172 ?        Ss   Feb26   0:05 
/usr/sbin/gpm -m /dev/input/mice -t imps2
rpc       9795  0.0  0.0   1696   552 ?        Ss   Feb26   0:00 
/sbin/portmap
nobody   10211  0.0  0.0   1668   356 ?        Ss   Feb26   0:00 
/usr/sbin/oidentd -f -m -oUnix -rnoident -u nobody -g nobody
root     10301  0.0  0.0   5412   960 ?        Ss   Feb26   0:05 
sendmail: accepting connections
smmsp    10304  0.0  0.0   5396   508 ?        Ss   Feb26   0:00 
sendmail: Queue runner@00:30:00 for /var/spool/clientmqueue
root     10438  0.0  0.0   1456   364 ?        Ss   Feb26   0:00 
/usr/sbin/uptimed
root     10487  0.0  0.0   1712   568 ?        Ss   Feb26   0:00 
/usr/sbin/cron
root     10538  0.0  0.1   6428  1328 ?        Ss   Feb26   0:02 
/usr/bin/perl /usr/libexec/webmin/miniserv.pl /etc/webmin/miniserv.conf
root     11267  0.0  0.0   2168   688 ?        Ss   Feb26   0:00 login 
-- phantom
root     11268  0.0  0.0   1500   488 tty2     Ss+  Feb26   0:00 
/sbin/agetty 38400 tty2 linux
root     11269  0.0  0.0   1500   488 tty3     Ss+  Feb26   0:00 
/sbin/agetty 38400 tty3 linux
root     11270  0.0  0.0   1496   488 tty4     Ss+  Feb26   0:00 
/sbin/agetty 38400 tty4 linux
root     11271  0.0  0.0   1496   488 tty5     Ss+  Feb26   0:00 
/sbin/agetty 38400 tty5 linux
root     11272  0.0  0.0   1496   488 tty6     Ss+  Feb26   0:00 
/sbin/agetty 38400 tty6 linux
root     11382  0.0  0.0   1604   260 ?        S    Feb26   0:00 apcnis
root     11383  0.0  0.0   1576   388 ?        S    Feb26   0:00 apcdev
phantom  11384  0.0  0.1   2684  1048 tty1     Ss   Feb26   0:00 -bash
phantom  11413  0.0  0.0   3008   340 ?        Ss   Feb26   0:00 ssh-agent
phantom  11513  0.0  0.0   1972   220 ?        Ss   Feb26   0:00 
dbus-daemon --fork --print-pid 8 --print-address 6 --session
root     19670  0.0  0.0   1304   100 ?        S    Feb26   0:00 
/opt/vmware/workstation/bin/vmnet-bridge -d /var/run/vmnet-bridge-0.pid 
/dev/vmnet0 eth1
phantom  19711  0.0  0.0   2224   812 tty1     S+   Feb26   0:00 /bin/sh 
/usr/bin/startx
phantom  19722  0.0  0.0   2284   532 tty1     S+   Feb26   0:00 xinit 
/etc/X11/xinit/xinitrc -- -nolisten tcp -br -deferglyphs 16
root     19723  2.4 14.4 241228 149836 ?       RL   Feb26 942:33 X :0 
-nolisten tcp -br -deferglyphs 16
phantom  19739  0.0  0.3  17168  3868 tty1     S    Feb26   0:41 
/usr/bin/gnome-session
phantom  19764  0.0  0.0   1968   220 ?        Ss   Feb26   0:00 
dbus-daemon --fork --print-pid 8 --print-address 6 --session
phantom  19767  0.0  0.2  11364  2668 tty1     S    Feb26   0:04 
/usr/libexec/gconfd-2 5
phantom  19795  0.0  0.0   2296   516 tty1     S    Feb26   0:00 
/usr/bin/gnome-keyring-daemon
phantom  19802  0.0  0.1   6004  1484 ?        Ss   Feb26   0:00 
/usr/libexec/bonobo-activation-server --ac-activate --ior-output-fd=17
phantom  19821  0.1  0.8  38312  8984 ?        Ss   Feb26  50:18 
metacity --sm-save-file 1137520419-29913-960630515.ms
phantom  19824  0.0  0.7  28544  8036 ?        S    Feb26   5:46 
/usr/libexec/gnome-settings-daemon 
--oaf-activate-iid=OAFIID:GNOME_SettingsDaemon --oaf-ior-phantom  19826 
  0.0  0.3  17784  3496 ?        S    Feb26   0:33 
/usr/libexec/vino-server 
--oaf-activate-iid=OAFIID:GNOME_RemoteDesktopServer 
--oaf-ior-fd=26phantom  19829  0.0  0.7  28544  8036 ?        S    Feb26 
   0:00 /usr/libexec/gnome-settings-daemon 
--oaf-activate-iid=OAFIID:GNOME_SettingsDaemon --oaf-ior-phantom  19830 
  0.0  0.7  28544  8036 ?        S    Feb26   0:00 
/usr/libexec/gnome-settings-daemon 
--oaf-activate-iid=OAFIID:GNOME_SettingsDaemon --oaf-ior-phantom  19833 
  0.0  1.1  37080 12248 ?        Ss   Feb26   5:04 gnome-panel 
--sm-config-prefix /gnome-panel-UWUMG6/ --sm-client-id 
11c0a80101000111825642100phantom  19835  0.0  0.8  43872  8632 ? 
Ss   Feb26   1:39 nautilus --sm-config-prefix /nautilus-ymlXJy/ 
--sm-client-id 11c0a80101000113747280500000298phantom  19842  0.0  0.8 
43872  8632 ?        S    Feb26   0:00 nautilus --sm-config-prefix 
/nautilus-ymlXJy/ --sm-client-id 11c0a80101000113747280500000298phantom 
  19853  0.0  0.8  43872  8632 ?        S    Feb26   0:00 nautilus 
--sm-config-prefix /nautilus-ymlXJy/ --sm-client-id 
11c0a80101000113747280500000298phantom  19855  0.0  0.2   8880  2376 ? 
       S    Feb26   0:02 /usr/libexec/gnome-vfs-daemon 
--oaf-activate-iid=OAFIID:GNOME_VFS_Daemon_Factory --oaf-ior-fphantom 
19858  0.0  0.2   8880  2376 ?        S    Feb26   0:00 
/usr/libexec/gnome-vfs-daemon 
--oaf-activate-iid=OAFIID:GNOME_VFS_Daemon_Factory --oaf-ior-fphantom 
19859  0.0  0.2   8880  2376 ?        S    Feb26   0:00 
/usr/libexec/gnome-vfs-daemon 
--oaf-activate-iid=OAFIID:GNOME_VFS_Daemon_Factory --oaf-ior-fphantom 
19860  0.0  0.8  43872  8632 ?        S    Feb26   0:00 nautilus 
--sm-config-prefix /nautilus-ymlXJy/ --sm-client-id 
11c0a80101000113747280500000298phantom  19861  0.0  0.8  43872  8632 ? 
       S    Feb26   0:00 nautilus --sm-config-prefix /nautilus-ymlXJy/ 
--sm-client-id 11c0a80101000113747280500000298phantom  19862  0.0  0.8 
43872  8632 ?        S    Feb26   0:00 nautilus --sm-config-prefix 
/nautilus-ymlXJy/ --sm-client-id 11c0a80101000113747280500000298phantom 
  19863  0.0  0.8  43872  8632 ?        S    Feb26   0:00 nautilus 
--sm-config-prefix /nautilus-ymlXJy/ --sm-client-id 
11c0a80101000113747280500000298phantom  19864  0.0  0.8  43872  8632 ? 
       S    Feb26   0:00 nautilus --sm-config-prefix /nautilus-ymlXJy/ 
--sm-client-id 11c0a80101000113747280500000298phantom  19865  0.0  0.8 
43872  8632 ?        S    Feb26   0:00 nautilus --sm-config-prefix 
/nautilus-ymlXJy/ --sm-client-id 11c0a80101000113747280500000298phantom 
  19866  0.0  0.8  43872  8632 ?        S    Feb26   0:00 nautilus 
--sm-config-prefix /nautilus-ymlXJy/ --sm-client-id 
11c0a80101000113747280500000298phantom  19867  0.0  0.8  43872  8632 ? 
       S    Feb26   0:00 nautilus --sm-config-prefix /nautilus-ymlXJy/ 
--sm-client-id 11c0a80101000113747280500000298phantom  19868  0.0  0.8 
43872  8632 ?        S    Feb26   0:00 nautilus --sm-config-prefix 
/nautilus-ymlXJy/ --sm-client-id 11c0a80101000113747280500000298phantom 
  19869  0.0  0.8  43872  8632 ?        S    Feb26   0:00 nautilus 
--sm-config-prefix /nautilus-ymlXJy/ --sm-client-id 
11c0a80101000113747280500000298phantom  19894  0.1  1.5  88404 15744 ? 
       S    Feb26  41:13 /usr/libexec/wnck-applet 
--oaf-activate-iid=OAFIID:GNOME_Wncklet_Factory --oaf-ior-fd=37
phantom  19896  0.0  0.6 483024  6780 ?        S    Feb26   0:50 
/usr/libexec/drivemount_applet2 
--oaf-activate-iid=OAFIID:GNOME_DriveMountApplet_Factory --ophantom 
19897  0.0  0.6 483024  6780 ?        S    Feb26   0:00 
/usr/libexec/drivemount_applet2 
--oaf-activate-iid=OAFIID:GNOME_DriveMountApplet_Factory --ophantom 
19898  0.0  0.6 483024  6780 ?        S    Feb26   0:00 
/usr/libexec/drivemount_applet2 
--oaf-activate-iid=OAFIID:GNOME_DriveMountApplet_Factory --ophantom 
19905  0.0  0.4  18484  4952 ?        S    Feb26   0:34 
/usr/libexec/notification-area-applet 
--oaf-activate-iid=OAFIID:GNOME_NotificationAreaAppletphantom  19907 
0.0  0.6  32824  7088 ?        S    Feb26   3:49 
/usr/libexec/gnome-netstatus-applet 
--oaf-activate-iid=OAFIID:GNOME_NetstatusApplet_Factory
phantom  19909  0.0  0.6  35656  6348 ?        S    Feb26   8:33 
/usr/libexec/clock-applet 
--oaf-activate-iid=OAFIID:GNOME_ClockApplet_Factory 
--oaf-ior-fd=4phantom  19917  0.0  0.7  40264  7556 ?        S    Feb26 
   0:48 /usr/libexec/gweather-applet-2 
--oaf-activate-iid=OAFIID:GNOME_GWeatherApplet_Factory --oaf-phantom 
19919  0.0  0.5  22472  5864 ?        S    Feb26   2:09 
/usr/libexec/multiload-applet-2 
--oaf-activate-iid=OAFIID:GNOME_MultiLoadApplet_Factory --oaphantom 
19939  0.0  0.7  40264  7556 ?        S    Feb26   0:00 
/usr/libexec/gweather-applet-2 
--oaf-activate-iid=OAFIID:GNOME_GWeatherApplet_Factory --oaf-phantom 
19940  0.0  0.7  40264  7556 ?        S    Feb26   0:01 
/usr/libexec/gweather-applet-2 
--oaf-activate-iid=OAFIID:GNOME_GWeatherApplet_Factory --oaf-phantom 
19972  0.0  0.7  40264  7556 ?        S    Feb26   0:00 
/usr/libexec/gweather-applet-2 
--oaf-activate-iid=OAFIID:GNOME_GWeatherApplet_Factory --oaf-phantom 
20098  0.0  1.0  74264 10820 ?        S    Feb26   0:00 licq
phantom  20099  0.0  1.0  74264 10820 ?        S    Feb26   0:01 licq
phantom  20100  0.0  1.0  74264 10820 ?        S    Feb26   0:56 licq
phantom  20101  0.0  1.0  74264 10820 ?        S    Feb26   0:00 licq
phantom  20102  0.0  1.0  74264 10820 ?        S    Feb26   0:00 licq
phantom  20103  0.0  1.0  74264 10820 ?        S    Feb26   4:39 licq
apache   20127  0.0  0.1  19668  1456 ?        S    Feb26   0:00 
/usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htntp      20508  0.0  0.3   3840  3836 
?        SLs  Feb26   0:04 /usr/sbin/ntpd -p /var/run/ntpd.pid -u ntp:ntp
apache   21379  0.0  0.1  19668  1708 ?        S    Feb26   0:00 
/usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htapache   25922  0.0  0.1  19668  1460 
?        S    Feb28   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D 
USERDIR -d /usr/lib/apache2 -f /etc/apache2/htphantom  15260  0.0  0.6 
35460  6944 ?        S    Mar02   1:05 /usr/libexec/mixer_applet2 
--oaf-activate-iid=OAFIID:GNOME_MixerApplet_Factory --oaf-ior-fd=apache 
   19671  0.0  0.1  19668  1484 ?        S    Mar03   0:00 
/usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D USERDIR -d 
/usr/lib/apache2 -f /etc/apache2/htapache   20478  0.0  0.1  19668  1448 
?        S    Mar03   0:00 /usr/sbin/apache2 -D DEFAULT_VHOST -D PHP4 -D 
USERDIR -d /usr/lib/apache2 -f /etc/apache2/htroot      4177  0.0  0.0 
  6016   544 ?        Ss   Mar04   0:00 /usr/sbin/squid -DYC
squid     4179  0.0  1.2  18224 12676 ?        S    Mar04   0:33 (squid) 
-DYC
squid     4181  0.0  0.0   1300   224 ?        Ss   Mar04   0:00 (unlinkd)
phantom   4237  0.0  2.6  75100 27816 ?        R    Mar04  13:55 
gnome-terminal
phantom   4238  0.0  0.0   2212   540 ?        S    Mar04   0:00 
gnome-pty-helper
phantom   4239  0.0  0.1   3340  1128 pts/1    Ss   Mar04   0:00 bash
phantom   4240  0.0  2.6  75100 27816 ?        S    Mar04   0:00 
gnome-terminal
phantom   4241  0.0  2.6  75100 27816 ?        S    Mar04   0:00 
gnome-terminal
nobody    4656  0.0  0.0   1592   556 ?        Ss   Mar04   0:00 
/sbin/rpc.statd
root      4664  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4662  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4663  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4665  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4666  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4667  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4668  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4669  0.0  0.0      0     0 ?        S    Mar04   0:00 [nfsd]
root      4671  0.0  0.0      0     0 ?        S    Mar04   0:00 [lockd]
root      4672  0.0  0.0      0     0 ?        S<   Mar04   0:00 [rpciod/0]
root      4673  0.0  0.0   1740   552 ?        Ss   Mar04   0:00 
/usr/sbin/rpc.mountd
phantom   4951  0.0  0.1   3344  1144 pts/2    Ss   Mar04   0:01 bash
phantom   5423  0.0  3.0 147816 31112 ?        S    Mar04  12:03 wish 
/usr/bin/amsn
root      6316  0.0  0.0   3064   468 ?        S    Mar05   0:00 popper
phantom   9432  0.0  0.8  63320  9016 ?        SL   Mar05  27:21 xmms
phantom   9433  0.0  0.8  63320  9016 ?        SL   Mar05   0:00 xmms
phantom   9434  0.0  0.8  63320  9016 ?        SL   Mar05   5:32 xmms
phantom   9435  0.0  0.8  63320  9016 ?        SL   Mar05   0:00 xmms
phantom   9436  0.0  0.8  63320  9016 ?        SL   Mar05   0:00 xmms
named    11149  0.0  0.3   9176  3928 ?        Ss   Mar05   0:06 
/usr/sbin/named -u named -n 1
phantom  16267  0.2  1.9  69236 19816 ?        S    Mar06  74:05 xchat-2
phantom  23367  0.0  0.1   3344  1140 pts/5    Ss+  Mar06   0:00 bash
phantom  23562  0.0  1.9  69236 19816 ?        S    Mar06   0:00 xchat-2
phantom  23563  0.0  1.9  69236 19816 ?        S    Mar06   0:00 xchat-2
phantom  23564  0.0  1.9  69236 19816 ?        S    Mar06   0:00 xchat-2
dhcp     29648  0.0  0.0   2780   904 ?        Ss   Mar07   0:01 
/usr/sbin/dhcpd -q -pf /var/run/dhcp/dhcp.pid -user dhcp -group dhcp -q 
eth0 eth1
phantom  30599  0.0  0.1   3420  1476 pts/6    Ss+  Mar07   0:00 bash
phantom  28068  0.0  0.1   3340  1144 pts/9    Ss   Mar08   0:00 bash
root     31084  0.0  0.0      0     0 ?        S<   Mar09   0:00 [scsi_eh_3]
root     31085  0.0  0.0      0     0 ?        S<   Mar09   0:00 
[usb-storage]
phantom  24213  0.0  0.1   3344  1128 pts/10   Ss   Mar09   0:00 bash
root     27071  0.0  0.0      0     0 ?        Z    Mar16   0:00 
[apcupsd] <defunct>
root     13493  0.0  0.0   2184   708 pts/9    S    Mar18   0:00 su
root     13496  0.0  0.1   2428  1112 pts/9    S+   Mar18   0:00 bash
phantom  14406  0.0  0.1   3344  1200 pts/3    Ss+  Mar19   0:00 bash
root     20336  0.0  0.0   2180   708 pts/10   S    Mar19   0:00 su -
root     20339  0.0  0.1   2560  1228 pts/10   S+   Mar19   0:00 -su
phantom  30854  0.0  0.1   3476  1248 pts/4    Ss+  Mar20   0:00 bash
root      2945  0.0  0.0   2180   708 pts/1    S    Mar20   0:00 su -
root      2948  0.0  0.1   2432  1336 pts/1    S    Mar20   0:00 -su
root      3238  0.0  0.0   2228   824 pts/1    S    Mar20   0:00 /bin/sh 
/usr/sbin/pppoe-connect /dev/fd/63
phantom   4957  0.0  0.1   3340  1304 pts/7    Ss+  Mar21   0:00 bash
phantom   9793  0.0  0.1   3432  1580 pts/8    Ss+  Mar22   0:00 bash
phantom  11165  0.0  0.6  32160  6684 ?        S    Mar22   1:13 gaim
phantom  19727  0.0  0.0   7044   772 pts/2    S+   Mar23   0:00 vim main.c
root     28477  0.0  0.0   2452   704 ?        Ss   Mar23   0:00 
/usr/sbin/pppd pty /usr/sbin/pppoe -p /var/run/-adsl.pid.pppoe -I eth2 
-T 80 -U  -m 1412
nobody   28478  0.0  0.0   1660   556 ?        S    Mar23   1:33 
/usr/sbin/pppoe -p /var/run/-adsl.pid.pppoe -I eth2 -T 80 -U -m 1412
phantom  23594  0.0  0.1   3344  1200 pts/12   Ss+  Mar24   0:00 bash
phantom  28680  0.0  0.1   4080  1420 ?        S    01:13   0:00 
/bin/bash /usr/libexec/mozilla-launcher
phantom  28689  5.3 12.0 195676 125048 ?       S    01:13  17:22 
/usr/lib/mozilla-firefox/firefox-bin
phantom  28700  0.0 12.0 195676 125048 ?       S    01:13   0:00 
/usr/lib/mozilla-firefox/firefox-bin
phantom  28701  0.0 12.0 195676 125048 ?       S    01:13   0:06 
/usr/lib/mozilla-firefox/firefox-bin
phantom  28702  0.0 12.0 195676 125048 ?       S    01:13   0:06 
/usr/lib/mozilla-firefox/firefox-bin
phantom  29588  0.0 12.0 195676 125048 ?       S    02:07   0:00 
/usr/lib/mozilla-firefox/firefox-bin
phantom  29595  0.0  1.3  20472 14132 ?        S    02:07   0:08 xpdf 
/tmp/ClassD2.pdf
phantom  29946  0.0  0.4  26440  4680 ?        S    02:25   0:03 xpdf 
/tmp/LM4651.pdf
phantom  30093  0.0  0.0      0     0 ?        Z    02:34   0:00 
[msnaplay] <defunct>
phantom  30517  0.0 12.0 195676 125048 ?       S    02:54   0:00 
/usr/lib/mozilla-firefox/firefox-bin
phantom  30518  0.0 12.0 195676 125048 ?       S    02:54   0:00 
/usr/lib/mozilla-firefox/firefox-bin
phantom  31078  0.0 12.0 195676 125048 ?       S    03:17   0:00 
/usr/lib/mozilla-firefox/firefox-bin
phantom  31701  0.0  0.0   2220   808 ?        S    03:50   0:00 /bin/sh 
/opt/vmware/workstation/lib/lib/wrapper-gtk24.sh 
/opt/vmware/workstation/lib/lib /opphantom  31911  0.0  1.9  48376 19720 
?        S    03:50   0:06 /opt/vmware/workstation/lib/bin/vmware
phantom  31912  0.0  0.0   2220   336 ?        S    03:50   0:00 /bin/sh 
/opt/vmware/workstation/lib/lib/wrapper-gtk24.sh 
/opt/vmware/workstation/lib/lib /opphantom  32099  0.0 20.9 383772 
217424 ?       S<   03:50   0:02 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32100  0.0 20.9 
383772 217424 ?       S    03:50   0:00 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32101  0.0 20.9 
383772 217424 ?       S<   03:50   0:00 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32102  0.0 20.9 
383772 217424 ?       S<   03:50   0:00 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32103  0.0 20.9 
383772 217424 ?       S<   03:50   0:00 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32104  0.0 20.9 
383772 217424 ?       S<   03:50   0:00 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32107  0.0 20.9 
383772 217424 ?       S<   03:50   0:02 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom  32108  6.2 20.9 
383772 217424 ?       S    03:50  10:20 
/opt/vmware/workstation/lib/bin/vmware-vmx -@ 
pipe=/tmp/vmware-phantom/vmxecb1ebd42fa27e01;vphantom   1679  0.0  0.1 
  2612  1092 ?        S    06:09   0:00 /bin/bash 
/usr/libexec/mozilla-launcher
phantom   1689  2.3  3.4  61688 35756 ?        S    06:09   0:38 
/usr/lib/mozilla-thunderbird/thunderbird-bin -mail
phantom   1693  0.0  3.4  61688 35756 ?        S    06:09   0:00 
/usr/lib/mozilla-thunderbird/thunderbird-bin -mail
phantom   1694  0.0  3.4  61688 35756 ?        S    06:09   0:00 
/usr/lib/mozilla-thunderbird/thunderbird-bin -mail
phantom   1696  0.0  3.4  61688 35756 ?        S    06:09   0:00 
/usr/lib/mozilla-thunderbird/thunderbird-bin -mail
phantom   1700  0.0  0.0      0     0 ?        Z    06:09   0:00 
[netstat] <defunct>
phantom  11364  0.0  0.5  55064  5268 ?        Ss   06:32   0:00 xmms
phantom  11381  0.7  0.6  11040  6632 ?        S    06:35   0:00 eagle
phantom  11387  0.0  0.8  63320  9016 ?        SL   06:35   0:00 xmms
phantom  11389  0.2  0.8  63320  9016 ?        SL   06:35   0:00 xmms
root     11399  0.0  0.0   2092   852 pts/1    R+   06:36   0:00 ps aux

output of vmstat
procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  5  0 588160  22020  35068 456564    1    2     4    17   11    11  5 
4 90  1


Last dmesg message about the kill:
oom-killer: gfp_mask=0x280d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 0, batch 1 used:0
cpu 0 cold: low 0, high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: low 0, high 186, batch 31 used:22
cpu 0 cold: low 0, high 62, batch 15 used:40
HighMem per-cpu:
cpu 0 hot: low 0, high 42, batch 7 used:27
cpu 0 cold: low 0, high 14, batch 3 used:12
Free pages:       12060kB (116kB HighMem)
Active:226223 inactive:5651 dirty:0 writeback:100 unstable:0 free:3015 
slab:8920 mapped:231012 pagetables:1312
DMA free:4096kB min:68kB low:84kB high:100kB active:8332kB inactive:0kB 
present:16384kB pages_scanned:14136 all_unreclaimable? yes
lowmem_reserve[]: 0 0 880 1007
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 880 1007
Normal free:7848kB min:3756kB low:4692kB high:5632kB active:771464kB 
inactive:22604kB present:901120kB pages_scanned:139014 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 1023
HighMem free:116kB min:128kB low:264kB high:400kB active:125096kB 
inactive:0kB present:131008kB pages_scanned:169512 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 50*8kB 7*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
1*2048kB 0*4096kB = 4096kB
DMA32: empty
Normal: 28*4kB 49*8kB 227*16kB 4*32kB 0*64kB 0*128kB 0*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 7848kB
HighMem: 3*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 
0*1024kB 0*2048kB 0*4096kB = 116kB
Swap cache: add 1017994, delete 983933, find 427769/483347, race 0+0
Free swap  = 4246352kB
Total swap = 4827492kB
Free swap:       4246352kB
262128 pages of RAM
32752 pages of HIGHMEM
3289 reserved pages
118148 pages shared
34060 pages swap cached
0 pages dirty
17 pages writeback
230946 pages mapped
8920 pages slab
1312 pages pagetables
Out of Memory: Killed process 8631 (java_vm).
Out of Memory: Killed process 31600 (java_vm).
Out of Memory: Killed process 31601 (java_vm).
Out of Memory: Killed process 31602 (java_vm).
Out of Memory: Killed process 31603 (java_vm).
Out of Memory: Killed process 31604 (java_vm).
Out of Memory: Killed process 31605 (java_vm).
Out of Memory: Killed process 31606 (java_vm).
Out of Memory: Killed process 31607 (java_vm).
Out of Memory: Killed process 31608 (java_vm).
Out of Memory: Killed process 31610 (java_vm).
Out of Memory: Killed process 31612 (java_vm).
Out of Memory: Killed process 31613 (java_vm).
Out of Memory: Killed process 31614 (java_vm).
Out of Memory: Killed process 31617 (java_vm).
Out of Memory: Killed process 31618 (java_vm).
