Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTJNWVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJNWVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:21:53 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:46318 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S261411AbTJNWVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:21:52 -0400
Date: Tue, 14 Oct 2003 08:17:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: OK to set PF_MEMDIE on cleanup tasks?
Message-ID: <20031014151759.GA2188@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We have tasks that actively return memory to the system, which we
would like to exempt from the OOM killer, as killing such tasks under
low-memory conditions would indeed be counterproductive.  It looks like
the "official" way to do this is to catch/ignore signal 15, which results
in PF_MEMDIE being set (in the 2.6 kernel), thus preventing the OOM killer
from killing the task again.  I don't see where PF_MEMDIE is cleared,
though there are a number of subtle ways one might do this that I would
have missed.

So...  Is it considered legit to simply set PF_MEMDIE when creating
the cleanup task?  Or is there some reason that one should deal with
signal 15?

All enlightenment much appreciated!

						Thanx, Paul
