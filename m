Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRDHAXJ>; Sat, 7 Apr 2001 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRDHAW7>; Sat, 7 Apr 2001 20:22:59 -0400
Received: from jalon.able.es ([212.97.163.2]:14528 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132142AbRDHAWm>;
	Sat, 7 Apr 2001 20:22:42 -0400
Date: Sun, 8 Apr 2001 02:22:33 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1
Message-ID: <20010408022233.E1138@werewolf.able.es>
In-Reply-To: <20010407175505.A25801@sapience.com> <200104072324.f37NOCs90832@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104072324.f37NOCs90832@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sun, Apr 08, 2001 at 01:24:12 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.08 Justin T. Gibbs wrote:
> >
> >   In file included from aic7xxx_linux.c:131:
> >   aic7xxx_osm.h: In function `ahc_pci_read_config':
> >   aic7xxx_osm.h:862: warning: control reaches end of non-void function
> 
> This is because panic() is not marked as a "no return" function.  So,

linux/include/linux/kernel.h +38:

# define NORET_TYPE    /**/
# define ATTRIB_NORET  __attribute__((noreturn))
# define NORET_AND     noreturn,
..
NORET_TYPE void panic(const char * fmt, ...)
    __attribute__ ((NORET_AND format (printf, 1, 2)));
                    ^^^^^^^^^

Similar cases, compare include/linux/raid/md_k.h:pers_to_level() in
2.4.3 and 2.4.3-ac3.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

