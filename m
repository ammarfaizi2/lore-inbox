Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVCTNpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVCTNpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCTNpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:45:54 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:17292 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261216AbVCTNpq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:45:46 -0500
Date: Sun, 20 Mar 2005 14:50:13 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.2][RFC] printk with anti-cluttering-feature
In-Reply-To: <423D6353.5010603@tls.msk.ru>
Message-ID: <Pine.LNX.4.58.0503201425080.2886@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Michael Tokarev wrote:
> Bodo Eggert wrote:

> > (please CC me on reply)
> > 
> > Issue:
> > 
> > On some conditions, the dmesg is spammed with repeated warnings about the
> > same issue which is neither critical nor going to be fixed. This may
> > result in losing the boot messages or missing other important messages.
> 
> There's printk_ratelimit() already, used in quite several places in kernel
> (or net_ratelimit() for net/* stuff).  See also Documentation/sysctl/kernel.txt,
> search for printk_ratelimit.  JFYI.

ACK, but that's designed to work against a DoS, not against cluttering the 
log. The messages I want to suppress are low-frequent.

I now realize that some of these warnings may be triggered by userspace, 
and since userspace-triggered warnings are a possible DoS, these parts of 
code should be rate-limited, too. I think it's best to include a 
rate-limit check in my printk_nospam to make it work against slow log 
spamming _and_ DoS.

-- 
"Don't ever be the first, don't ever be the last, and don't ever
volunteer to do anything."
-U. S Navy Swabbie
Friﬂ, Spammer: vital@sam2342343.com nlhl@1094kdsd.com
