Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVCUThK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVCUThK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVCUThK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:37:10 -0500
Received: from colin2.muc.de ([193.149.48.15]:62984 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261669AbVCUThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:37:05 -0500
Date: 21 Mar 2005 20:37:03 +0100
Date: Mon, 21 Mar 2005 20:37:03 +0100
From: Andi Kleen <ak@muc.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] x86_64 : Can not read /dev/kmem ?
Message-ID: <20050321193703.GA2145@muc.de>
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz> <4234A8DD.9080305@aknet.ru> <Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org> <Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org> <423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235695F.5070203@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235695F.5070203@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late answer.

On Mon, Mar 14, 2005 at 11:37:19AM +0100, Eric Dumazet wrote:
> 
> Hi Andi
> 
> I tried to read /dev/kmem on x86_64 (linux-2.6.11) and got no success.
> 
> read() or pread() returns EINVAL

Yes. I fixed this once for 2.4, but somehow the changes never made 
it into 2.6. The VFS code doesn't like negative offsets, and the kernel
addresses are negative.

> 
> I tried mmap() too : mmap() calls succeed, but as soon the user process 
> dereference memory, we get :

Hmm, looks like a bug yes. I can reproduce it. Thanks for the report.
Will investigate later.

-Andi


