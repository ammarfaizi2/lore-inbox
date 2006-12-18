Return-Path: <linux-kernel-owner+w=401wt.eu-S1754670AbWLRWAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbWLRWAf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbWLRWAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:00:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:26105 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbWLRWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:00:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rcBR3Op0xxetbYA+gIjYkNulNJ6hOBwxQeTV099yUD6YkiXIDea70I8QTrRG1zwB2XvIAmHLXSiwq2FM7WdPpqUh7HbyD+Fm4Fcf0/jNzubV6fZ1kmGh76S0I+sR4WGeSYowiCIeh7CujuKG4Kxmxku00CKzVdeZfM7vL9v1JCA=
Message-ID: <5a4c581d0612181400t347fc9efx69e55efb3ef40c45@mail.gmail.com>
Date: Mon, 18 Dec 2006 23:00:32 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: andrei.popa@i-neo.ro
Subject: Re: 2.6.19 file content corruption on ext3
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>, "Florian Weimer" <fw@deneb.enyo.de>,
       "Marc Haber" <mh+linux-kernel@zugschlus.de>,
       "Martin Michlmayr" <tbm@cyrius.com>
In-Reply-To: <1166476297.6862.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166314399.7018.6.camel@localhost>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
	 <1166476297.6862.1.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Andrei Popa <andrei.popa@i-neo.ro> wrote:
> On Mon, 2006-12-18 at 12:41 -0800, Linus Torvalds wrote:
> >
> > On Mon, 18 Dec 2006, Linus Torvalds wrote:
> > >
> > > But at the same time, it's interesting that it still happens when we try
> > > to re-add the dirty bit. That would tell me that it's one of two cases:
> >
> > Forget that. There's a third case, which is much more likely:
> >
> >  - Andrew's patch had a ", 1" where it _should_ have had a ", 0".
> >
> > This should be fairly easy to test: just change every single ", 1" case in
> > the patch to ", 0".
> >
> > The only case that _definitely_ would want ",1" is actually the case that
> > already calls page_mkclean() directly: clear_page_dirty_for_io(). So no
> > other ", 1" is valid, and that one that needed it already avoided even
> > calling the "test_clear_page_dirty()" function, because it did it all by
> > hand.
> >
> > What happens for you in that case?
> >
> >               Linus
>
> I have file corruption.

No idea whether this can be a data point or not, but
 here it goes... my P2P box is about to turn 5 days old
 while running nonstop one or both of aMule 2.1.3 and
 BitTorrent 4.4.0 on ext3 mounted w/default options
 on both IDE and USB disks. Zero corruption.

AMD K7-800, 512MB RAM, PREEMPT/UP kernel,
2.6.19-git20 on top of up-to-date FC6.

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
