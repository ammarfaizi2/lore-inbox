Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbULAB06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbULAB06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULAB0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:26:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:11175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbULABXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:23:51 -0500
Date: Tue, 30 Nov 2004 17:23:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101863177.4574.71.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411301717140.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>  <8219.1101828816@redhat.com>
  <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org> 
 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org> 
 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org> 
 <1101854061.4574.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org> 
 <1101858657.4574.33.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org> 
 <1101860688.4574.50.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301636050.22796@ppc970.osdl.org> 
 <1101862057.4574.67.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301656051.22796@ppc970.osdl.org>
 <1101863177.4574.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Dec 2004, David Woodhouse wrote:
>
> On Tue, 2004-11-30 at 16:57 -0800, Linus Torvalds wrote:
> > This isn't even a "fix". It's a cleanup. It goes under the same rules
> > a spelling fix does.
> 
> So you don't see a long-term technical benefit in cleaning up the
> API/ABI we export to userspace so that userspace stops depending on
> stuff which just isn't supposed to be there?

I see _benefits_, but exactly because they aren't immediate, I think we 
should be careful.

Also, exactly because moving things around is a total _nightmare_ from a 
diff and source maintenance perspective, we should be _extra_ careful. 
It's almost impossible to see something that changed when that something 
is _also_ being moved around. You don't see it in the diff, and you don't 
see it in any of the tools - a small semantic change that would have been 
absolutely OBVIOUS if it was in a regular diff gets totally drowned out by 
the "move" diff. 

Put another way: when people do things like re-indenting a driver (which 
has _exactly_ the same issues: cleanup for the future, but totally 
destroys all chance of seeing what the changes actually were), I want the 
patch that does the re-indentation to be totally independent of the actual 
changes.

Ie we do one patch that _only_ does the whitespace changes, and try to 
make sure that it doesn't break anything even by mistake. People even 
compile the thing and verify that it is 100% the same thing as an object 
file. Then that gets applied. Only _after_ that should you make changes.

Do we follow this religiously? For small things, clearly no. We sometimes 
mix whitespace and real changes. But we sure as hell shouldn't. At least 
not for anything bigger.

The EXACT same thing is true of any header file movement. DO NOT CHANGE 
SEMANTICS WHEN YOU MOVE STUFF!

It's not just my personal hangup. It's a damn good idea.

I will hereby just ignore this thread. Please remove me from the Cc, I've 
wasted way too much time on this total idiocy already. I've made my 
opinions extremely clear, and quite frankly, I don't want to hear anything 
on this any more for at least a week. It's just not worth it.

		Linus
