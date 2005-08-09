Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVHIPuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVHIPuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVHIPuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:50:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5640 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964834AbVHIPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:50:05 -0400
Date: Tue, 9 Aug 2005 17:50:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>, linux-kernel@vger.kernel.org
Subject: [-mm patch] DLM must depend on IPV6 || IPV6=n
Message-ID: <20050809155001.GZ4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you select something, you have to ensure that the dependencies of 
what you are selecting are fulfilled.

This patch fixes the following compile error with CONFIG_DLM=y and 
CONFIG_IPV6=m:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o: In function `sctp_v6_err':
ipv6.c:(.text+0x8cb67): undefined reference to `icmpv6_err_convert'
ipv6.c:(.text+0x8cbad): undefined reference to `in6_dev_finish_destroy'
ipv6.c:(.text+0x8cc4b): undefined reference to `icmpv6_statistics'
net/built-in.o: In function `sctp_v6_xmit':
ipv6.c:(.text+0x8ccfc): undefined reference to `ipv6_addr_type'
ipv6.c:(.text+0x8cfca): undefined reference to `ip6_xmit'
net/built-in.o: In function `sctp_v6_get_dst':
ipv6.c:(.text+0x8d031): undefined reference to `ipv6_addr_type'
ipv6.c:(.text+0x8d083): undefined reference to `ip6_route_output'
ipv6.c:(.text+0x8d4a7): undefined reference to `ip6_route_output'
net/built-in.o: In function `sctp_v6_get_saddr':
ipv6.c:(.text+0x8d7a1): undefined reference to `ipv6_get_saddr'
net/built-in.o: In function `sctp_v6_cmp_addr':
ipv6.c:(.text+0x8ddc0): undefined reference to `ipv6_addr_type'
ipv6.c:(.text+0x8de0d): undefined reference to `ipv6_addr_type'
ipv6.c:(.text+0x8de41): undefined reference to `ipv6_addr_type'
net/built-in.o: In function `sctp_v6_available':
ipv6.c:(.text+0x8dee8): undefined reference to `ipv6_addr_type'
net/built-in.o: In function `sctp_v6_addr_valid':
ipv6.c:(.text+0x8dfa2): undefined reference to `ipv6_addr_type'
net/built-in.o:ipv6.c:(.text+0x8e014): more undefined references to `ipv6_addr_type' follow
net/built-in.o: In function `sctp_v6_init':
: undefined reference to `inet6_add_protocol'
net/built-in.o: In function `sctp_v6_init':
: undefined reference to `inet6_register_protosw'
net/built-in.o: In function `sctp_v6_init':
: undefined reference to `inet6_register_protosw'
net/built-in.o: In function `sctp_v6_init':
: undefined reference to `register_inet6addr_notifier'
net/built-in.o: In function `sctp_v6_exit':
: undefined reference to `inet6_del_protocol'
net/built-in.o: In function `sctp_v6_exit':
: undefined reference to `inet6_unregister_protosw'
net/built-in.o: In function `sctp_v6_exit':
: undefined reference to `inet6_unregister_protosw'
net/built-in.o: In function `sctp_v6_exit':
: undefined reference to `unregister_inet6addr_notifier'
net/built-in.o: In function `sctp_v6_available':
ipv6.c:(.text+0x8df2a): undefined reference to `ipv6_chk_addr'
net/built-in.o:(.data+0x5e48): undefined reference to `inet6_release'
net/built-in.o:(.data+0x5e4c): undefined reference to `inet6_bind'
net/built-in.o:(.data+0x5e5c): undefined reference to `inet6_getname'
net/built-in.o:(.data+0x5e64): undefined reference to `inet6_ioctl'
net/built-in.o:(.data+0x5f04): undefined reference to `ipv6_setsockopt'
net/built-in.o:(.data+0x5f08): undefined reference to `ipv6_getsockopt'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 30 Jul 2005

--- linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig.old	2005-07-30 14:07:12.000000000 +0200
+++ linux-2.6.13-rc3-mm3-modular/drivers/dlm/Kconfig	2005-07-30 14:07:41.000000000 +0200
@@ -3,6 +3,7 @@
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
+	depends on IPV6 || IPV6=n
 	select IP_SCTP
 	help
 	A general purpose distributed lock manager for kernel or userspace


