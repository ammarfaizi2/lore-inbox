Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289045AbSAIWPV>; Wed, 9 Jan 2002 17:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289049AbSAIWPG>; Wed, 9 Jan 2002 17:15:06 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:55789 "HELO
	dardhal") by vger.kernel.org with SMTP id <S289045AbSAIWOH>;
	Wed, 9 Jan 2002 17:14:07 -0500
Date: Wed, 9 Jan 2002 23:13:55 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG]: bonding module parameter problem
Message-ID: <20020109221354.GB3965@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

There seems to be a problem in module bonding.o (just the interesting
part follows, kernel version is 2.4.17):
user@machine:/tmp$ /sbin/modinfo bonding
license:     "GPL"
warning: parameter max_bonds has max < min!
parm:  max_bonds unknown format character '('parm:  miimon int, description "Link check interval in milliseconds"

At /usr/src/linux/drivers/net/bonding.c, line 229:
MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");

And at /usr/src/linux/include/linux/kernel.h, line 19:
#define INT_MAX                ((int)(~0U>>1))

There are some places (/usr/src/linux/net/ipv4/netfilter/ip_conntrack_ftp.c
line 19) with similar macro invocations that work OK. It seems macro
MODULE_PARM gets confused with those parentheses in #define INT_MAX

This problem is still in 2.4.18-pre2, but seems that is solved upstream
(http://sf.net/projects/bonding/), see:
http://telia.dl.sourceforge.net/bonding/bonding-2.4.17-20020102

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

