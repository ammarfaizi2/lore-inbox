Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUAEWrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAEWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:46:51 -0500
Received: from thunk.org ([140.239.227.29]:3517 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265978AbUAEWXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:23:07 -0500
Date: Mon, 5 Jan 2004 17:22:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105222253.GA12012@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Daniel Jacobowitz <dan@debian.org>,
	Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org
References: <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401042043020.2162@home.osdl.org> <20040105074717.GB13651@kroah.com> <20040105111556.GA20272@ucw.cz> <20040105201144.GA11179@thunk.org> <20040105210625.GA26428@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105210625.GA26428@ucw.cz>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 10:06:25PM +0100, Vojtech Pavlik wrote:
> 
> That looks very nice. Now, if there were a way how to make the isync
> IMAP connections go over a compressed ssh link (like I'm doing with
> Mutt/IMAP) that'd be very cool.
> 

The following in your .isyncrc file will do the trick:

Mailbox thunk
Box Inbox
Host thunk.org
Tunnel "socat SOCKS4A:127.0.0.1:thunk.org:143 STDIO"

You can also do this via secure IMAP, but then ssh's compression won't
be able to do much.  Nevertheless, I do this when synchronizing
against an IMAP server where I don't have ssh access, and where I want
the connection between the thunk.org and po14.mit.edu to be secured.
So I use the following syntax in .isyncrc to achieve to do this:

Mailbox Inbox
Box Inbox
Host imaps:po14.mit.edu
Tunnel "socat SOCKS4A:127.0.0.1:po14.mit.edu:993 STDIO"
UseSSLv2 yes
UseSSLv3 yes
UseTLSv1 yes

						- Ted
