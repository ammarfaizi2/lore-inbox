Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbTCVJT2>; Sat, 22 Mar 2003 04:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTCVJT2>; Sat, 22 Mar 2003 04:19:28 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:24512 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262061AbTCVJT1>;
	Sat, 22 Mar 2003 04:19:27 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303220930.h2M9USx05107@csl.stanford.edu>
Subject: [CHECKER]: potential deadlock in 2.5.62 drivers/usb/misc/auerswald.c
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 01:30:28 -0800 (PST)
Cc: engler@csl.stanford.edu (Dawson Engler)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a potential locking cycle in 2.5.62's
	drivers/usb/misc/auerswald.c
Can anyone confirm/discredit this?

Thanks!

<dev_table_mutex>-><struct.mutex> occurred 1 times
<struct.mutex)>-><&dev_table_mutex> occurred 1 times
 
Call chain for <&dev_table_mutex>-><struct.mutex>
    depth = 1:
        drivers/usb/misc/auerswald.c:auerchar_open:1404
           ->drivers/usb/misc/auerswald.c:auerchar_open:1412

Call chain for
  <struct.mutex>-><&dev_table_mutex> =
    depth = 1:
        drivers/usb/misc/auerswald.c:auerswald_disconnect:2091
           ->drivers/usb/misc/auerswald.c:auerswald_disconnect:2096
