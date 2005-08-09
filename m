Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVHIVKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVHIVKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVHIVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:10:16 -0400
Received: from verein.lst.de ([213.95.11.210]:19110 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964967AbVHIVKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:10:14 -0400
Date: Tue, 9 Aug 2005 23:10:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Howard <ghoward@sgi.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: Standardize shutdown of the system from enviroment control modules
Message-ID: <20050809211003.GA29361@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently snsc_event for Altix systems sends SIGPWR to init (and abuses
tasklist_lock..) while the sbus drivers call execve for /sbin/shutdown
(which is also ugly, it should at least use call_usermodehelper)
With normal sysvinit both will end up the same, but I suspect the
shutdown variant, maybe with a sysctl to chose the exact path to call
would be cleaner.  What do you guys think about adding a common function
to do this.  Could you test such a patch for me?
