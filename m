Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWADSHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWADSHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWADSHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:07:09 -0500
Received: from mail.gmx.de ([213.165.64.21]:31376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030251AbWADSHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:07:08 -0500
X-Authenticated: #4399952
Date: Wed, 4 Jan 2006 19:07:05 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: patrizio.bassi@gmail.com
Cc: Jaroslav Kysela <perex@suse.cz>, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060104190705.36488cb5@mango.fruits.de>
In-Reply-To: <43BBB7DC.2060303@gmail.com>
References: <4uzow-1g5-13@gated-at.bofh.it>
	<5r0aY-2If-41@gated-at.bofh.it>
	<5r3Ca-88G-81@gated-at.bofh.it>
	<5reGV-6YD-23@gated-at.bofh.it>
	<5reGV-6YD-21@gated-at.bofh.it>
	<5rf9X-7yf-25@gated-at.bofh.it>
	<43BBB7DC.2060303@gmail.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2006 12:56:12 +0100
Patrizio Bassi <patrizio.bassi@gmail.com> wrote:

> that's a big problem. Needs a radical solution. Considering aoss works
> in 50% of cases i suggest aoss improvement and not OSS keeping in kernel.

aoss works _much_ less often than the OSS emulation kernel modules. I'd
rather see (if not just for ease of setup), sw mixing in the OSS
emulation kernel modules. aoss should still continue to exist as it has
some advanced functionality like being able to use any alsa defined pcm
device, but for the vast majority of cases it would be the best if the
OSS emulation kernel module simply finally provided sw mixing.

It might also be worth taking a look at FUSE and stuff like oss2jack
instead, as it would be (imho) the cleaner approach for getting OSS
emulation to userspace as opposed to aoss (device file interface vs.
ugly LD_PRELOAD hack (which has its share of problems. Especially with
apps/libs that resolved the linux system call symbols at compile time -
this is where aoss/LD_PRELOAD won't work, but a FUSE based approach
would)).

Actually i suppose a FUSE based oss2alsa would probably make the old OSS
emulation modules unnecessary if implemented right :) As the relevant
code then lives in userspace it can make trivial use of stuff like ALSA
sw mixing and all other ALSA userspace goodies (which aoss can, too, but
at the cost of being an ugly LD_PRELOAD hack).

Have fun,
Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
