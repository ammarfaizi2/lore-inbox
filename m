Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbRERVmI>; Fri, 18 May 2001 17:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbRERVl6>; Fri, 18 May 2001 17:41:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53632 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261572AbRERVlt>;
	Fri, 18 May 2001 17:41:49 -0400
Date: Fri, 18 May 2001 17:41:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minor crapectomy in drivers/char/misc.c
Message-ID: <Pine.GSO.4.21.0105181726090.3555-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% find . -type f -print | xargs grep -nwC1 radio_init  
./drivers/char/misc.c-75-extern int ds1286_init(void);
./drivers/char/misc.c:76:extern int radio_init(void);
./drivers/char/misc.c-77-extern int pmu_device_init(void);
--
./drivers/char/misc.c-265-#ifdef CONFIG_MISC_RADIO
./drivers/char/misc.c:266:      radio_init();
./drivers/char/misc.c-267-#endif
% find . -type f -print | xargs grep -nw CONFIG_MISC_RADIO 
./drivers/char/misc.c:265:#ifdef CONFIG_MISC_RADIO
% 

IOW, radio_init() is never defined and CONFIG_MISC_RADIO is never set.

Proposed fix:
vi -c'/radio_init/d|/CONFIG_MISC_RADIO/|,+2d|x' drivers/char/misc.c

									Al

