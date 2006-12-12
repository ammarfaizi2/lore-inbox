Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbWLLGkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWLLGkL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWLLGkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:40:11 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55458 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbWLLGkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:40:09 -0500
Date: Tue, 12 Dec 2006 15:43:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
Message-Id: <20061212154354.90b39a7c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061211220617.669da2d5.akpm@osdl.org>
References: <20061211005807.f220b81c.akpm@osdl.org>
	<20061212145341.a5f335a0.kamezawa.hiroyu@jp.fujitsu.com>
	<20061211220617.669da2d5.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 22:06:17 -0800
Andrew Morton <akpm@osdl.org> wrote:
> > When I use ftp on 2.6.19-mm1, transfered file is always broken.
> > like this:
> > ==
> > [kamezawa@casares ~]$ file ./linux-2.6.19.tar.bz2 (got on 2.6.19-mm1)
> > ./linux-2.6.19.tar.bz2: data
> > (I confirmed original file was not broken.)
> 
> Yes, a couple of people have reported things like this.  Strange. 
> test.kernel.org is showing mostly-green.  There's one fsx-linux failure (for
> unclear reasons) on one of the x86_64 machines, all the rest are happy.
> 
> Which filesystem were you using?
> 
using ext3.
> Can you investigate it a bit further please??  reboot, re-download, work
> out how the data differs, etc?
> 
Hmm, this is summary of broken linux-2.6.19.tar.bz2 file (used od and diff) 

offset 000000 -> 000b4f  zero cleared.
offset 000b50 -> 000fff  not broken
offset 001000 -> 001c47  zero cleared
offset 001c48 -> 001fff  not broken
offset 002000 -> 002d39  zero cleared
offset 002d40 -> 003fff  not broken.
offset 004000 -> 004f2f  zero cleared
offset 004f30 -> 004fff  not broken
offset 005000 -> 005a79  zero cleared
offset 005a80 -> 005fff  not broken
offset 006000 -> 006b7f  zero cleared
offset 006b80 -> 007fff  not broken
.......
 
All broken parts are always zero-cleared and start from offset 
aligned to 0x1000. (note: broken kernel's PAGE_SIZE is 16384)

I'll do AMAP.

-Kame









