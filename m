Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbRGJIPd>; Tue, 10 Jul 2001 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265913AbRGJIPY>; Tue, 10 Jul 2001 04:15:24 -0400
Received: from jalon.able.es ([212.97.163.2]:18878 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265592AbRGJIPI>;
	Tue, 10 Jul 2001 04:15:08 -0400
Date: Tue, 10 Jul 2001 10:16:05 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: problems with lo and AF_NETLINK
Message-ID: <20010710101605.A3984@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

With latest 2.4.6-ac2, my lo interface setup looks like broken.
Initscripts use /sbin/ip (it is a Mandrake Cooker box) to query the interface,
and it only gets 'refused connections'. I think it worked with previous
kernels.

This is an strace of the problem:
werewolf:~# strace ip -o link
...
socket(PF_NETLINK, SOCK_RAW, 0)         = 3
bind(3, {sin_family=AF_NETLINK, {sa_family=16, sa_data="\0\0\0\0\0\0\0\0\0\0\353\215\5\10"}, 12) = 0
getsockname(3, {sin_family=AF_NETLINK, {sa_family=16, sa_data="\0\0\215\17\0\0\0\0\0\0\353\215\5\10"}, [12]) = 0
time(NULL)                              = 994752488
sendto(3, "\24\0\0\0\22\0\1\3\351\267J;\0\0\0\0\21\362\5\10", 20, 0, {sin_family=AF_NETLINK, {sa_family=16, sa_data="\0\0\0\0\0\0\0\0\0\0`d\5\10"}, 12) = -1 ECONNREFUSED (Connection refused)
write(2, "Cannot send dump request: Connec"..., 45Cannot send dump request: Connection refused
) = 45
_exit(1)                                = ?

I saw that NETLINK support has changed a bit in ac series:

Netlink device emulation
CONFIG_NETLINK_DEV
  This option will be removed soon. Any programs that want to use
  character special nodes like /dev/tap0 or /dev/route (all with major
  number 36) need this option, and need to be rewritten soon to use
  the real netlink socket.
  This is a backward compatibility option, choose Y for now.

I have activated it, but nothing changes. Any idea ?

Thanks.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.6-ac2 #1 SMP Sun Jul 8 23:57:11 CEST 2001 i686
