Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWIIOqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWIIOqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIIOpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:45:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:11432 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932232AbWIIOpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:45:04 -0400
From: Andi Kleen <ak@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [Bug] [2.6.18-rc5-mm1] system no boot early death  x86_64
Date: Sat, 9 Sep 2006 15:41:02 +0200
User-Agent: KMail/1.9.1
Cc: keith mannthey <kmannth@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       andrew <akpm@osdl.org>
References: <1157653241.5653.37.camel@keithlap> <1157675335.5653.66.camel@keithlap> <Pine.LNX.4.64.0609081134520.7094@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0609081134520.7094@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091541.02337.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 12:40, Mel Gorman wrote:
> On Thu, 7 Sep 2006, keith mannthey wrote:
> > On Thu, 2006-09-07 at 11:20 -0700, keith mannthey wrote:
> >> Hello,
> >>   I was booting rc4-mm3.  With rc5-mm1 I am hanging early... Mel I don't
> >> know if this is related to your code but I will soon know. (I don't get
> >> your debug info in early console.)
> >>   I was working on patches for the reserve based memory hot add path in
> >> srat.c (the initial error is fixed by Mels patches but there is more to
> >> do)
>
> That is some good news at least.
>
> > and was just moving to rc5-mm1 to sync up and then more trouble.
> >
> >> This is with reserve based hot-add not enabled at the command line.
> >
> > Well this isn't fully adding up but here is what I found.
> >
> > If I drop
> > x86_64-mm-drop-640k-reservation.patch
> > x86_64-mm-remove-e820-fallback.patch
> > and
> > x86_64-mm-remove-e820-fallback-fix.patch
> >
> > I build and boot.  All files in the series upto x86_64-mm-drop-640k-
> > reservation.patch work just fine.  Dropping this patch makes things
> > better. The e820 patches were removed to make the rest of the series
> > apply.
>
> I am having trouble reproducing this. However, I recently got access to a
> machine similar to yours. I can say that sometimes the stability of
> 2.6.18-rc4-mm3 and 2.6.18-rc5-mm1 was totally useless (but the symptons
> different to yours) and the box would easily crash for reasons I could not
> pin down. As stability problems had been reported on the machine earlier
> by other users, I was inclined to blame the hardware. Now I'm not sure.
>
> > It is not clear what changes would cause me to die setting up the
> > bootmem allocator on my first node...
>
> Unless your machine really has something special in the low 640K that is
> required and bad things happen if it's written to at a bad time.

That would be a BIOS bug then.  If anything is there it has to be reserved.

But maybe it just breaks something that only worked by accident before.

-Andi
