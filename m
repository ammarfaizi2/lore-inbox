Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUASUpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUASUoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:44:55 -0500
Received: from defout.telus.net ([199.185.220.240]:8684 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S263173AbUASUoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:44:44 -0500
Subject: Scsi devices not found
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074545082.18958.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jan 2004 13:44:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I was able to attach two firewire devices to 2.6.1-bk2, but with
2.6.1-bk4 and 2.6.1-bk5 they cannot be found (and they really are still
attached).  gscanbus cannot find them (nor can /proc/partitions or
/proc/scsi/scsi).  gscanbus reports:

[root@localhost gscanbus-0.7.1]# ./gscanbus
Error while reading from IEEE1394: : Invalid argument
something is wrong here
Error while reading from IEEE1394: : Invalid argument
Could not read topologyMap
Error while reading from IEEE1394: : Invalid argument
Could not read topologyMap
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument
Error while reading from IEEE1394: : Invalid argument

The modules I currently have loaded are as follows, sbp2 is not among
the modules, but loading it has no effect on gscanbus (loading sbp2 and
re-running gscanbus gives the same as above):
/sbin/lsmod
Module                  Size  Used by
i2c_isa                 1920  0
vfat                   15360  0
fat                    47264  1 vfat
i2c_algo_pcf            6404  0
it87                   21256  0
i2c_sis96x              4740  0
i2c_sensor              2560  1 it87
video1394              20420  0
dv1394                 26180  0
raw1394                39908  0
snd_pcm_oss            48932  0
snd_emu10k1           109828  1
snd_rawmidi            25504  1 snd_emu10k1
snd_pcm                99236  2 snd_pcm_oss,snd_emu10k1
snd_timer              29956  1 snd_pcm
snd_seq_device          7048  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         53124  1 snd_emu10k1
snd_page_alloc          9220  2 snd_emu10k1,snd_pcm
snd_util_mem            3712  1 snd_emu10k1
snd_hwdep               7968  1 snd_emu10k1
snd_mixer_oss          17152  2 snd_pcm_oss
snd                    49636  10
snd_pcm_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep,snd_mixer_oss
sr_mod                 13732  0
sd_mod                 12576  0
imm                    12424  0
ide_scsi               14084  0
tda9887                 6532  0
tda9875                 7172  0
tda7432                 7052  0
msp3400                23972  0
tvaudio                21516  0
v4l1_compat            12932  0
tuner                  14348  0
bttv                  137836  0
video_buf              20228  1 bttv
i2c_algo_bit            8968  1 bttv
btcx_risc               4104  1 bttv
i2c_core               21512  13
i2c_isa,i2c_algo_pcf,it87,i2c_sis96x,i2c_sensor,tda9887,tda9875,tda7432,msp3400,tvaudio,tuner,bttv,i2c_algo_bit
v4l2_common             4096  1 bttv
videodev                7808  1 bttv
soundcore               8768  3 snd,bttv
ipt_ULOG                7816  0
ipt_ttl                 1664  0
ipt_TOS                 2176  0
ipt_tos                 1536  0
ipt_TCPMSS              3712  0
ipt_tcpmss              1920  0
ipt_SAME                2176  0
ipt_REDIRECT            1920  0
ipt_recent             14476  0
ipt_pkttype             1536  0
ipt_owner               5888  0
ipt_NETMAP              1920  0
ipt_multiport           1792  0
ipt_MASQUERADE          3720  0
ipt_MARK                1920  0
ipt_mark                1536  0
ipt_mac                 1792  0
ipt_LOG                 5632  0
ipt_limit               2816  0
ipt_length              1536  0
ipt_iprange             1664  0
ipt_helper              2304  0
ipt_esp                 1664  0
ipt_ECN                 2688  0
ipt_ecn                 1920  0
ipt_DSCP                2176  0
ipt_dscp                1536  0
ipt_conntrack           2176  0
ipt_CLASSIFY            1920  0
ipt_ah                  1664  0
iptable_mangle          2304  0
ip_queue                9112  0
ip_nat_tftp             2928  0
ip_nat_snmp_basic      11268  0
ip_nat_irc              4848  0
ip_nat_ftp              6128  0
ip_nat_amanda           3644  0
iptable_nat            25772  9
ipt_SAME,ipt_REDIRECT,ipt_NETMAP,ipt_MASQUERADE,ip_nat_tftp,ip_nat_snmp_basic,ip_nat_irc,ip_nat_ftp,ip_nat_amanda
ip_conntrack_tftp       2964  0
ip_conntrack_irc       71316  1 ip_nat_irc
ip_conntrack_ftp       71956  1 ip_nat_ftp
ip_conntrack_amanda    69892  1 ip_nat_amanda
arpt_mangle             2048  0
arptable_filter         1792  0
arp_tables             13824  2 arpt_mangle,arptable_filter
ipip                    9188  0
ip_gre                 10528  0
ipt_REJECT              5632  1
ipt_state               1664  5
ip_conntrack           36036  16
ipt_SAME,ipt_REDIRECT,ipt_NETMAP,ipt_MASQUERADE,ipt_helper,ipt_conntrack,ip_nat_tftp,ip_nat_irc,ip_nat_ftp,ip_nat_amanda,iptable_nat,ip_conntrack_tftp,ip_conntrack_irc,ip_conntrack_ftp,ip_conntrack_amanda,ipt_state
iptable_filter          2432  1
ip_tables              18944  35
ipt_ULOG,ipt_ttl,ipt_TOS,ipt_tos,ipt_TCPMSS,ipt_tcpmss,ipt_SAME,ipt_REDIRECT,ipt_recent,ipt_pkttype,ipt_owner,ipt_NETMAP,ipt_multiport,ipt_MASQUERADE,ipt_MARK,ipt_mark,ipt_mac,ipt_LOG,ipt_limit,ipt_length,ipt_iprange,ipt_helper,ipt_esp,ipt_ECN,ipt_ecn,ipt_DSCP,ipt_dscp,ipt_conntrack,ipt_CLASSIFY,ipt_ah,iptable_mangle,iptable_nat,ipt_REJECT,ipt_state,iptable_filter
sis900                 18052  0
ohci1394               38276  2 video1394,dv1394
ieee1394               75056  4 video1394,dv1394,raw1394,ohci1394
sg                     29848  0
scsi_mod              112440  5 sr_mod,sd_mod,imm,ide_scsi,sg
reiserfs              235376  1
ext3                  100488  1
jbd                    85528  1 ext3
agpgart                26176  0
nvidia               2078472  12

I am running Fedora Core 1.  I have added /sys and /udev (and both
appear to be working ok, but neither shows my lost drives with
2.6.1-bk5)  Both *do* show all my drives on 2.6.1-bk2.  I have grokked
google and lkml, but if I missed a change needed to get them showing up
please reply.  Also, I'm not in the list, you will have to reply to me
directly.  Thanks in advance,

Bob

