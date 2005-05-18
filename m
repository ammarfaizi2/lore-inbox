Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVERSnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVERSnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVERSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:43:21 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:15295 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262313AbVERSmf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rJmJCTw2RhrlWSlWdleQOl8dRl1T2+YQ9Lw06G9XuaeqMXZhMEpvS/mgwdkUX/Iy/CVtg4d3blKaKJ+91CsUXD46/u1n+R3l9HbsVn2/BAz9CQ5TQVWFKDFt0NFplV6bxwPFXkXaz3WxsXgm4QOBLkNKgPVZVd8peVywXFgTxBc=
Message-ID: <377362e10505181142252ec930@mail.gmail.com>
Date: Thu, 19 May 2005 03:42:31 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: HT scheduler: is it really correct? or is it feature of HT?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering linux kernel's HT support is correct or not, or whether
it's a feature of P4 HT.

I'm running boinc/seti in the background with nice=19 on my P4 2.8G HT
enabled linux box, kernel 2.6.11.9, where SMT/HT is enabled.

I often watch system monitor applet on gnome desktop or top command in
a termianl window and see when no other applications than boinc is
running, boinc takes full power of both virtual cpus.   It is designed
to run to "fill" the idle power of the cpu(s).   However any
application is running, there is always some "idle" part appears on
virtual cpus, hence it looks like it wastes up to half of cpu power as
"idle."

For ex, see this "top" result while a vmware is running.   (HT is
enabled)  setiathome-4.7(blah--) are the background boinc applications
with nice=19.

-----------------------------------------------------------------
top - 03:21:30 up  1:58, 15 users,  load average: 4.53, 4.56, 4.78
Tasks: 183 total,   5 running, 178 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.3% us, 94.0% sy,  4.7% ni,  0.7% id,  0.0% wa,  0.3% hi,  0.0% si
Cpu1  :  2.7% us,  1.0% sy, 11.0% ni, 82.4% id,  3.0% wa,  0.0% hi,  0.0% si
Mem:    905068k total,   893584k used,    11484k free,     3840k buffers
Swap:  1662688k total,        0k used,  1662688k free,   526900k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 8490 tetsuji   25   0  205m 164m 154m R 93.7 18.7  75:10.29 vmware-vmx
 7092 boinc     39  19 22828  18m 2012 R  5.6  2.1  27:22.04 setiathome-4.7.
 8605 boinc     39  19 24992  20m 3212 R  5.6  2.3  20:58.46 setiathome-4.7.
 7091 boinc     39  19 22696  18m 2012 R  4.7  2.1  27:01.92 setiathome-4.7.
 7220 root      16   0  180m  32m 9396 S  1.3  3.6   3:23.59 X
 7295 tetsuji   15   0 40936  28m 8356 S  1.3  3.2   0:38.64 gnome-terminal
 8483 tetsuji    6 -10  205m 164m 154m S  0.7 18.7   1:04.59 vmware-vmx
 7370 tetsuji   17   0 18348 9356 7176 S  0.3  1.0   0:09.53 clock-applet

-----------------------------------------------------------------

When HT is disabled, top looks like this: note idle is 0.   nice fills
the vacant cpu power.

-----------------------------------------------------------------
top - 03:37:25 up 10 min, 13 users,  load average: 5.31, 3.49, 1.66
Tasks: 137 total,   3 running, 134 sleeping,   0 stopped,   0 zombie
Cpu(s):  1.7% us, 43.9% sy, 51.2% ni,  0.0% id,  0.0% wa,  3.3% hi,  0.0% si
Mem:    905068k total,   895784k used,     9284k free,     1328k buffers
Swap:  1662688k total,        0k used,  1662688k free,   672892k cached
Change delay from 3.0 to:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 7350 boinc     39  19 22620  18m 2012 R 54.2  2.1   5:46.97 setiathome-4.7.
 8126 tetsuji   15   0 93104  52m  47m S 35.2  6.0   1:14.76 vmware-vmx
 8118 root      18   0  2200  876  724 R  5.7  0.1   0:13.71 tar
   97 root      10  -5     0    0    0 S  1.0  0.0   0:02.98 kblockd/0
  157 root      15   0     0    0    0 S  1.0  0.0   0:04.26 kswapd0
 7169 root      15   0  171m  23m 7840 S  0.7  2.6   0:06.90 X
 8166 root      15   0     0    0    0 S  0.7  0.0   0:00.06 pdflush
 5182 root      15   0     0    0    0 S  0.3  0.0   0:02.84 kjournald
 7242 tetsuji   15   0 29556  17m 8184 S  0.3  2.0   0:02.94 gnome-terminal
-----------------------------------------------------------------

Overall power is higher when HT is enabled, so I want to use it with HT enabled.

regards,

-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
