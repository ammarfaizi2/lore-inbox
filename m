Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVBBTJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVBBTJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVBBTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:09:44 -0500
Received: from linux.us.dell.com ([143.166.224.162]:39123 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262415AbVBBTIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:08:00 -0500
Date: Wed, 2 Feb 2005 13:06:26 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Vasily Averin <vvs@sw.ru>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrey Melnikov <temnota+kernel@kmv.ru>, linux-kernel@vger.kernel.org,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
Subject: Re: [PATCH] Prevent NMI oopser
Message-ID: <20050202190626.GB18763@lists.us.dell.com>
References: <41F5FC96.2010103@sw.ru> <20050131231752.GA17126@logos.cnet> <42011EFA.10109@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42011EFA.10109@sw.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:42:02PM +0300, Vasily Averin wrote:
> Marcelo Tosatti wrote:
> >On Tue, Jan 25, 2005 at 11:00:22AM +0300, Vasily Averin wrote:
> >>You should unlock io_request_lock before msleep, like in latest versions
> >>of megaraid2 drivers.
> >
> >Andrey, 
> >
> >Can you please update your patch to unlock io_request_lock before sleeping
> >and locking after coming back? 
> >
> >What the driver is doing is indeed wrong.
> 
> Marcelo,
> 
> This is megaraid2 driver update (2.10.8.2 version, latest 2.4-compatible
> version that I've seen), taken from latest RHEL3 kernel update. I
> believe it should prevent NMI in abort/reset handler.
> 
> Thank you,
> 	Vasily Averin, SWSoft Linux Kernel Team

Thanks Vasily, I was just looking at this again yesterday.

You'll also find that because the driver doesn't define its inline
functions prior to their use, newest compilers refuse to compile this
version of the driver.  Earlier compilers just ignore it and don't
inline anything.

As a hack, one could #define inline /*nothing*/ in megaraid2.h to
avoid this, but it would be nice if the functions could all get
reordered such that inlining works properly, and the need for function
declarations in megaraid2.h would disappear completely.

Thanks,
Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
