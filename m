Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUJJUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUJJUYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268467AbUJJUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:24:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:22461 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268465AbUJJUYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:24:22 -0400
X-Authenticated: #13243522
Message-ID: <41699A76.55A8EBE1@gmx.de>
Date: Sun, 10 Oct 2004 22:24:22 +0200
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PANIC] Kernel panic after rmmod softdog (2.6.8.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today, when testing the software watchdog, I accidentally removed the 
software watchdog kernel module and got a kernel panic.

to reproduce:

- build a kernel (2.6.8.1) with softdog built as module
  (and without the NOWAYOUT option)
- load the softdog module
- write something (not ending with a "V") to /dev/watchdog, e. g.
  echo x >/dev/watchdog
- A message will appear that device was closed, but the watchdog is 
  still active (if you wait a minute now, your box will reboot...)
- remove the softdog module
- wait a minute. you will see a kernel panic.

If there is a need for the actual panic message, I'll take a piece of 
paper and transcribe it (no serial console here...), but i doubt it,
since 
it is quite easy to reproduce...

when you disable the watchdog by
  echo "V" >/dev/watchdog
before removing the module, it will not panic.

Hmm, another thing: according to the documentation in watchdog.txt,
softdog does not honor the special "V" for closing the watchdog,
but actually it does.

Please CC me since I am not on the list,

Michael
