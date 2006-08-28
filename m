Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWH1LRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWH1LRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWH1LRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:17:46 -0400
Received: from khc.piap.pl ([195.187.100.11]:27296 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964818AbWH1LRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:17:45 -0400
To: Willy Tarreau <w@1wt.eu>
Cc: Solar Designer <solar@openwall.com>, Ernie Petrides <petrides@redhat.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: printk()s of user-supplied strings
References: <20060822030755.GB830@openwall.com>
	<200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
	<20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu>
	<20060826022955.GB21620@openwall.com> <20060826082236.GA29736@1wt.eu>
	<20060826231314.GA24109@openwall.com> <20060827200440.GA229@1wt.eu>
	<20060828015224.GA27199@openwall.com> <20060828080246.GB9078@1wt.eu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 28 Aug 2006 13:17:43 +0200
In-Reply-To: <20060828080246.GB9078@1wt.eu> (Willy Tarreau's message of "Mon, 28 Aug 2006 10:02:46 +0200")
Message-ID: <m3sljhp0rs.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> Well, I'm not sure about this. Nearly all patches which get merged pass
> through a public review first, and when you see how many replies you get
> for and 'else' and and 'if' on two different lines, I expect lots of
> spontaneous replies such as "use %S for user-supplied strings".

I wouldn't rely on that.

>> A solution would be to normally use "%S" and only use
>> "%s" where "%S" wouldn't work.  In that case, we could as well swap "%s"
>> and "%S", though - hardening the existing "%s" and introducing "%S" for
>> those callers that depend on the old behavior.

I think it's the way to go.

> I'd rather not change "%s" semantics if we introduce another specifier
> which does exactly what we would expect "%s" to do.

Both would be equivalent in most cases. It's better to use "%s" for
most cases (either secured or not) and leave "%S" for the bunch of
special cases whose authors better know what are they doing.

> I will try your proposal to retain the trailing '\n' unescaped.

I think with "%s" and "%S" this is no longer needed.
-- 
Krzysztof Halasa
