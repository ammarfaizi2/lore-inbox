Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266921AbUAXMG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 07:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266923AbUAXMG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 07:06:59 -0500
Received: from northgate.starhub.net.sg ([203.117.1.53]:57861 "EHLO
	northgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id S266921AbUAXMG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 07:06:58 -0500
Date: Sat, 24 Jan 2004 20:10:25 +0800
From: Richard Chan <rspchan@starhub.net.sg>
Subject: [KBUILD] md/raid6 breaks separate source/object tree
To: linux-kernel@vger.kernel.org
Message-id: <401260B1.7090909@starhub.net.sg>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


md/raid6 is using an in-tree perl script to generate a C file.
This breaks kbuild separate src/obj tree.

  CC [M]  drivers/md/raid6main.o
  CC [M]  drivers/md/raid6algos.o
  CC [M]  drivers/md/raid6recov.o
  HOSTCC  drivers/md/mktables
drivers/md/mktables > drivers/md/raid6tables.c || ( rm -f 
drivers/md/raid6tables.c && exit 1 )
  CC [M]  drivers/md/raid6tables.o
perl drivers/md/unroll.pl 1 < 
/usr/src/linux-2.6.2-rc1.1.A/drivers/md/raid6int.uc > 
drivers/md/raid6int1.c || ( rm -f drivers/md/raid6int1.c && exit 1 )
Can't open perl script "drivers/md/unroll.pl": No such file or directory

Somehow the src in $(PERL) $(src)/drivers/md/unroll.pl is not getting 
substituted.

Still trying to figure it out...
