Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUFWKg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUFWKg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFWKg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 06:36:28 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:13475 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S265258AbUFWKgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 06:36:16 -0400
Date: Wed, 23 Jun 2004 19:32:34 +0900 (JST)
Message-Id: <20040623.193234.60195426.taka@valinux.co.jp>
To: ashwin_s_rao@yahoo.com
Cc: Valdis.Kletnieks@vt.edu, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: Atomic operation for physically moving a page (for memory
 defragmentation)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
References: <200406190103.i5J13WWr010687@turing-police.cc.vt.edu>
	<20040619031536.61508.qmail@web10902.mail.yahoo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > I want to copy a page from one physical location
> > to
> > > another (taking the appr. locks).
> > 
> > At the risk of sounding stupid, what problem are you
> > trying to solve by copying
> > a page? Not only (as you note) could the page be
> > referenced by multiple
> > processes, it could (conceivably) belong to a kernel
> > slab or something, or be a
> > buffer for an in-flight I/O request, or any number
> > of other possibly-racy
> > situations.
> 
> The problem is the memory fragmentation. The code i am
> writing is for the memory defragmentation as proposed
> by Daniel Phillips, my project partner Alok mooley has
> given mailed a simple prototype in the mid of feb.

If you only care about anonymous memory, how do you think
about expanding the COW mechanism?

  1. make all pages COW in a process space.
  2. force to cause COW fault on the each page.
  3. copy from the page to a new allocated page, and discard the old page.

You may preallocate new pages.


Thank you,
Hirokazu Takahashi.
