Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWFHHn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWFHHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWFHHn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:43:29 -0400
Received: from gw.openss7.com ([142.179.199.224]:32446 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932546AbWFHHn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:43:28 -0400
Date: Thu, 8 Jun 2006 01:43:26 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Message-ID: <20060608014326.B12202@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	adilger@clusterfs.com, linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606080851.20232.ak@suse.de> <20060608010004.A12202@openss7.org> <200606080907.26350.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606080907.26350.ak@suse.de>; from ak@suse.de on Thu, Jun 08, 2006 at 09:07:26AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Thu, 08 Jun 2006, Andi Kleen wrote:
> 
> AFAIK gcc mostly uses the probability information for block reordering
> to make the fast path fall through without jumps.

After a quick try on RH EL4 gcc 3.4.4-2 it appears that
-fno-reorder-blocks indeed defeats __builtin_expect() as you
say.  (Which is rather bizarre as __builtin_expect() no longer
does what one expects.)  I think that I'm going to strip it out
for my externally compiled modules.  Otherwise, the source code
rearrangements necessary to get the same effect will make the
source code unreadable and generate larger code, which I think
is worse than those effects on the assembler code.
	
Thanks again.

--brian
