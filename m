Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSG2VP2>; Mon, 29 Jul 2002 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318192AbSG2VP1>; Mon, 29 Jul 2002 17:15:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57863 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318191AbSG2VP1>;
	Mon, 29 Jul 2002 17:15:27 -0400
Date: Mon, 29 Jul 2002 22:18:49 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Matthew Wilcox'" <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-ia64@linuxia64.org'" <linux-ia64@linuxia64.org>
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Message-ID: <20020729221849.C3317@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AE@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F3AE@usslc-exch-4.slc.unisys.com>; from kevin.vanmaren@unisys.com on Mon, Jul 29, 2002 at 04:05:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 04:05:35PM -0500, Van Maren, Kevin wrote:
> Recursive read locks certainly make it more difficult to fix the
> problem.  Placing a band-aid on gettimeofday will fix the symptom
> in one location, but will not fix the general problem, which is
> writer starvation with heavy read lock load.  The only way to fix
> that is to make writer locks fair or to eliminate them (make them
> _all_ stateless).

The basic principle is that if you see contention on a spinlock, you
should eliminate the spinlock somehow.  making spinlocks `fair' doesn't
help that you're spending lots of time spinning on a lock.

-- 
Revolutions do not require corporate support.
