Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbUKPWrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUKPWrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKPWrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:47:46 -0500
Received: from smtp06.auna.com ([62.81.186.16]:28908 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261869AbUKPWpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:45:40 -0500
Date: Tue, 16 Nov 2004 22:45:37 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: X sloow under 2.6.9 and up - mtrr ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1100645137l.8864l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have built 2.6.10-rc2-mm1, and as nVidia drivers do not work with it,
i configured xorg-6.8.1 to use the standard 'nv' driver.
But now X redraws are dog slow, you can count pixels redrawing on the
screen if you move a window in filled mode.

Somebodyt has a clue about why can this be happening ?
>From deep in my memory I remember this was related to mtrr settings.
With the nVidia driver I have:

werewolf:~> cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x3ff00000 (1023MB), size=   1MB: uncachable, count=1
reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1
reg03: base=0xe8000000 (3712MB), size= 128MB: write-combining, count=1

and with the nv standard driver:

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x3ff00000 (1023MB), size=   1MB: uncachable, count=1
reg02: base=0xe8000000 (3712MB), size= 128MB: write-combining, count=1

One is missing. It is an i875P chipset.

Any idea ?

Ah, this also happens on one other box, also with an nvidia card, but this
box never had the binary drivers installed, it is just a server.
This one is a Via Apollo Pro266, and its mtrr:
nada:~# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xf0000000 (3840MB), size=  64MB: write-combining, count=1
reg02: base=0xe8000000 (3712MB), size=  64MB: write-combining, count=1

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #10


