Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTICQO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTICQO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:14:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32720 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263963AbTICQMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:12:45 -0400
Date: Wed, 3 Sep 2003 18:12:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.0-test4-mm5
Message-ID: <20030903161200.GC23729@fs.tum.de>
References: <20030902231812.03fae13f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902231812.03fae13f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error (using gcc 2.95) in 2.6.0-test4-mm5
(but it seems to come from Linus' tree):

<--  snip  -->

...
  CC [M]  drivers/net/sungem.o
drivers/net/sungem.c:2444: duplicate initializer
drivers/net/sungem.c:2444: (near initialization for `gem_ethtool_ops.get_link')
make[2]: *** [drivers/net/sungem.o] Error 1

<--  snip  -->


It seems gcc is right, there are two .get_link members in this struct:


<--  snip  -->

...
static struct ethtool_ops gem_ethtool_ops = {
        .get_drvinfo            = gem_get_drvinfo,
        .get_link               = ethtool_op_get_link,
        .get_settings           = gem_get_settings,
        .set_settings           = gem_set_settings,
        .nway_reset             = gem_nway_reset,
        .get_link               = gem_get_link,
        .get_msglevel           = gem_get_msglevel,
        .set_msglevel           = gem_set_msglevel,
};
...

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

