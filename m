Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVJFXbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJFXbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVJFXbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:31:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30403 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932070AbVJFXbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:31:45 -0400
Date: Fri, 7 Oct 2005 00:31:37 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rick Lindsley <ricklind@us.ibm.com>, Robert Derr <rderr@weatherflow.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       amitarora@in.ibm.com, suzukikp@in.ibm.com,
       Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: 2.6.13.3 Memory leak, names_cache
Message-ID: <20051006233137.GY7992@ftp.linux.org.uk>
References: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com> <Pine.LNX.4.64.0510061428340.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510061428340.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 02:31:38PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 6 Oct 2005, Rick Lindsley wrote:
> > 
> > The code in open_namei() is a bit non-intuitive in error conditions,
> > but the general fix appears to be pretty straightforward.  Let me know if
> > this patch seems to do the trick for you.
> 
> This patch seems to be correct.
> 
> As far as I can tell, the name in "last.name" has always been allocated 
> with "__getname()", and it should thus always be free'd with "__putname()" 
> in order to not cause trouble with the horrible AUDITSYSCALL code.
> 
> Now, very arguably the real bug is that bug-prone code in AUDITSYSCALL, 
> but I suspect that for 2.6.14 I should just apply this patch.
> 
> Al? Any comments? (Full patch quoted here in case you haven't followed the 
> mailing list)

ACK, and the only comment is that audit crap would be better off in /dev/null.
Too late for that now, unfortunately...
