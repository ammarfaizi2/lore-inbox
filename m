Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131486AbRC3US1>; Fri, 30 Mar 2001 15:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRC3USS>; Fri, 30 Mar 2001 15:18:18 -0500
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:65033 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S131486AbRC3USC>; Fri, 30 Mar 2001 15:18:02 -0500
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at>
Subject: problem in drivers/block/Config.in
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2001 22:17:08 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I noticed that the option CONFIG_PARIDE_PARPORT will always be "y",
even if CONFIG_PARIDE_PARPORT="n". I checked with kernels 2.2.18
and 2.2.19.

the file responsible is "drivers/block/Config.in", around line 126.
it reads:

# PARIDE doesn't need PARPORT, but if PARPORT is configured as a module,
# PARIDE must also be a module.  The bogus CONFIG_PARIDE_PARPORT option
# controls the choices given to the user ...

if [ "$CONFIG_PARPORT" = "y" -o "$CONFIG_PARPORT" = "n" ] ; then
   define_bool CONFIG_PARIDE_PARPORT y
else
   define_bool CONFIG_PARIDE_PARPORT m
fi

so, as you can see, CONFIG_PARIDE_PARPORT will be set to "yes" even
if CONFIG_PARPORT="no".

why not simply write:

	define_bool CONFIG_PARIDE_PARPORT $CONFIG_PARPORT

instead?

regards,
herbert rosmanith
herp@wildsau.idv.uni-linz.ac.at

