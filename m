Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbTCHVyw>; Sat, 8 Mar 2003 16:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbTCHVyw>; Sat, 8 Mar 2003 16:54:52 -0500
Received: from mail.pf ([202.3.225.22]:43839 "EHLO smtp.mana.pf")
	by vger.kernel.org with ESMTP id <S262293AbTCHVyt>;
	Sat, 8 Mar 2003 16:54:49 -0500
Message-ID: <3E6A695B.6070006@esoft.pf>
Date: Sat, 08 Mar 2003 12:06:19 -1000
From: Jean-Denis Girard <jd-girard@esoft.pf>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: fr-fr, fr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.64: kernel BUG at include/linux/dcache.h
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got the following bug after stopping ppp connection, running 2.5.64. Had 
to reboot just after (system was in a bad state).
The same system has been running 2.5.62 quite happily for a few days.

Hoping it is usefull to someone,

Jean-Denis

mar  7 21:19:34 taina su(pam_unix)[2147]: session opened for user root 
by jdg(uid=501)
Mar  7 21:19:42 taina kernel: device ppp0 entered promiscuous mode
Mar  7 22:01:14 taina CROND[2550]: (root) CMD (nice -n 19 run-parts 
/etc/cron.hourly)
Mar  7 22:02:07 taina pppd[1938]: Terminating on signal 15.
Mar  7 22:02:07 taina kernel: device ppp0 left promiscuous mode
Mar  7 22:02:07 taina kernel: device ppp0 entered promiscuous mode
Mar  7 22:02:07 taina pppd[1938]: Connection terminated.
Mar  7 22:02:07 taina pppd[1938]: Connect time 77.8 minutes.
Mar  7 22:02:07 taina pppd[1938]: Sent 1608686 bytes, received 7679979 
bytes.
Mar  7 22:02:07 taina kernel: ------------[ cut here ]------------
Mar  7 22:02:07 taina kernel: kernel BUG at include/linux/dcache.h:266!
Mar  7 22:02:07 taina kernel: invalid operand: 0000
Mar  7 22:02:07 taina kernel: CPU:    0
Mar  7 22:02:07 taina kernel: EIP:    0060:[sysfs_remove_dir+29/323]    
Not tainted
Mar  7 22:02:07 taina kernel: EIP:    0060:[<c016f22d>]    Not tainted
Mar  7 22:02:07 taina kernel: EFLAGS: 00010246
Mar  7 22:02:07 taina kernel: eax: 00000000   ebx: c7fa2d84   ecx: 
00000000   edx: 00000000
Mar  7 22:02:07 taina kernel: esi: c65d6a40   edi: c5b02000   ebp: 
c5b03eec   esp: c5b03ed0
Mar  7 22:02:07 taina kernel: ds: 007b   es: 007b   ss: 0068
Mar  7 22:02:07 taina kernel: Process pppd (pid: 1938, 
threadinfo=c5b02000 task=c6a69300)
Mar  7 22:02:07 taina kernel: Stack: c02e3be0 c7fa2c00 c5b03eec c025b423 
c7fa2d84 c7fa2c00 c5b02000 c5b03efc
Mar  7 22:02:07 taina kernel:        c019a9d4 c7fa2d84 c7fa2d84 c5b03f0c 
c019a9f4 c7fa2d84 c7fa2c00 c5b03f30
Mar  7 22:02:07 taina kernel:        c0223a6f c7fa2d84 00000006 c7fa2c00 
080812e8 c5b02000 c7fa2c00 c7fa3180
Mar  7 22:02:07 taina kernel: Call Trace: [fib_netdev_event+131/160]  
[kobject_del+20/32]  [kobject_unregister+20/32]  
[unregister_netdevice+447/672]  [<d0a19b7d>]  [<d0a179bf>]  
[<d0a2b270>]  [<d0a
2b410>]  [<d0a2b430>]  [<d0a2b420>]  [sys_ioctl+160/544]  
[sys_close+81/96]  [syscall_call+7/11]
Mar  7 22:02:07 taina kernel: Call Trace: [<c025b423>]  [<c019a9d4>]  
[<c019a9f4>]  [<c0223a6f>]  [<d0a19b7d>]  [<d0a179bf>]  [<d0a2b270>]  
[<d0a2b410>]  [<d0a2b430>]  [<d0a2b420>]  [<c0153290>]  [<
c0142de1>]  [<c0109413>]
Mar  7 22:02:07 taina kernel: Code: 0f 0b 0a 01 d6 7f 27 c0 ff 06 83 4e 
04 08 85 f6 0f 84 08 01
mar  7 22:03:24 taina su(pam_unix)[2147]: session closed for user root


