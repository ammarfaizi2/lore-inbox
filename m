Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCTPZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCTPZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 10:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVCTPZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 10:25:44 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:5644 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261223AbVCTPZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 10:25:36 -0500
Message-ID: <423D95EC.405@monro.org.uk>
Date: Mon, 21 Mar 2005 01:55:32 +1030
From: David Monro <davidm@monro.org.uk>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10, alpha, "Relocation overflows"
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get 2.6.10 running on my SMP ds20 alpha system. Kernel 
compiles fine, but _some_ modules fail to load once running, in 
particular the ipv6 and scsi ones (there may be more, but those are the 
ones I'm noticing).

The error is "Relocation overflow vs section 25" for ipv6 (scsi_mod says 
section 27 instead). Adding a few printks, it seems that its always the 
R_ALPHA_GPRELHIGH case (line 265 of arch/alpha/kernel/module.c), and as 
far as I can tell, the problem is that "value" is more than 0x8000 less 
than "gp" which results in a negative value...

This is using gcc version 3.3.5 (Debian 1:3.3.5-8). I tried using gcc 
2.95 (gcc version 2.95.4 20011002 (Debian prerelease)), but that gets a 
parse error on line 55 of arch/alpha/kernel/traps.c. (What compiler 
_should_ I be using? The documentation seems to indicate gcc 2.95.3, but 
I'm finding that hard to believe).

I can't go forward to 2.6.11 because thats missing _raw_read_trylock for 
alpha, and there doesn't appear to be a patch for that yet. 2.6.8 UP 
works, but SMP just hangs when probing the DAC960 raid controller. Is 
SMP alpha just not very well tested at the moment?

Cheers,

	David
