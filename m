Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWALTfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWALTfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWALTfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:35:42 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:57998 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161210AbWALTfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:35:41 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: need for packed attribute
Date: Thu, 12 Jan 2006 11:35:37 -0800
User-Agent: KMail/1.7.1
Cc: Pete Zaitcev <zaitcev@redhat.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       oliver@neukum.org
References: <200601121227.k0CCRCB8016162@alkaid.it.uu.se> <20060112092006.6a9f4509.zaitcev@redhat.com>
In-Reply-To: <20060112092006.6a9f4509.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121135.38210.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006, Pete Zaitcev wrote (in another snide postscript):
> 
> P.P.S. The USB stack was careful to use correct sizes historically.
> One grep of the source will tell you that all this stench emanates from
> the newer code, in particular the gadget and its attendant components,
> such as usbtest. Guess who wrote it: same gentleman who advocated adding
> ((packed)) to _all_ structures "used to talk to hardware".  He just has 
> no respect for coding practices, that's all. 

You were the one who said "talk to hardware", as I had politely pointed
out off-line in previous email ... nobody else.

What you've done a couple times now is try to put those words in someone
else's mouth -- mine! -- which are clearly both (a) not what were actually
said, and (b) wrong.  (FWIW it's something I've observed happening a lot
in the "traditional media" here in the US, it's not good there either.)

This what's known as not acting in good faith.  "No respect for" ground
rules of discussion, for that matter ... if you're going to argue about
things, please don't put words in anyone's mouth.  Certainly not mine.
(Even when the actual words said _are_ inconvenient to your agenda...)


The "packed" attribute is correct, since there's no guarantee that those
structures will be appearing in protocol data structures in GCC-friendly
layouts.  Or even that the usb-if will generate protocol data structures
that happen to match GCC alignment rules, for that matter.

It's perfectly legal and common to have two seven-byte structures (like
non-audio endpoint descriptors) adjacent to each other, even when those
structures contain values otherwise subject to alignment restrictions (like
the maxpacket size, a __u16 value).

Moreover, there is no circumstance under which we'd want the compiler
expanding that seven byte data structure into an eight byte one, by
picking some place to insert a padding byte.


And for that matter, many/most of those protocol structures were declared
"packed" even in 2.4 kernels when Linux was extending them with host-side data
structures and making extra copies of them.  The packing may have been
declared per-element rather than structure-wide, but it was still declared.
That's another way in which those comments of yours are wrong.

- Dave
