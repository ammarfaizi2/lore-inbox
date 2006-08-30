Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWH3GQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWH3GQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 02:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWH3GQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 02:16:10 -0400
Received: from 1wt.eu ([62.212.114.60]:36881 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751144AbWH3GQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 02:16:09 -0400
Date: Wed, 30 Aug 2006 08:15:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Solar Designer <solar@openwall.com>, Ernie Petrides <petrides@redhat.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
Message-ID: <20060830061517.GA282@1wt.eu>
References: <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu> <20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu> <20060826231314.GA24109@openwall.com> <20060827200440.GA229@1wt.eu> <20060828015224.GA27199@openwall.com> <20060828080246.GB9078@1wt.eu> <m3sljhp0rs.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3sljhp0rs.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 01:17:43PM +0200, Krzysztof Halasa wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > Well, I'm not sure about this. Nearly all patches which get merged pass
> > through a public review first, and when you see how many replies you get
> > for and 'else' and and 'if' on two different lines, I expect lots of
> > spontaneous replies such as "use %S for user-supplied strings".
> 
> I wouldn't rely on that.
> 
> >> A solution would be to normally use "%S" and only use
> >> "%s" where "%S" wouldn't work.  In that case, we could as well swap "%s"
> >> and "%S", though - hardening the existing "%s" and introducing "%S" for
> >> those callers that depend on the old behavior.
> 
> I think it's the way to go.
> 
> > I'd rather not change "%s" semantics if we introduce another specifier
> > which does exactly what we would expect "%s" to do.
> 
> Both would be equivalent in most cases. It's better to use "%s" for
> most cases (either secured or not) and leave "%S" for the bunch of
> special cases whose authors better know what are they doing.
> 
> > I will try your proposal to retain the trailing '\n' unescaped.
> 
> I think with "%s" and "%S" this is no longer needed.

Yes it will be for compatibility reasons : we for sure will not fix all
users of "%s" quickly, so we will have to do our best not to break them.
If it was easy to find them all, we could replace "%s" with "%S" everywhere
and make "%S" the escaped one.

But well, I believe that you convinced me that escaping the "%s" and providing
a new "%S" for secure or special usages might be the way to go.

I will propose a patch soon.

> Krzysztof Halasa

thanks,
willy

