Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUCaJNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUCaJNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:13:12 -0500
Received: from deliver.epitech.net ([163.5.0.25]:62865 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S261867AbUCaJNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:13:10 -0500
Date: Wed, 31 Mar 2004 11:12:48 +0200
From: Marc Bevand <bevand_m@epita.fr>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040331091248.GA11721@nash.epita.fr>
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr> <4069B16F.7020306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069B16F.7020306@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Mar 2004, Jeff Garzik wrote:
| Marc Bevand wrote:
| >I think I am reaching the physical limit of the PCI bus (theoretically it
| >would be 133 MB/s or 133000 blocks/s). When setting the PCI latency 
| >timer of
| >the SiI3114 controller to 240 (was 64), I am able to reach 100000 blocks/s.
| 
| That's interesting.
| 
| I wonder if we should look at making pci_set_master()'s latency timer 
| setting code be a bit smarter.

AFAIK choosing the optimal latency timer for each device on a PCI bus is
not a trivial thing, one needs to take into account a lots of things.
But making it a "bit smarter" would be "good enough".

| It (pcibios_set_master in arch/i386/pci/i386.c) current checks the 

Actually my arch is x86_64 ;-) But I guess the code is very similar.

| latency timer value programmed by the BIOS.  If the BIOS did not 
| initialize the value, then it is set to 64.  Otherwise, it is clamped to 
| the maximum 255.
| 
| I wonder if your BIOS shouldn't increase that latency timer value...?

My BIOS seems to always initialize the latency timer. There is a menu
in which one can choose the value (32, 64, 96, etc), and the default
setting (when "loading failsafe settings" or "loading optimized
settings") is 64 (that is where the value is coming from). The BIOS
does not offer an "auto" value that would be computed dynamically for
optimal performances.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
