Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUEOS5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUEOS5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEOS5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 14:57:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264360AbUEOS5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 14:57:43 -0400
Message-ID: <40A66819.9040806@pobox.com>
Date: Sat, 15 May 2004 14:57:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: shai@ftcon.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Multiple (ICH3) IDE-controllers in a system
References: <200405151813.i4FIDoqt029818@hera.kernel.org>
In-Reply-To: <200405151813.i4FIDoqt029818@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1627, 2004/05/15 09:42:40-07:00, shai@ftcon.com
> 
> 	[PATCH] Multiple (ICH3) IDE-controllers in a system
> 	
> 	This fixes a problem with multiple IDE controllers in a system.
> 	
> 	The problem is that pcibios_fixups table (in arch/i386/pci/fixup.c) uses
> 	the pci_fixup_ide_trash() quirk for Intel's ICH3 (my case specifically
> 	8086:248b).  This clears any bogus BAR information set up by the BIOS.
> 	
> 	In a system which has multiple ICH3's can't use any of the IDE
> 	controllers beside the one on the first ICH3.
> 	
> 	Anyhow, the fix is to make sure pci_fixup_ide_trash resets the BARs only
> 	for first time being called, so the subsequent IDE controllers will use
> 	the BIOS BARs.  This is better than "loosing" all these IDE controllers
> 	in the case their BARs set right.

I do not think this is correct.

The programming interface register tells us if we're in legacy or native 
mode, which is what this fixup is concerned with, AFAICS.

So, the code should base its actions on whether or not the controller is 
in legacy mode, _not_ ordering.

	Jeff


