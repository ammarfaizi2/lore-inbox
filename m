Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWKBARe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWKBARe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWKBARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:17:34 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:34035 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750760AbWKBARd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:17:33 -0500
Date: Wed, 1 Nov 2006 16:11:55 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Neil Horman" <nhorman@tuxdriver.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>, akpm@osdl.org,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
 several drivers
Message-Id: <20061101161155.d7b30258.randy.dunlap@oracle.com>
In-Reply-To: <9a8748490611011605u55ccdcaeob99700d6e1a813a4@mail.gmail.com>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	<1161660875.10524.535.camel@localhost.localdomain>
	<20061024125306.GA1608@hmsreliant.homelinux.net>
	<1161729762.10524.660.camel@localhost.localdomain>
	<20061101135619.GA3459@hmsreliant.homelinux.net>
	<9a8748490611011605u55ccdcaeob99700d6e1a813a4@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 01:05:49 +0100 Jesper Juhl wrote:

> On 01/11/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> > Hey all-
> >         Since Andrew hasn't incorporated this patch yet, and I had the time, I
> > redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
> > account.  New patch attached, replacing the old one, everything except the
> > aforementioned cleanups is identical.
> >
> > Thanks & Regards
> > Neil
> >
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> >
> > +out4:
> > +       for_each_online_node(node) {
> > +               kfree(timers[node]);
> > +       }
> > +out3:
> > +       misc_deregister(&mmtimer_miscdev);
> > +out2:
> > +       free_irq(SGI_MMTIMER_VECTOR, NULL);
> > +out1:
> > +       return -1;
> 
> Very nitpicky little thing, but shouldn't the labels start at column
> 1, not column 0 ?
> I thought that was standard practice (apparently labels at column 0
> can confuse 'patch').
> 
> Hmm, I guess that should be defined once and for all in
> Documentation/CodingStyle

I have some other CodingStyle changes to submit, but feel free
to write this one up.

However, I didn't know that we had a known style for this, other
than "not indented so far that it's hidden".

If a label in column 0 [0-based :] confuses patch, then that's
a reason, I suppose.  I wasn't aware of that one...
In a case like that, we usually say "fix the tool then."

---
~Randy
