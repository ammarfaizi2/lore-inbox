Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTJJWdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbTJJWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:33:15 -0400
Received: from jdavies.dsl.xmission.com ([166.70.25.250]:46377 "EHLO
	smtp.millcreeksys.com") by vger.kernel.org with ESMTP
	id S263161AbTJJWdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:33:12 -0400
Message-ID: <1065825189.3f8733a55cfd4@secure.millcreeksys.com>
Date: Fri, 10 Oct 2003 16:33:09 -0600
From: Michael Jensen <kernel@millcreeksys.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>            <1065820650.3f8721ea4162b@secure.millcreeksys.com> <200310102205.h9AM5lRX007520@turing-police.cc.vt.edu>
In-Reply-To: <200310102205.h9AM5lRX007520@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 64.50.56.162
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I agree that it wouldn't have any effect on buffer overflows.  It would prevent
further abuse of the system unless the perpetrator was able to install and load
a modified kernel.  Even if they had root access, they would be unable to
execute backdoor binaries because they would not be signed with a trusted key. 
This would also thwart rootkits.

I also agree that there would be much maintenance and performance overhead.  But
there are some people/companies that are willing to sacrifice such things to
increase the security of their systems.

Another problem that I see is that it would be quite easy to get around signed
binaries if perl was one of those binaries.  Care would need to be taken in
deciding what is trusted and signed.

Does anyone have additional comments?

Michael

BTW - I like your suggestion of mounting everything either 'read only' or
'noexec', and using LSM.  I'm going to have to mess around with that.



Quoting Valdis.Kletnieks@vt.edu:

> On Fri, 10 Oct 2003 15:17:30 MDT, Uncle Jens said:
> > What about some type of kernel-based-DRM, where only properly(trusted)
> signed
> > binaries can be executed?  For example, I could compile my public key in
> with
> > the kernel and it would only run binaries that had been signed by my
> private
> > key.  I feel that this would be a great security enhancement and would like
> t
> o
> > hear about any issues this may present.
> > I've searched all over for a project that does something like this and have
> b
> een
> > unable to find one.  I'd like to start one up on my own, but lack the
> kernel
> > development expertise.
> > 
> > I'm open for any input/flames/etc....
> 
> There are two basic problems with the idea:
> 
> 1) It does nothing to prevent any of the usual abuses of a system - buffer
> overflows, shellcode, and the like.  You get fed a bad packet, the signed
> Apache binary overflows, and executes the signed /bin/sh that then calls
> the signed /bin/echo to append stuff to the appropriate files to create
> a back door.....
> 
> 2) Unless you're working with a kiosk/embedded system where the number of
> binaries is quite small, you're looking at a maintenance headache (remember,
> if you blindly sign binaries without auditing every single one, you're really
> not
> doing anything useful...)
> 
> A *much* better approach would be to do the following:
> 
> 1) Mount everything either 'read only' or 'noexec', and use something like
> LSM
> to make sure it doesn't get remounted.  So binaries off /home won't run, and
> binaries on /usr can't be trojaned (barring OTHER breaches such as
> remounting,
> or scribbling on the raw disk, etc...)
> 
> 2) Fix the bypasses of noexec (like '/lib/ld-linux.so.2 /your/binary/here').
> 
> That's probably a much better way of addressing the "running unauthorized
> binaries" threat, without taking a crypto signature hit on every exec().....
> 


