Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVARSbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVARSbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVARSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:31:17 -0500
Received: from palrel12.hp.com ([156.153.255.237]:14476 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261369AbVARSbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:31:14 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16877.21998.984277.551515@napali.hpl.hp.com>
Date: Tue, 18 Jan 2005 10:31:10 -0800
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: pipe performance regression on ia64
In-Reply-To: <Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
References: <200501181741.j0IHfGf30058@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0501180951050.8178@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 18 Jan 2005 10:11:26 -0800 (PST), Linus Torvalds <torvalds@osdl.org> said:

  Linus> I don't know how to make the benchmark look repeatable and
  Linus> good, though.  The CPU affinity thing may be the right thing.

Perhaps it should be split up into three cases:

	- producer/consumer pinned to the same CPU
	- producer/consumer pinned to different CPUs
	- producer/consumer lefter under control of the scheduler

The first two would let us observe any changes in the actual pipe
code, whereas the 3rd case would tell us which case the scheduler is
leaning towards (or if it starts doing something real crazy, like
reschedule the tasks on different CPUs each time, we'd see a bandwith
lower than case 2 and that should ring alarm bells).

	--david
