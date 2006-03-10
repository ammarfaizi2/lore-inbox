Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWCJCsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWCJCsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWCJCsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:48:19 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:36553 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1750742AbWCJCsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:48:18 -0500
Subject: Re: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: alsa-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4410B2D7.4090806@yahoo.com.au>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 18:47:46 -0800
Message-Id: <1141958866.22708.69.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:57 +1100, Nick Piggin wrote:
> Fernando Lopez-Lezcano wrote:
> 
> > In my case it is completely repeatable. 
> > Boot, start jackd, stop jackd -> problem appears. 
> > 
> > This does not happen on all computers so it would seem to me it is
> > related to the sound drivers. I'll try to see if there is a correlation
> > with the sound card being used. 
> > 
> > Is there anything else I could do to try to help resolve this?
> 
> Can you test with the latest mainline -git snapshot, or is it only
> the -rt tree that causes the warnings?

I found something strange although I don't know why it happens yet:

  Fedora Core 4 kernel (2.6.15 + patches) works fine.
  Fedora Core 4 kernel + -rt21, [ahem... sorry], works fine.
  Fedora Core 4 kernel + -rt21 + alsa kernel modules from 1.0.10 or
     1.0.11rc3, fails[*]
  Plain vanilla 2.6.15 + -rt21, works fine
  Plain vanilla 2.6.15 + -rt21 + alsa kernel modules from 1.0.10 or
     1.0.11rc3, fails[*]

So, it looks like it is some weird interaction between kernel modules
that were not compiled as part of the kernel and the kernel itself. The
"updated" modules are installed in a separate location (not on top of
the built in kernel modules) and are found before the ones in the kernel
tree.

I have been building this combination for a long long time with no
problems, I don't know what might have happened that changed things.

Could be:
- configuration problems?
- the alsa tree is somehow incompatible with the kernel alsa tree, is
  that even possible?

I have _no_ idea on what to start looking for... but, oh well, this is a
start. Suggestions welcome. Thanks for somehow pointing me in the right
direction. 

-- Fernando

[*] I need that because of cards not yet included in the kernel proper,
and fixes that have not yet percolated to the kernel alsa tree. 


