Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbTHCTSk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTHCTSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:18:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:47490 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S269321AbTHCTSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:18:34 -0400
Date: Sun, 3 Aug 2003 21:18:33 +0200
From: bert hubert <ahu@ds9a.nl>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803191833.GA13803@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, devik@cdi.cz
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803191102.GA29616@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803191102.GA29616@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 09:11:02PM +0200, Willy Tarreau wrote:

> Why not make this change dynamic instead ? eg : your system boots unlocked,
> and definitely locks /dev/{,k}mem once you do something such as
> 
>   echo foo > /proc/path_to_magic_entry
 
I thought about something like that but then for loading modules too - which
would allow for a modular boot but a lock afterwards.

> So the same config can be used with kernel with and without X, it's just a
> matter of runtime configuration. It could even be a sysctl, as long as there's
> no way to unset it.

Well, I fear the runtime overhead - as it is, I suspect this patch is
somewhat inflamatory anyhow ('tough luck you were hacked', 'you are fscked
anyhow').

However, the check would be in {,k}mem_open and in sys_init_module, which
are not heavily used functions.

I'll whip up a dynamic patch soonish - I'm unsure about the right location,
/proc/sys/ something?

Thanks.
-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
