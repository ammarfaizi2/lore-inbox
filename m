Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRKNKEQ>; Wed, 14 Nov 2001 05:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280415AbRKNKEH>; Wed, 14 Nov 2001 05:04:07 -0500
Received: from mta40-acc.tin.it ([212.216.176.93]:57532 "EHLO fep40-svc.tin.it")
	by vger.kernel.org with ESMTP id <S280153AbRKNKD5>;
	Wed, 14 Nov 2001 05:03:57 -0500
Message-ID: <3BF24181.935D133B@revicon.com>
Date: Wed, 14 Nov 2001 11:03:45 +0100
From: Lars Knudsen <gandalf@revicon.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI bridge I/O space misconfiguration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems with some PCI devices being
configured incorrectly. The PCI bus layout is as
follows:

# lspci -t
-[00]-+-00.0
      +-01.0-[01]----00.0
      +-07.0
      +-07.1
      +-07.2
      +-07.3
      +-08.0
      +-09.0-[02]--+-06.0
      |            +-07.0
      |            \-09.0
      \-0a.0-[03]--+-06.0
                   +-06.1
                   \-07.0

All devices except the bridge 00:0a.0 and/or the
03:07.0 device gets configured correctly. 

The 03:07.0 device has I/O ports at de00 but the
00:0a.0 bridge is configured to have I/O behind
bridge: 0000e000-0000efff. Since de00 is not in 
this range access to device 03:07.0 is impossible.

If I understand correctly an error like this is
caused by a BIOS error. Has anyone else seen
problems like this and what is the suggested fix ?

I'm running a 2.2.19 kernel and have tried the
bios, nobios and nopeer options to the kernel with
the same results.

Thanks in advance,

Lars Knudsen
