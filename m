Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTEDPKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTEDPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:10:32 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:17567 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id S263628AbTEDPKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:10:31 -0400
Date: Sun, 4 May 2003 11:23:00 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Ingo Molnar <mingo@redhat.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305040404300.12757-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33L2.0305041121200.17172-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003, Ingo Molnar wrote:

>
> On Sun, 4 May 2003, Calin A. Culianu wrote:
>
> > IIRC, x86 ints have the high-order byte _last_ (ie the fourth byte).
> > What's to stop someone from, say, smashing a buffer (and consequently
> > return-address) on the stack using something like {0x01, 0x01, 0x01,
> > 0x00} which is really address '65793' in base-10.  The above is a valid
> > ASCII string (3 1's followed by a NUL) which could conceivably end up on
> > the stack as the result of an errant strcpy() or gets() or whatever...
>
> you are right, it is possible to use the enclosing \0 to generate an
> address into the first 16MB, but how do you get any arguments passed to
> that function?

Hehe you're right.. because of the trailing NUL it's impossible to get any
custom args passed to anything (like maybe libc.so's system() for
instance).

Yes, so this is a good layer of protection, because all the addresses
below 16MB guarantee this feature, at least...


