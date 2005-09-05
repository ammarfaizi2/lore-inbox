Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVIEIir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVIEIir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVIEIir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:38:47 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36707
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932373AbVIEIiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:38:46 -0400
Message-Id: <431C20560200007800023E6F@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 05 Sep 2005 10:39:18 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <stsp@aknet.ru>, <vandrove@vc.cvut.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas, Petr,

I know it's been a while since this was discussed and integrated into
mainline, but I just now came across this, and following all of the
original discussion that I was able to locate I didn't see any mention
of a potential different approach to solving the problem which, as it
would appear to me, requires much less code changes: Instead of
allocating a separate stack to set intermediately, the 16-bit stack
segment could be mapped directly onto the normal, flat kernel stack,
thus requiring only an in-place stack change (without any copying of
contents) and an adjustment to the __switch_to code to change the base
address of that segment. Since this approach seems fairly natural I'm
sure it was actually considered, and I'd be curious to learn why it
wasn't chosen.

Thanks, Jan
