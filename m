Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTIBVzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTIBVzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:55:49 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:40711 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263888AbTIBVzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:55:45 -0400
Date: Tue, 2 Sep 2003 23:55:43 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: steveb@unix.lancs.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: corruption with A7A266+200GB disk?
Message-ID: <20030902235543.B1627@pclin040.win.tue.nl>
References: <E19uBCi-00054b-00@wing0.lancs.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E19uBCi-00054b-00@wing0.lancs.ac.uk>; from steveb@unix.lancs.ac.uk on Tue, Sep 02, 2003 at 02:28:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 02:28:16PM +0100, steveb@unix.lancs.ac.uk wrote:

> I just got a new 200GB disk (WDC WD2000JB) for my home machine (Asus A7A266,
> Ali chipset). I put some partitions on it like so:
>   hda1:   100MB - /boot
>   hda2:  8192MB - /
>   hda3:  1024MB - swap
>   hda4:  the rest (about 190GB I guess) - /home
> 
> I find that when I mkfs on /home, I get massive filesystem corruption on /
> When I fsck / (and restore the deleted files) I get massive filesystem corruption on /home.
> 
> so...anyone else seen this? Is it a known driver problem?

No doubt wraparound at 137 GB. (2^28 sectors of 2^9 bytes gives a 2^37 byte,
that is 128 GiB limit; to get past this you need support for lba48)

Recently we discussed a case where Linux decided that the hardware
could not handle lba48 but forgot to adapt the total capacity.
That was a Linux bug.

In fact, if I am not mistaken, the idea that that hardware could not
handle lba48 was due to a misunderstanding. That was another Linux bug.

Maybe these have now been fixed in some kernel versions.

So, you must check (i) what Linux thinks your hardware can do, and
(ii) what your hardware can do in reality.
Maybe the former can be seen in /proc/ide/hdX/settings under "address"
or so.

