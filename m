Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVK3WTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVK3WTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVK3WTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:19:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20632 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750946AbVK3WTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:19:44 -0500
Date: Wed, 30 Nov 2005 23:19:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>
Subject: Re: [BUG] Variable stopmachine_state should be volatile
Message-ID: <20051130221931.GB2056@elf.ucw.cz>
References: <8126E4F969BA254AB43EA03C59F44E84040B3069@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84040B3069@pdsmsx404>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The model to access variable stopmachine_state is that a main thread
> writes it and other threads read it. Its declaration has no sign
> volatile. In the while loop in function stopmachine, this variable is
> read, and compiler might optimize it by reading it once before the loop
> and not reading it again in the loop, so the thread might enter dead
> loop.

No. volatile may look like a solution, but it usually is not. You may
need some barriers, atomic_t or locking.
								Pavel
-- 
Thanks, Sharp!
