Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTEDP2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTEDP2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:28:08 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:18847 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id S263633AbTEDP2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:28:06 -0400
Date: Sun, 4 May 2003 11:40:35 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Ingo Molnar <mingo@redhat.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305040448250.24497-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33L2.0305041132530.17172-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 May 2003, Ingo Molnar wrote:

>
> On Sun, 4 May 2003, Ingo Molnar wrote:
>
> > > IIRC, x86 ints have the high-order byte _last_ (ie the fourth byte).
> > > What's to stop someone from, say, smashing a buffer (and consequently
> > > return-address) on the stack using something like {0x01, 0x01, 0x01,
> > > 0x00} which is really address '65793' in base-10.  The above is a valid
> > > ASCII string (3 1's followed by a NUL) which could conceivably end up on
> > > the stack as the result of an errant strcpy() or gets() or whatever...
> >
> > you are right, it is possible to use the enclosing \0 to generate an
> > address into the first 16MB, but how do you get any arguments passed to
> > that function?
>
> ie. if the binary anywhere has code that does:
>
> 	system("/bin/sh")

Yes, certainly that would do it.. as would the situation if the binary is
written in such a way so that before breaking the buffer and setting up a
return into the <16MB address space, somehow you had enough control to set
up the stack frame so that it contains a pointer and the string "/bin/sh"
after the return address.  Maybe by exploiting some local parameter
variable to the function you are in??

I don't know.. but at this point it gets really really unlikely that this
situation would exist, and you are right in saying that the more layers of
protection and the more improbable you make things for the cracker, the
better off you are.

Clearly without the ASCII-shield and exec-limit, it is pretty much
guaranteed that every unchecked buffer on the stack that accepts ASCII
data is crackable, whereas with the ASCII-shield + exec limit, the
guarantee still doesn't exist...

>
> wrt. address-space randomization, "prelink -R" already provides quite good
> randomization of the shared library addresses, which should give some
> statistical protection against remote attacks, i dont think we'll need
> kernel support for that.

What is prelink -R?

-Calin

