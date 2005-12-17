Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVLQAvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVLQAvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 19:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVLQAvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 19:51:13 -0500
Received: from mail.gmx.de ([213.165.64.21]:60388 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964902AbVLQAvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 19:51:12 -0500
X-Authenticated: #7534793
Date: Sat, 17 Dec 2005 01:51:09 +0100
From: Gerhard Schrenk <deb.gschrenk@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Correction for broken MCFG tables on K8 breaks acpi for MSI S260
Message-ID: <20051217005109.GA11982@mailhub.uni-konstanz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

commit d6ece5491ae71ded1237f59def88bcd1b19b6f60 breaks acpi for my
Medion MD 95600 (aka MSI S260) notebook.

|gps@medusa:~/scratch/kernel-bisect-tree$ git bisect bad
|d6ece5491ae71ded1237f59def88bcd1b19b6f60 is first bad commit
|diff-tree d6ece5491ae71ded1237f59def88bcd1b19b6f60 (from 928cf8c62763349efc550a12f6518e52c3390906)
|Author: Andi Kleen <ak@suse.de>
|Date:   Mon Dec 12 22:17:11 2005 -0800
|
|    [PATCH] i386/x86-64 Correct for broken MCFG tables on K8 systems
|    
|    They report all busses as MMCONFIG capable, but it never works for the
|    internal devices in the CPU's builtin northbridge.
|    
|    It just probes all func 0 devices on bus 0 (the internal northbridge is
|    currently always on bus 0) and if they are not accessible using MCFG they are
|    put into a special fallback bitmap.
|    
|    On systems where it isn't we assume the BIOS vendor supplied correct MCFG.
|    
|    Requires the earlier patch for mmconfig type1 fallback

After this patch I can only boot with "acpi=off". Before this commit
I could boot with "pci=noacpi acpi_sleep=s3_bios resume=/dev/hda2"
without an oops. Unfortunately 

  git revert d6ece5491ae71ded1237f59def88bcd1b19b6f60

does not work without merge conflict on top-of-kernel.

You can find the call trace picture for first bad kernel
d6ece5491ae71ded1237f59def88bcd1b19b6f60 on 

  https://mc.1und1.de/mc/eLBNuN1jZx61ZrQL0dXS0RxhWfCjEv 
  (&& click on "MediaCenter starten"; valid until 2006-01-16)
  
There you will also find dmesg, config , lspci and lspci -vv with the
latest good commit 928cf8c62763349efc550a12f6518e52c3390906

My notebook is a "Medion MD 95600" (sometimes called "SIM 2100" or "SIM
2010"). It's actually a "MSI S260".  You may find more information for
this notebook on the tuxmobil page.

 http://tuxmobil.org/msi.html

-- Gerhard
