Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUH1UAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUH1UAc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267738AbUH1UAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:00:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:43659 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266474AbUH1UAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:00:23 -0400
Date: Sat, 28 Aug 2004 12:58:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][1/3] ipc/ BUG -> BUG_ON conversions
Message-Id: <20040828125816.206ef7fa.akpm@osdl.org>
In-Reply-To: <20040828162633.GG12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de>
	<20040828151544.GB12772@fs.tum.de>
	<098EB4E1-F90C-11D8-A7C9-000393ACC76E@mac.com>
	<20040828162633.GG12772@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
>  > Anything you put in BUG_ON() must *NOT* have side effects.
>  >...
> 
>  I'd have said exactly the same some time ago, but I was convinced by 
>  Arjan that if done correctly, a BUG_ON() with side effects is possible  
>  with no extra cost even if you want to make BUG configurably do nothing.

Nevertheless, I think I'd prefer that we not move code which has
side-effects into BUG_ONs.  For some reason it seems neater that way.

Plus one would like to be able to do

	BUG_ON(strlen(str) > 22);

and have strlen() not be evaluated if BUG_ON is disabled.

A minor distinction, but one which it would be nice to preserve.

