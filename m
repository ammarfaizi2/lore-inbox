Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUCCK5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUCCK5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:57:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262435AbUCCK5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:57:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16453.47651.915651.491105@neuro.alephnull.com>
Date: Wed, 3 Mar 2004 05:57:39 -0500
From: Rik Faith <faith@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Chris Wright <chrisw@osdl.org>] Tue  2 Mar 2004 16:49:51 -0800
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301122618.O22989@build.pdx.osdl.net>
	<chrisw@osdl.org>
	<16453.354.904646.836231@neuro.alephnull.com>
	<20040302164951.Q22989@build.pdx.osdl.net>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  2 Mar 2004 16:49:51 -0800,
   Chris Wright <chrisw@osdl.org> wrote:
> * Rik Faith (faith@redhat.com) wrote:
> > > Doesn't seem like CONFIG_AUDIT=n disables all the code.
> >
> > The bit tests in entry.S are still there, but those are the same tests
> > that are used for ptrace, and there is nothing that sets the bits.  So,
> > aside from that test, all of the code should be disabled.
> 
> I think, e.g. the code that calls audit_get/putname is still there.

When syscall auditing is disabled, the body of the if will become a nop
because of a #define, so the compiler will remove the whole if.  I don't
want to move the if into a macro, since this would make it look like the
function was called all the time.  I don't want the if in the function
because I'm trying not to call the function except when necessary.

I could put #ifdef CONFIG_AUDITSYSCALL around these statements, but I
find that often makes code harder to read.  However, in this case, that
might avoid some confusion.

> > Except where noted below, I have either incorporated all your
> > suggestions or made notes in the code to do so later.  The new patch is
> > at: http://people.redhat.com/faith/audit/audit-20040302.1632.patch
> 
> Oops, I wasn't clear re: the static initialized data...

Yes, sorry, please see:
    http://people.redhat.com/faith/audit/audit-20040303.0544.patch

