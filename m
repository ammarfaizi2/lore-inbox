Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUHCViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUHCViD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUHCViD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:38:03 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:44779 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266891AbUHCVhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:37:12 -0400
Date: Tue, 3 Aug 2004 23:36:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803213634.GK2241@dualathlon.random>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803211339.GB26620@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 11:13:39PM +0200, Arjan van de Ven wrote:
> The user that mlock'd gets to pay for it, and gets his credits back at
> munlock. Chown doesn't really matter in that regard..... The thing that does

what? he cannot get credits when it munlock if this is hugetlbfs. If it
does you're again into the insecure DoS scenario.

btw, I don't see where you call user_subtract_mlock when the file is
truncated.

what exactly are you trying to do in that patch? I thought you were
binding the storage to a certain user structure _persistently_. Which
breaks badly with chown since if the admin chown the file to root.root
then you cannot truncate it anymore but you're locked up completely and
you cannot use mlock anymore and you've to send email to the admin
asking to reassing the file to you so that you can truncate it.

If you're calling user_subtract_mlock at unlock time (not at truncate
time) then it has the same issues that the patch I've rejected some
months ago when I wrote the disable_cap_mlock.
