Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVGFXXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVGFXXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVGFXUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:20:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262576AbVGFXUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:20:11 -0400
Date: Wed, 6 Jul 2005 16:20:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Patrick Plattes <patrick@erdbeere.net>
Cc: linux-kernel@vger.kernel.org, aleksander.pavic@t-online.de
Subject: Re: Memory leak with 2.6.12 and cdrecord
Message-Id: <20050706162058.5a5cf927.akpm@osdl.org>
In-Reply-To: <20050705113343.GA6349@erdbeere.net>
References: <20050705113343.GA6349@erdbeere.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Plattes <patrick@erdbeere.net> wrote:
>
> we have some trouble with the 2.6v kernel tree and CDRecord 2.01 (Debian
> Sarge package). If we try to write an 150MB CD the memory fills up to
> 150MB. The memory will not deallocate after closing cdrecord. Next if we
> try to write an 200MB CD the memory will filled up to additional 50MB.
> 
> We don't know which part of the software is steals our memory. This only
> happens on 2.6, not on an 2.4 system and we can reproduce the bug only
> on the asus notebook.
> 
> We have tried to find the leak with top and slabtop, but inconclusively. I 
> put some information together. The informations are taken from the system 
> after burning a 154MB CD. Please have a look at: http://cdrecord.sourcecode.cc . 
> I uploaded the files to this address, to avoid high traffic on the lkml.

That all looks perfectly normal.

MemTotal:       516360 kB
MemFree:        198648 kB
Buffers:          8240 kB
Cached:         263656 kB
SwapCached:          0 kB
Active:         209932 kB
Inactive:        95960 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       516360 kB
LowFree:        198648 kB
SwapTotal:      995988 kB
SwapFree:       995988 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          58472 kB
Slab:             8540 kB
Committed_AS:    97660 kB
PageTables:        548 kB
VmallocTotal:   516052 kB
VmallocUsed:     18324 kB
VmallocChunk:   497676 kB

200M free, 260M in pagecache, all of it (plus anonymous memory) on the LRU.

That pagecache should be reclaimable on demand.

What behaviour makes you believe that there is a leak?
