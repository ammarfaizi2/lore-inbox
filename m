Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWBDJ3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWBDJ3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWBDJ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:29:48 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8967 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932138AbWBDJ3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:29:48 -0500
Date: Sat, 4 Feb 2006 10:29:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm5
Message-ID: <20060204092941.GB9275@mars.ravnborg.org>
References: <20060203000704.3964a39f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
> 
> Known problems:
> 
> - Sam has added a new check in the kbuild tree.  It detects multiple
>   instances of EXPORT_SYMBOL(foo) across separate .o files.
> 
>   It catches a _lot_ of problems.   You'll see something like this:

Sigh. I did a 'make allmodconfig' on x86_64 and found to my suprise only
a sinlge symbol being exported more than one time.

This is purely a consistency check introduced by commit:
http://www.kernel.org/git/?p=linux/kernel/git/sam/kbuild.git;a=commit;h=cd1f125e5808203d3bf58f1d04a9cbd33f60fdb6

I can rip it out again if the noise/value ratio is too high.

 
>   Patches would be nice, but be warned that fixing these is not as trivial
>   as one might think:
> 
>   - If one export is in generic code and the other is in arch code then
> 
>     - If you remove the export in generic code, you need to check all
>       architectures for breakage.
We should IMO try to keep the exports in generic code.
The exports should go with the function definition - right after closing
'{'.
All other ways of exporting function is a call for inconsistency.
A gret deal of effort has been put into getting rid of ksym files
- good. But exports should not be scattered far away form the function
definition.
  
>     - If you remove the export in arch code then you need to be sure
>       that the generic .o file a) always compiles in the offending function
>       and b) is always linked into vmlinux.
Placing the export just below the function definition should cover this
in 90% of the cases. The rest is macros..

> 
>   If possible, the best approach is to put the EXPORT_SYMBOL
>   immediately after the symbol which is being exported.  And if it's
>   a function, pleeeze don't put a blank line between the end of the
>   function and the export - I've no idea why people do that...
Agreed.

	Sam
