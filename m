Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbTBSDx1>; Tue, 18 Feb 2003 22:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTBSDx1>; Tue, 18 Feb 2003 22:53:27 -0500
Received: from rth.ninka.net ([216.101.162.244]:5515 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267951AbTBSDx1>;
	Tue, 18 Feb 2003 22:53:27 -0500
Subject: Re: [PATCH][2.5] convert atm_dev_lock from spinlock to semaphore
From: "David S. Miller" <davem@redhat.com>
To: Matthew Wilcox <willy@debian.org>
Cc: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk>
References: <20030219025347.D22992@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Feb 2003 20:47:36 -0800
Message-Id: <1045630056.10926.4.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 18:53, Matthew Wilcox wrote:
> you seem to be under the impression that <linux/sem.h> has something
> to do with linux semaphores.  this is not the case; they're sysv semaphores.

I agree, this bit has to be fixed.

> atm really needs fixing properly.

True, but his change by itself is OK.  All of the places where
atm_dev_lock is acquired it is safe to do things like sleep.

While checking this I notice that atm_alloc_dev uses GFP_ATOMIC
thus unnecessarily.

Anyways, Matt, without a full time ATM maintainer and having basically
nobody who wants to take that on, we should take the small fixes when
they do occur and are correct as Chas's patch is.

