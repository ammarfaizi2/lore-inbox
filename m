Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263168AbTCLMp7>; Wed, 12 Mar 2003 07:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbTCLMp7>; Wed, 12 Mar 2003 07:45:59 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:53908 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263168AbTCLMp6>; Wed, 12 Mar 2003 07:45:58 -0500
Date: Wed, 12 Mar 2003 13:56:31 +0100
From: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Deepak Saxena <deepak@plexity.net>
Subject: Re: 2.5.64: i2c-proc kills machine at boot
Message-ID: <20030312125631.GA27966@wohnheim.fh-wedel.de>
References: <20030311104721.GA401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030311104721.GA401@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 March 2003 11:47:22 +0100, Pavel Machek wrote:
> 
> If I turn #ifdef DEBUG in i2c_register_entry() into #if 1, it prints 
> 
> i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n
> 
> but boots.

That file need a lot of work anyway. On the shitlist of top stack
users, it holds ranks 3 and 9-11. Impressive.

$ make checkstack|grep i2o_proc
0xc0167db8 i2o_proc_read_ddm_table:                      sub    $0xb40,%esp
0xc0169ec8 i2o_proc_read_lan_mcast_addr:                 sub    $0x814,%esp
0xc016a56c i2o_proc_read_lan_alt_addr:                   sub    $0x814,%esp
0xc01681a0 i2o_proc_read_groups:                         sub    $0x810,%esp
0xc0168520 i2o_proc_read_users:                          sub    $0x20c,%esp
0xc0168630 i2o_proc_read_priv_msgs:                      sub    $0x18c,%esp
0xc016aaa4 i2o_proc_read_lan_hist_stats:                 sub    $0x160,%esp
0xc01689a4 i2o_proc_read_ddm_identity:                   sub    $0x130,%esp
0xc016835c i2o_proc_read_phys_device:                    sub    $0x10c,%esp
0xc0168740 i2o_proc_read_authorized_users:               sub    $0x10c,%esp

BTW: It depends on CONFIG_PCI, but doesn't state it. The patch below
should fix this.

It also isn't listed in the current MAINTAINERS file. Is i2o currently
unmaintained?

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell

--- drivers/message/i2o/Kconfig	Mon Feb 24 20:05:05 2003
+++ foo	Wed Mar 12 13:46:57 2003
@@ -65,7 +65,7 @@
 
 config I2O_PROC
 	tristate "I2O /proc support"
-	depends on I2O
+	depends on I2O && PCI
 	help
 	  If you say Y here and to "/proc file system support", you will be
 	  able to read I2O related information from the virtual directory
