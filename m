Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265450AbTGCWmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTGCWmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:42:01 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:38817 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id S265450AbTGCWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:42:00 -0400
Date: Thu, 3 Jul 2003 18:56:24 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.21 , large disk write => system crawls
In-Reply-To: <3F04AE6A.8000504@ruault.com>
Message-ID: <Pine.LNX.4.44.0307031848420.7338-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>when i do a large disk write operation ( copy a big file for example ), 
> >>the whole system becomes very busy ( system goes into 99% cpu 

it's not write-specific.  you can see below that you're somehow
managing to trigger roughly two interrupts per *either* bi or bo.
for a normal IDE setup, you should see one interrupt per 16-64K
under average use.  it's almost like your sys somehow thinks
that it can only transfer 1 sector per interrupt!

> everytime i experience a slowdown, there's a 'big' number in the io (bo) 
> column.

no, it's basically in=2*(bi+bo), as if your system somehow believes
it can only do a single sector per interrupt (PIO and -m1 perhaps?)
it should be more like 32K per interrupt.

> Jun 27 22:52:31 charlus kernel: Found and enabled local APIC!

have you tried without that?

