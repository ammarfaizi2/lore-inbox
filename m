Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEHMmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTEHMmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:42:13 -0400
Received: from elin.scali.no ([62.70.89.10]:47274 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S261352AbTEHMmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:42:12 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20030508095943.B22255@devserv.devel.redhat.com>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com>
	 <1052387912.4849.43.camel@pc-16.office.scali.no>
	 <20030508095943.B22255@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052398474.4849.57.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 May 2003 14:54:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What really gets to me is that *you* wrote in
(http://www.kernel.org/pub/linux/kernel/v2.5/ChangeLog-2.5.41):

        3. Intercept system calls
	OProfile (and intel's vtune which is similar in function) used to do this;
	however what they really need is a notification on certain
	events (exec() mostly). The way modules do this is store the original
	function pointer, install a new one that calls the old one after storing
	whatever info they need. This mechanism breaks badly in the light of
	multiple such modules doing this versus modules
	unloading/uninstalling their handlers (by restoring their saved pointer
	that may or may not point to a valid handler anymore).
	Eg the use of the export in this just a bandaid due to lack of a
	proper mechanism, and also incorrect and crash prone.


So what you're saying here is not that you object to having people doing
syscall hooks, just that operating on the syscall_table symbol directly
is error prone (to which I wholeheartedly agree). 

Then you reject a "proper mechanism".....

TJ

On Thu, 2003-05-08 at 11:59, Arjan van de Ven wrote:
> On Thu, May 08, 2003 at 11:58:33AM +0200, Terje Eggestad wrote:
> > I guess something like this:
> > 
> > typedef int (*syscall_hook_t)(void * arg1, void * arg2, void * arg3,
> > void * arg4, void * arg5, void * arg6);
> > 
> > #define HOOK_IN_FLAG 0x1
> > #define HOOK_OUT_FLAG 0x2
> > 
> > opaquehandle = int register_syscall_hook(int syscall_nr, syscall_hook_t
> > hook_function, int flags);
> > int unregister(int opaquehandle);
> > 
> > I'd make a stab at it if I knew that it stood a chance of getting
> > accepted. 
> 
> I dont think it has.
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

