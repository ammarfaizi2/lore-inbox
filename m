Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264401AbUEIWRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbUEIWRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEIWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:17:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264401AbUEIWRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:17:14 -0400
Date: Sun, 9 May 2004 23:17:12 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
Message-ID: <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <409DDDAE.3090700@colorfullife.com> <20040509153316.GE4007@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040509153316.GE4007@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 09:03:16PM +0530, Dipankar Sarma wrote:
 
> Actually, what may happen is that since the dentries are added
> in the front, a double move like that would result in hash chain
> traversal looping. Timing dependent and unlikely, but d_move_count
> avoided that theoritical possibility. It is not about skipping
> dentries which is safe because a miss would result in a real_lookup()

Not really.  A miss could result in getting another dentry allocated
for the same e.g. directory, which is *NOT* harmless at all.
