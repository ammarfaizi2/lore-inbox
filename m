Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTL2WRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTL2WRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:17:18 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:26816 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264286AbTL2WRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:17:16 -0500
Date: Mon, 29 Dec 2003 23:17:01 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: mochel@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0 - Suspend to disk (pmdisk) resets when resume
Message-ID: <20031229221701.GI916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

suspend to disk is not working (resume part) on my laptop. I did some debugging
and I've found following:

suspend part seems to be ok
resume part seems to be ok if I was not running X server
resume part hardly resets my laptop if I was running X server

reset is performed in arch/i386/power/pmdisk.S during copying pages back to
memory. 
if I do printk each destination pointer it resets on address 0xc03ee00 that is
an address to kernel space around console and framebuffer code.

following is with X server running:

if I force to copy only first 1869 pages then it does not reset.
if I force to copy only from page 1950 to the last then it does not reset.
if I force to copy each page except a range 1869-1950 then it resets.
if I force to not copy any reserved page than it hangs after resume but does not
reset.

page 1869 is far behind the kernel code.


I wonder how could kernel reset only after some pages are copied :(

I have intel graphic card i852 integrated with shared memory.

-- 
Luká¹ Hejtmánek
