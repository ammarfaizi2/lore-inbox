Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVIKLyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVIKLyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVIKLyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:54:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43712 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbVIKLyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:54:39 -0400
Date: Sun, 11 Sep 2005 04:54:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Miguel <frankpoole@terra.es>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <20050911085312.GA13732@midnight.suse.cz>
Message-ID: <Pine.LNX.4.58.0509110452220.4912@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org> <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
 <20050911030814.08cbe74c.frankpoole@terra.es> <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
 <20050911085312.GA13732@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Vojtech Pavlik wrote:
> 
> This is interesting. The 0x00000001 means that it's supposed to be an
> unassigned I/O (!) space resource ... which obviously fools the if()
> statement.

No. ROM resources really are special. They are always MMIO, and the low 
bit is used to specify whether they are "enabled" or not.

Yes, it's ugly as hell. Total special case.

Anyway, the resource value of 0x00000001 shouldn't fool the if-statement 
at all, because when we fill in the resource "start" values, we correctly 
mask off the status bits, and save those into the resource "flags".  So 
the PCI resource start should be 0, and that if-statement shouldn't have 
triggered.

		Linus
