Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265811AbUGAPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUGAPKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUGAPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:10:37 -0400
Received: from the-village.bc.nu ([81.2.110.252]:18636 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265811AbUGAPKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:10:33 -0400
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, vojtech@suse.cz,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
In-Reply-To: <20040701131158.GP698@openzaurus.ucw.cz>
References: <1088266111.1943.15.camel@mulgrave>
	 <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	 <1088268405.1942.25.camel@mulgrave>
	 <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
	 <20040701131158.GP698@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088690821.4621.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 01 Jul 2004 15:07:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-07-01 at 14:11, Pavel Machek wrote:
> Heh, with vojtech we introduced locking into input layer
> (there was none before)... using test_bit/set_bit.
> 
> (I just hope set_bit etc implies memory barrier... or we'll have to do
> it once more)
		
It doesn't - the ppp layer got burned badly by this long ago. set_bit is
not a memory barrier. OTOH you can just add an mb()

With respect to the need for a get_jiffies API I don't think you 
do need it for ratelimit.

	static DECLARE_TIMEOUT_EXPIRED(printk_timer);

	if(timeout_expired(t))
	{
		printk("Blah");
		timeout_set(t, 5 * HZ);
	}

if we followed the way MUTEX and the other defines work.




