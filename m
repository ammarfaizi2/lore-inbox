Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSG1In3>; Sun, 28 Jul 2002 04:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSG1In3>; Sun, 28 Jul 2002 04:43:29 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:15844 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S313773AbSG1In2>; Sun, 28 Jul 2002 04:43:28 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Event API changes - EVIOCGID
Date: Sun, 28 Jul 2002 18:42:18 +1000
User-Agent: KMail/1.4.5
Cc: linuxconsole-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200207212050.56616.bhards@bigpond.net.au> <200207281745.37751.bhards@bigpond.net.au> <20020728102256.B12268@ucw.cz>
In-Reply-To: <20020728102256.B12268@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207281842.18988.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002 18:22, Vojtech Pavlik wrote:
> On Sun, Jul 28, 2002 at 05:45:37PM +1000, Brad Hards wrote:
<snip>
> > I am not happy about the change from uint16_t to __u16, which you appear
> > to have made before sending this to Linus.
> >
> > That is a broken change - there is a standard type, and you've changed
> > it to a non-standard type. This is confusing to userspace programmers,
> > and I cannot provide a satisfactory explaination for this in
> > documentation.
> >
> > Please change it back.
>
> Well, I know this has been discussed back and forth.
And I was right last time too :-)

> __u16 is a kernel type and is defined if you #include <linux/input.h>.
> uint16_t isn't.
__u16 is no more a kernel type than uint16_t.
It is a one line fix: include <linux/types.h> instead of <asm/types.h>
Which you probably should be doing anyway, since there is no
reason to rely on any assembler types in <linux/input.h>

> __u* is used extensively in the input API anyway, so you'd have to
> explain it to userspace programmers nevertheless. So I prefer keeping
> the input.h include use just one type of explicit sized types.
So do I, and it had better be a standard type.

Note that the input API does *NOT* use __u* extensively. In fact
if you take out the force feedback stuff (which Johannes already
agreed to change:), this is the *only* _u* usage in any part of the 
input API.

> Sure, we can change them all to uint*_t, but then do it all at once and
> provide a satisfactory explanation for it. ;)
I am doing it all. Johannes agreed to the change, and I did the only
other required entry. If Johannes agrees, I'll do the trivial changes
for force-feedback.
The reason why I am not doing it all at once is to provide patches
that do one API change at a time. Or, depending on how you look
at it, I did the only change all-at-once, and you reverted it :)

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
