Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTEHKU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTEHKU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:20:58 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:35467 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S261288AbTEHKUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:20:55 -0400
From: Nicolas <linux@1g6.biz>
Organization: 1G6
To: Andrew Morton <akpm@digeo.com>
Subject: Re: slab oops with 2.5.69
Date: Thu, 8 May 2003 12:35:47 +0200
User-Agent: KMail/1.5
References: <200305072317.47119.linux@1g6.biz> <20030507155512.0cc146a1.akpm@digeo.com>
In-Reply-To: <20030507155512.0cc146a1.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305081235.48358.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 08 Mai 2003 00:55, vous avez écrit :
> Nicolas <linux@1g6.biz> wrote:
> > Last user: [<d3a18226>](0xd3a18226)
>
> We need to know which module was the last one to play with that size-32
> object.
>
> Which modules were loaded, and had been in use?

Here is an lsmod with exactly the same situation when
the oops occured,
I have done one thing I can remember that may be not fair with
the kernel : "/sbin/modprobe sis-agp agp_try_unsupported=1"
    agpgart: Trying generic SiS routines for device id: 0648
    agpgart: Maximum main memory to use for agp memory: 941M
    agpgart: AGP aperture is 128M @ 0xd0000000

but I don't know if agp is used in my case.
I will retry today the same tests without agp...

so when the oops occured for sure : I was using :
at no load:
exportfs nfsd parport saa7134 ntfs ieee1394 v4l tuner usbcore ov511

low load :
sis900 e100 crc32 iptables i810_audio

unknown load (how to know if my agp port is used ?): 
    sis-agp agpgart loop/isofs(maybe) 

high load: ide_cd cdrom, 
and harddrive(hard in the kernel, not as module)
CPU/memory bandwith was at 100% because of encoding with
transcode.

lsmod

Module                  Size  Used by
floppy                 53908  0
lp                      8672  0
sis900                 15236  1
crc32                   4096  1 sis900
e100                   52868  1
sis_agp                 3968  1
ide_cd                 36608  1
cdrom                  32288  1 ide_cd
des                    11392  0
af_key                 25096  0
ah                      5888  0
md5                     3712  0
ov511                  88476  0
radeon                117912  0
agpgart                24616  1 sis_agp
button                  4884  0
ac                      3592  0
thermal                11144  0
fan                     3080  0
processor              11544  1 thermal
usblp                  11520  0
nfsd                   88624  0
exportfs                4864  1 nfsd
ehci_hcd               34176  0
ohci_hcd               30720  0
usbcore                96596  6 ov511,usblp,ehci_hcd,ohci_hcd
udf                    91396  0
parport_pc             22804  1
parport                34880  2 lp,parport_pc
i2c_dev                 5696  0
ipt_state               1536  3
ipt_ULOG                5384  0
ipt_LOG                 4480  5
iptable_filter          2304  1
iptable_mangle          2304  0
ipt_MASQUERADE          2944  1
iptable_nat            20244  2 ipt_MASQUERADE
ip_conntrack           23956  3 ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              13952  7 
ipt_state,ipt_ULOG,ipt_LOG,iptable_filter,iptable_mangle,ipt_MASQUERADE,iptable_nat
loop                   12808  6 [unsafe]
isofs                  30136  3
zlib_inflate           20864  1 isofs
tuner                  14596  1 [unsafe]
saa7134                74124  1
video_buf              15616  1 saa7134
v4l1_compat            12160  1 saa7134
i2c_core               18436  3 i2c_dev,tuner,saa7134
v4l2_common             3968  1 saa7134
videodev                8448  2 ov511,saa7134
i810_audio             25088  2
ac97_codec             13568  1 i810_audio
ohci1394               33152  0
ieee1394               66572  1 ohci1394
ntfs                   83984  1
af_packet              11784  4

and lsmod | grep -v " 0 "
Module                  Size  Used by
sis900                 15236  1
crc32                   4096  1 sis900
e100                   52868  1
sis_agp                 3968  1
cdrom                  32288  1 ide_cd
agpgart                24616  1 sis_agp
processor              11544  1 thermal
exportfs                4864  1 nfsd
usbcore                96596  6 ov511,usblp,ehci_hcd,ohci_hcd
parport_pc             22804  1
parport                34880  2 lp,parport_pc
ipt_state               1536  3
ipt_LOG                 4480  5
iptable_filter          2304  1
ipt_MASQUERADE          2944  1
iptable_nat            20244  2 ipt_MASQUERADE
ip_conntrack           23956  3 ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              13952  7 
ipt_state,ipt_ULOG,ipt_LOG,iptable_filter,iptable_mangle,ipt_MASQUERADE,iptable_nat
loop                   12808  6 [unsafe]
isofs                  30136  3
zlib_inflate           20864  1 isofs
tuner                  14596  1 [unsafe]
saa7134                74124  1
video_buf              15616  1 saa7134
v4l1_compat            12160  1 saa7134
i2c_core               18436  3 i2c_dev,tuner,saa7134
v4l2_common             3968  1 saa7134
videodev                8448  2 ov511,saa7134
i810_audio             25088  1
ac97_codec             13568  1 i810_audio
ieee1394               66572  1 ohci1394
ntfs                   83984  1
af_packet              11784  4

Ask me more informations if you need, as I am not a kernel hacker .. :),

Nicolas.




