Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTKLPWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTKLPWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:22:03 -0500
Received: from barclay.balt.net ([195.14.162.78]:45740 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S263795AbTKLPWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:22:00 -0500
Date: Wed, 12 Nov 2003 17:20:25 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: linux-kernel@vger.kernel.org
Subject: Crash in UNIX socket related code on 2.4.23-rc1 ?
Message-ID: <20031112152024.GA23030@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I am getting the same oops at sk_buff.c:174 line with identical
backtrace. I coundn't capture the oops - so i wrote down the backtrace 
addresses and fed through ksymoops -A "..." option.

$ ksymoops -A "0xc01a0f16, 0xc01a0f16, 0xc01a108f, 0xc01e1092, 0xc019ebd4,
0xc019f913, 0xc011b635, 0xc011be2d, 0xc0110be6, 0xc011c507, 0xc019f94d,
0xc01a00b6, 0xc0108703"
ksymoops 2.4.5 on i686 2.4.23-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-rc1/ (default)
     -m /boot/System.map-2.4.23-rc1 (default)

Adhoc c01a0f16 <sock_alloc_send_pskb+72/1d4>	<-- #1
Adhoc c01a0f16 <sock_alloc_send_pskb+72/1d4>	<-- #2 
Adhoc c01a108f <sock_alloc_send_skb+17/1c>
Adhoc c01e1092 <unix_bind+17e/2fc>
Adhoc c019ebd4 <sock_sendmsg+68/88>
Adhoc c019f913 <sys_sendto+cf/f0>
Adhoc c011b635 <kill_something_info+119/124>
Adhoc c011be2d <sys_kill+4d/58>
Adhoc c0110be6 <schedule+2e2/30c>
Adhoc c011c507 <sys_rt_sigaction+8f/154>
Adhoc c019f94d <sys_send+19/20>
Adhoc c01a00b6 <sys_socketcall+10e/1cc>
Adhoc c0108703 <system_call+33/38>

Any ideas what's going on ? 
