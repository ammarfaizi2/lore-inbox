Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUCLR0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUCLR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:26:43 -0500
Received: from ns.cohaesio.net ([212.97.129.16]:46211 "EHLO ns.cohaesio.net")
	by vger.kernel.org with ESMTP id S262353AbUCLRZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:25:59 -0500
Subject: Re: 2.6.3 userspace freeze
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87ptbi5on5.fsf@goat.bogus.local>
References: <222BE5975A4813449559163F8F8CF503458441@cohsrv1.cohaesio.com>
	 <87ptbi5on5.fsf@goat.bogus.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Cohaesio A/S
Message-Id: <1079112003.19710.10.camel@akp.cohaesio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 18:20:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2004-03-12 at 11:46, Olaf Dietsche wrote:
> There are always many rotatelogs started. Maybe that's a hint for
> further investigation.

The rotatelogs processes are used to write log data from Apache (by use
of CustomLog/ErrorLog directives) to rotating files, so this is quite
normal. I just made the following pstree, which is typical for this
server:

init-+-agent.be---agent.be
     |-agetty
     |-atd
     |-bdflush
     |-caspd---caspd---caspd---caspeng---caspeng---22*[caspeng]
     |-crond
     |-httpd-+-233*[httpd]
     |       |-120*[rotatelogs]
     |       `-3*[rotatelogspsoft]
     |-keventd
     |-khubd
     |-4*[kjournald]
     |-klogd
     |-ksoftirqd_CPU0
     |-ksoftirqd_CPU1
     |-kswapd
     |-kupdated
     |-logger
     |-master-+-2*[cleanup]
     |        |-pickup
     |        |-qmgr
     |        |-4*[smtp]
     |        `-trivial-rewrite
     |-7*[mingetty]
     |-named
     |-ntpd
     |-proftpd---16*[proftpd]
     |-scsi_eh_0
     |-soagent
     |-sshd-+-sshd---script-runner.p
     |      `-sshd---bash---pstree
     |-syslogd
     |-ulogd
     `-watchdogd

-- 
Med venlig hilsen - Best regards

Anders K. Pedersen
Network Engineer
------------------------------------------------ 
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888  - Fax: +45 45 880 777
Mail: akp@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
