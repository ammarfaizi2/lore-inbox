Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUB1Mqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbUB1Mqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:46:49 -0500
Received: from ns.suse.de ([195.135.220.2]:39126 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261839AbUB1Mqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:46:48 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
References: <20040227173250.GC8834@dualathlon.random>
	<Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
	<20040227122936.4c1be1fd.akpm@osdl.org>
	<20040227211548.GI8834@dualathlon.random>
	<162060000.1077919387@flay>
	<20040228023236.GL8834@dualathlon.random>
	<20040228045713.GA388@ca-server1.us.oracle.com>
	<20040228061838.GO8834@dualathlon.random>
From: Andi Kleen <ak@suse.de>
Date: 28 Feb 2004 13:46:47 +0100
In-Reply-To: <20040228061838.GO8834@dualathlon.random.suse.lists.linux.kernel>
Message-ID: <p73eksf4big.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:
> 
> we can add a config option to enable together with 2.5:1.5 to drop the
> gap page in vmalloc, and to reduce the vmalloc space, so that we can
> sneak another few "free" dozen megs back for the 64G kernel just to get
> more margin even if we don't strictly need it. (btw, the vmalloc space
> is also tunable at boot, so this config option would just change the
> default value)

Not sure if that would help, but you could relatively easily save
8 bytes on 32bit for each vma too. Replace vm_next with rb_next()
and move vm_rb.color into vm_flags. It would be a lot of editing
work though. NUMA API will add new 4 bytes again. 

-Andi
