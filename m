Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVHFUxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVHFUxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVHFUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 16:53:00 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:6792 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261261AbVHFUw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 16:52:59 -0400
Message-ID: <42F5232A.7000204@free.fr>
Date: Sat, 06 Aug 2005 22:52:58 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: leendert@watson.ibm.com, safford@watson.ibm.com, sailer@watson.ibm.com,
       kjhall@us.ibm.com, tpmdd_devel@lists.sourceforge.net
Subject: broken tpm driver that register LPC device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have seen that new tpm driver register lpc device with 
pci_register_driver, and does pci_disable_device on it.

This is _very_ broken as other driver share the same pci device.
For example drivers/char/watchdog/i8xx_tco.c. This one is right, as it 
only scan the lpc device via pci_find_device and don't register it. It 
also don't try to enable/disable it...

Finaly, after a quick look, they don't even need to acess the lpc as 
they don't read/write any value on it, they just do some IO on some ports.

Of course they don't care to request these IO ports with request_region...

I really wonder how such messy driver go into mainline kernel.


So for the tpm on the lpc, use pnp layer if possible or don't register 
it, and do like i8xx_tco.c. And before doing any IO use request_region...


regards,

Matthieu
