Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTJ1Gp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTJ1Gp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 01:45:57 -0500
Received: from LION.SEAS.UPENN.EDU ([158.130.12.194]:62618 "EHLO
	lion.seas.upenn.edu") by vger.kernel.org with ESMTP id S261678AbTJ1Gpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 01:45:55 -0500
Date: Tue, 28 Oct 2003 01:45:54 -0500
From: Peng Li <lipeng@acm.org>
To: linux-kernel@vger.kernel.org
Subject: 512MB/1GB RAM & Wireless Card
Message-ID: <20031028064554.GA20596@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are impatient to read this message, please jump to the middle
to see the exciting part.

Machine: IBM X31 2672E4U, P-M 1.4GHz, BIOS 2.01a, 1GB RAM(512MB DIMMx2)
OS:      Linux 2.6.0-test9, Gentoo Linux

Problem: I installed an Dell Truemobile 1150 MINI PCI wireless card (a
rebranded orinoco gold) on this machine and it didn't work.  The card
worked perfectly in Windows, but when I use it in Linux, the PCMCIA
driver could not find the device.

The card bus seemed to work well: it was recogonized as a PCI device,
and yenta_socket was loaded without any problem.  However, cardctl
reported that there was no card in the slots. Here are the info:

http://www.seas.upenn.edu/~lipeng/x31info/1G.NOHIMEM.cardctl.txt
http://www.seas.upenn.edu/~lipeng/x31info/1G.NOHIMEM.lspci.txt
http://www.seas.upenn.edu/~lipeng/x31info/1G.NOHIMEM.dmesg.txt
http://www.seas.upenn.edu/~lipeng/x31info/

I exhausted the combination of (bios_version, kernel_version,
kernel_param) and spent several days trying to get it to work.
Totally frustrated.  All the options such as CONFIG_NOHIGHMEM,
CONFIG_HIGHIO, ... were attempted.  Finally I opened the my laptop
trying to reprogram the wireless card with my screwdrivers and
hammers...

 *********** EXCITING PART HERE ************

IT WORKED!!  When I unplugged one DIMM of the memory and boot it
with 512MB of memory, it worked perfectly without any problem:

http://www.seas.upenn.edu/~lipeng/x31info/512M.NOHIMEM.cardctl.txt
http://www.seas.upenn.edu/~lipeng/x31info/512M.NOHIMEM.dmesg.txt
http://www.seas.upenn.edu/~lipeng/x31info/512M.NOHIMEM.lspci.txt

But when I used it with 1GB RAM again, the card mysteriously
dissappeared.  All the kernel options doesn't seem to help.  Even I
boot the kernel with mem=256m, the card still didn't work unless I
physically unplug one DIMM of memory. Compiling the kernel with 4GB
support doesn't seem to make a difference.

So what's the problem?  Is it a bug in the kernel or am I doing
something stupid?  Any suggestions are greatly appreciated.

  -- Peng



