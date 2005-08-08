Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVHHVQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVHHVQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVHHVQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:16:21 -0400
Received: from [203.171.93.254] ([203.171.93.254]:14030 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932239AbVHHVQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:16:20 -0400
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Patrick Mochel <mochel@digitalimplant.org>,
       Christoph Lameter <christoph@lameter.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost>
	 <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
	 <1123243967.3266.2.camel@localhost>
	 <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123503537.3969.525.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 08 Aug 2005 22:18:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Now that I've actually done some work toward getting it to work with
Suspend2, I'll give a more cogent response to Christoph's approach.

I believe it can work, but the algorithm in freeze() is a bit of a
concern.

Checking whether the todo list is empty is fine while we're the only
user, but when other functionality is using this, it will be unreliable.
We'll either need a quick way to check what todo work is pending for a
task (traverse list would be racy). We can't say "We know we signalled
them all already" because more might have forked.

One possibility might be to leverage the existing counting - when
num_signalled = num_frozen, we can signal a new batch with impunity. But
this assumes everything signalled properly enters the fridge (which
might not always be guaranteed).

Perhaps it's best to keep PF_FREEZING? Perhaps there's another
possibility.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

