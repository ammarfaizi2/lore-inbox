Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTDYBaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTDYBaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:30:16 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:37885 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S262974AbTDYBaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:30:15 -0400
Date: Fri, 25 Apr 2003 03:42:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel McNeil <daniel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68 2/2] i_size atomic access
Message-ID: <20030425014208.GC26194@dualathlon.random>
References: <1051230056.2448.16.camel@ibm-c.pdx.osdl.net> <20030424180503.2c2a8bea.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424180503.2c2a8bea.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 06:05:03PM -0700, Andrew Morton wrote:
> And if the race _does_ hit, what is the effect?  Assuming stat() was fixed
> with i_sem, I don't think the race has a very serious effect.  We won't

writepage needs it too to avoid returning -EIO and I doubt you want to
take the i_sem in writepage

readpage is another obvious candidate where taking the i_sem is not an
option (even if it's one not risking to lose info in the fs, but it can
lose info in userspace or generate a malfunction).

Andrea
