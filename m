Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318328AbSGRTHa>; Thu, 18 Jul 2002 15:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318329AbSGRTHa>; Thu, 18 Jul 2002 15:07:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34805 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318328AbSGRTH3>; Thu, 18 Jul 2002 15:07:29 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020718144203.1123A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020718144203.1123A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 12:10:14 -0700
Message-Id: <1027019414.1085.143.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 11:56, Richard B. Johnson wrote:

> What should have happened is each of the tasks need only about
> 4k until they actually access something. Since they can't possibly
> access everything at once, we need to fault in pages as needed,
> not all at once. This is what 'overcomit' is, and it is necessary.

I should also mention this is demand paging, not overcommit.

Overcommit is the property of succeeded more allocations than their is
memory in the address space.  The idea being that allocations are lazy,
things often do not use their full allocations, etc. etc. as you
mentioned.

It is typical a good thing since it lowers VM pressure.

It is not always a good thing, for numerous reasons, and it becomes
important in those scenarios to ensure that all allocations can be met
by the backing store and consequently we never find ourselves with more
memory committed than available and thus never OOM.

This has nothing to do with paging and resource limits as you say.  Btw,
without this it is possible to OOM any machine.  OOM is a by-product of
allowing overcommit and poor accounting (and perhaps poor
software/users), not an incorrectly configured machine.

	Robert Love

