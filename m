Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUFHIqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUFHIqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUFHIqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:46:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264903AbUFHIqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:46:38 -0400
Date: Tue, 8 Jun 2004 04:46:16 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Doug McNaught <doug@mcnaught.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040608084616.GV4736@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040602211714.GB29687@devserv.devel.redhat.com> <87u0xtbq9y.fsf@asmodeus.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0xtbq9y.fsf@asmodeus.mcnaught.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:31:37PM -0400, Doug McNaught wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> > On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> >> 
> >> 
> >> Just out of interest - how many legacy apps are broken by this? I assume 
> >> it's a non-zero number, but wouldn't mind to be happily surprised.
> >
> > based on execshield in FC1.. about zero.
> 
> IIRC, Lisp systems like CMUCL and SBCL (plus commercial Lisps) had
> problems with FC1 due to execshield.  They tend to do things like
> compile code on the fly to heap memory and expect to be able to run
> it.

They will still work, as long as you don't recompile them with recent
toolchain.
When you recompile them, they either needs to be taught to DTRT (i.e.
use mmap with PROT_EXEC for executable stuff), or can be linked with
-Wl,-z,execstack to mark them as needing executable stack.
prelink package also contains execstack(8) utility which can be used
on already linked binaries/shared libraries.

	Jakub
