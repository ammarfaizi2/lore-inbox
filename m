Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWGNKnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWGNKnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWGNKnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:43:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49821 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161029AbWGNKnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:43:16 -0400
Date: Fri, 14 Jul 2006 03:42:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, ak@suse.de, acahalan@gmail.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, roland@redhat.com
Subject: Re: utrace vs. ptrace
Message-Id: <20060714034244.87b95930.pj@sgi.com>
In-Reply-To: <20060713194735.GA27807@elte.hu>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com>
	<200607131437.28727.ak@suse.de>
	<20060713124316.GA18852@elte.hu>
	<200607131521.52505.ak@suse.de>
	<Pine.LNX.4.64.0607131203450.5623@g5.osdl.org>
	<20060713194735.GA27807@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> it wouldnt be fundamentally easier - but lots of policy stuff could be 
> done there which we would otherwise reject to add to the kernel. Like 
> more complex rules for "do we want to dump core for this particular 
> app".

Reading this brought to mind the 'user exit' hooks that are common
in IBM's mainframe O.S.'s.

Their system code does what system code does (and likely a whole lot
more than Linux would consider doing.)  But they also provide many
places for user level code to get called off a variety of hooks,
to allow for special cases.

I had fantasies of our core dumping code using call_usermodehelper()
to call a user command by a well known path, passing it the pid of
the corpse.  While waiting for the user command to exit, the kernel
would accept non-default core dump settings via special /sys or /proc
files for that pid.  The user mode helper command could set these
options before returning (by exiting) to the kernel for the core dump
to be processed.  By default, the user command would do nothing but
exit and the core dump would proceed as it does now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
