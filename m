Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUIQUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUIQUgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268981AbUIQUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:36:51 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:34999 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S268950AbUIQUfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:35:30 -0400
Date: Fri, 17 Sep 2004 22:34:58 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Via-Rhine WOL vs PXE Boot
Message-ID: <20040917203458.GA12779@k3.hellgate.ch>
Mail-Followup-To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>,
	linux-kernel@vger.kernel.org
References: <200409172154.36550.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409172154.36550.lists@kenneth.aafloy.net>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 21:54:36 +0200, Kenneth Aafløy wrote:
> In recent kernels I have been having trouble booting from a LAN with the built
> in PXE firmware in my Via Epia M10k board. This will never happen after a 
> cold-boot. But do accur after the first reboot or power-down/power-up cycle. 
> When this occurs the PXE firmware exits with no error, as at least a 
> unplugged wire (from cold-boot) will yield an error message with the 
> unchanged driver. Cold-boot refers to complete power separation from the 
> motherboard.
> 
> I've traced this down to a specific change in the via-rhine ethernet driver:
[...]

The patch you are referring to contains very little code that affects chip
programming without user intervention (e.g. calling ethtool ioctls). There
is one notable exception: The patch introduces rhine_shutdown which is
called at shutdown (well, duh!). I suppose you can make the problem go away
if you comment out parts of said function. I'd start at the bottom with the
D3 call.

Roger
