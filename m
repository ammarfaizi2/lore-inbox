Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTEPSRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTEPSRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:17:00 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:37365 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264533AbTEPSQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:16:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: greg@enjellic.com, greg@wind.enjellic.com (Dr. Greg Wettstein),
       Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@warthog.cambridge.redhat.com>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Date: Fri, 16 May 2003 13:28:10 -0500
X-Mailer: KMail [version 1.2]
Cc: Dean Anderson <dean@av8.com>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Garance A Drosihn <drosih@rpi.edu>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>
References: <200305161805.h4GI5buN032216@wind.enjellic.com>
In-Reply-To: <200305161805.h4GI5buN032216@wind.enjellic.com>
MIME-Version: 1.0
Message-Id: <03051613281001.27791@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 May 2003 13:05, Dr. Greg Wettstein wrote:
> On May 15, 10:23am, Linus Torvalds wrote:
> } Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
>
> Good morning to everyone discussing this fascinating topic.  I've been
> reading it for a day or two before joining in.  There have been some
> excellent points made and I won't even try to paraphrase all of them.
> I am including a snippet from what I consider the 'Linus definitive
> statement' on this issue since this is the definitive focal point
> which discussion must come down to.
>
> I think the issue comes down to whether or not Linux will incorporate
> functionality for the sake of correctness vs. expediency.  Based on
> all the history I think that everyone generally assumes that doing
> things correctly is the preferable route.
>
> In this case doing things the 'correct' way also provide the potential
> opportunity for Linux to do something reasonably creative.  I've been
> banging on issues with respect to identity management and Linux since
> about 1998 and it is now interesting to see these issues becoming
> pragmatically relevant.

There is also a (desire/need) to be able to integrate this with something
like IPSec...

In some Kerberos situations:
	1. authentication can be based on simple name/password
	2. authentication can be ased on name/password/smart card

Some sites may acctept #1 or #2. Other sites may only accept #2. (both are
related to the same realm, or cross realm operation).

> Technical thoughts follow below.
>
[Big snip]

Much of this can/should be handled outside the Kernel, PROVIDED, the kernel
can make a unique link between a process and the external security structure,
and provide communication paths between the service<=>kernel<=>app-server
("the service" is the security database server and "app-server" may be the
daemon granting login capability.

This way "the service" may make out-of-band remote requests for additional
authentication handling (translating remote credentials into local 
credentials type of thing).

It is VERY possible that a user may have been granted certain LOCAL priviliges
provided the user is NOT utilitizing unsecured networks. Or just making access
requests from unapproved locations... and still be permitted to make other
connections.

Assuming transitive privilige handling is NOT your friend (ie. undesired 
remote connection -> trusted host -> privileged access on third host).

This is slightly off the AFS line, but is spot on the "security services" that
are beginning to be discussed.
