Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbULPH2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbULPH2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbULPH2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:28:04 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:61904 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262624AbULPH2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:28:01 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V2
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain.suse.lists.linux.kernel>
	<156610000.1102546207@flay.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412091130160.796@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
	<200412132330.23893.amgta@yacht.ocn.ne.jp.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412130905140.360@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
	<8880000.1102976179@flay.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412131730410.817@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Dec 2004 08:27:59 +0100
In-Reply-To: <Pine.LNX.4.58.0412131730410.817@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
Message-ID: <p73hdmmog74.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:
> 
> If a fault occurred for page x and is then followed by page x+1 then it may
> be reasonable to expect another page fault at x+2 in the future. If page
> table entries for x+1 and x+2 would be prepared in the fault handling for
> page x+1 then the overhead of taking a fault for x+2 is avoided. However
> page x+2 may never be used and thus we may have increased the rss
> of an application unnecessarily. The swapper will take care of removing
> that page if memory should get tight.

I would be very careful with this. Windows does something like this
by default and one application that I know needs twice as much swap+memory
on Windows than on Linux because of this. Since it uses a lot of memory
it would be a bad regression.

When you add it there should be at least some easy way for an application
to turn it off (madvise and probably sysctl?) and make the heuristic very 
conservative.

-Andi
