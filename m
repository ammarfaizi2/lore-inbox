Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTKEXDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTKEXDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:03:53 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:22969 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263285AbTKEXDw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:03:52 -0500
Date: Wed, 5 Nov 2003 15:03:50 -0800
From: Larry McVoy <lm@bitmover.com>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031105230350.GB12992@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chad Kitching <CKitching@powerlandcomputers.com>,
	linux-kernel@vger.kernel.org
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 04:48:09PM -0600, Chad Kitching wrote:
> From: Zwane Mwaikambo
> > > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > > +                       retval = -EINVAL;
> > 
> > That looks odd
> > 
> 
> Setting current->uid to zero when options __WCLONE and __WALL are set?  The 
> retval is dead code because of the next line, but it looks like an attempt
> to backdoor the kernel, does it not?

It sure does.  Note "current->uid = 0", not "current->uid == 0". 
Good eyes, I missed that.  This function is sys_wait4() so by passing in
__WCLONE|__WALL you are root.  How nice.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
