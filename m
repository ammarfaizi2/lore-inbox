Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTIAASc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 20:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTIAASc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 20:18:32 -0400
Received: from ethlife-a.ethz.ch ([129.132.202.7]:3559 "HELO ethlife.ethz.ch")
	by vger.kernel.org with SMTP id S263106AbTIAASa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 20:18:30 -0400
Mime-version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 1 Sep 2003 02:18 +0200
Subject: cryptoloop on 2.4.22/ppc doesn't work
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Content-Transfer-Encoding: 7BIT
Message-Id: <S263106AbTIAASa/20030901001830Z+208687@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I cannot seem to get crypto loopback to run.

This is 2.4.22 + patch-cryptoloop-jari-2.4.22.0 + 2.4.22-ben1 (but the
latter does not touch any of the crypto or loop devices), all from
kernel.org.

Linux lombi 2.4.22-ben1 #4 Son Aug 31 22:58:54 MEST 2003 ppc unknown

root@lombi root# LANG=C losetup -e blowfish /dev/loop1 christest 
Password :
The cipher does not exist, or a cipher module needs to be loaded into the kernel
ioctl: LOOP_SET_STATUS: Invalid argument

root@lombi root# LANG=C losetup -e aes /dev/loop1 christest 
The cipher does not exist, or a cipher module needs to be loaded into the kernel
ioctl: LOOP_SET_STATUS: Invalid argument

root@lombi root# stat christest | grep Blocks
  Size: 20971520  	Blocks: 41008      IO Block: 4096   Regular File

while the modules listed below are loaded.

This is Debian woody, /sbin/losetup from mount package 2.11m-1

Why doesn't it work?

Thanks,
Christian.



root@lombi root# lsmod
Module                  Size  Used by    Not tainted
twofish                37552   0 
sha512                  9536   0  (unused)
sha256                  8352   0  (unused)
sha1                    6016   0  (unused)
serpent                19232   0  (unused)
md4                     2816   0  (unused)
md5                     3584   0  (unused)
crypto_null             1008   0  (unused)
des                    10768   0  (unused)
cryptoloop              1664   0  (unused)
mol                    43828   1 
aes                    27528   0 
blowfish                9776   0 
loop                   12084   0  (autoclean) [cryptoloop]
sch_ingress             1952   1  (autoclean)
cls_u32                 5908   5  (autoclean)
sch_sfq                 4144   3  (autoclean)
sch_cbq                14992   1  (autoclean)
ipt_REJECT              3984  44  (autoclean)
ipt_MASQUERADE          1664   1  (autoclean)
iptable_filter          1888   1  (autoclean)
iptable_nat            18484   1  (autoclean) [ipt_MASQUERADE]
ip_conntrack           20724   1  (autoclean) [ipt_MASQUERADE iptable_nat]
ip_tables              14512   6  [ipt_REJECT ipt_MASQUERADE iptable_filter iptable_nat]
ds                      8608   1 
yenta_socket           12496   1 
pcmcia_core            44128   0  [ds yenta_socket]
usb-ohci               23136   0  (unused)
bmac                   14244   1 
ethertap                3468   1 
dmasound_pmac          70656   1 
i2c-core               14248   0  [dmasound_pmac]
dmasound_core          13448   1  [dmasound_pmac]
soundcore               4504   3  [dmasound_core]

