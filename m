Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVAYDqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVAYDqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVAYDqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:46:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261790AbVAYDpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:45:54 -0500
Date: Mon, 24 Jan 2005 22:45:47 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Tridgell <tridge@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: memory leak in 2.6.11-rc2
Message-ID: <20050125034546.GF13394@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Tridgell <tridge@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20050120020124.110155000@suse.de> <16884.8352.76012.779869@samba.org> <200501232358.09926.agruen@suse.de> <200501240032.17236.agruen@suse.de> <16884.56071.773949.280386@samba.org> <16885.47804.68041.144011@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16885.47804.68041.144011@samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:19:24PM +1100, Andrew Tridgell wrote:
 > The problem I've hit now is a severe memory leak. I have applied the
 > patch from Linus for the leak in free_pipe_info(), and still I'm
 > leaking memory at the rate of about 100Mbyte/minute.
 > I've tested with both 2.6.11-rc2 and with 2.6.11-rc1-mm2, both with
 > the pipe leak fix. The setup is:

That's a little more extreme than what I'm seeing, so it may be
something else, but my firewall box needs rebooting every
few days. It leaks around 50MB a day for some reason.
Given it's not got a lot of ram, after 4-5 days or so, it's
completely exhausted its swap too.

It's currently on a 2.6.10-ac kernel, so it's entirely possible that
we're not looking at the same issue, though it could be something
thats been there for a while if your workload makes it appear
quicker than a firewall/ipsec gateway would.
Do you see the same leaks with an earlier kernel ?

post OOM (when there was about 2K free after named got oom-killed)
this is what slabinfo looked like..

dentry_cache        1502   3775    160   25    1 : tunables  120   60    0 : slabdata    151    151      0
vm_area_struct      1599   2021     84   47    1 : tunables  120   60    0 : slabdata     43     43      0
size-128            3431   6262    128   31    1 : tunables  120   60    0 : slabdata    202    202      0
size-64             4352   4575     64   61    1 : tunables  120   60    0 : slabdata     75     75      0
avtab_node          7073   7140     32  119    1 : tunables  120   60    0 : slabdata     60     60      0
size-32             7256   7616     32  119    1 : tunables  120   60    0 : slabdata     64     64      0

		Dave

