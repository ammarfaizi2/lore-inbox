Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbTGHR3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbTGHR3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:29:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267491AbTGHR3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:29:49 -0400
Date: Tue, 8 Jul 2003 18:44:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, emperor@EmperorLinux.com,
       LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Message-ID: <20030708184421.A13083@flint.arm.linux.org.uk>
Mail-Followup-To: Gerald Britton <gbritton@alum.mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, emperor@EmperorLinux.com,
	LKML <linux-kernel@vger.kernel.org>,
	EmperorLinux Research <research@EmperorLinux.com>,
	Theodore Ts'o <tytso@mit.edu>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think> <200307071412.00625.durey@EmperorLinux.com> <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk> <20030708112016.A10882@light-brigade.mit.edu> <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk> <20030708132417.B10882@light-brigade.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708132417.B10882@light-brigade.mit.edu>; from gbritton@alum.mit.edu on Tue, Jul 08, 2003 at 01:24:17PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 01:24:17PM -0400, Gerald Britton wrote:
> On Tue, Jul 08, 2003 at 04:42:30PM +0100, Alan Cox wrote:
> > Interesting. I wonder why our fixup would have failed - its not something
> > I've seen but we should fixup cardbus resource blocks (2.4 isnt smart
> > enough to handle multidevice cardbus but Rmk has 2.5 code that is), but
> > for the normal case it ought to have worked.

The x86 pci setup stuff is something I'm not completely certain about
since it is handled in a different way from the "normal" (from my point
of view at least) PCI code.

However, I do have some outstanding patches which clean up the init and
resource stuff but unfortunately break it on x86.  For everything to
work as expected, I'd like x86 and whatever other architectures either
handle this in the core pci code, or the architecture specific code.
I see this as a quirk of x86 platforms.

(Architectures which do a full setup of the bus in the kernel set the
cardbus bridge up as part of their normal setup.)

> Is it smart enough to handle a case like this:
> 
> [device resource 00-01]
> [bridge resource 01-04]
>    [device resource 01-02]
>    [cardbus bridge no resources]
>    [cardbus bridge no resources]
>    [device resource 02-04]
> [bridge resoruce 04-06]
>    [device resource 04-06]
> [device resource 06-07]

Definitely not yet, since x86 has a policy of not reallocating anything
at all.  I suspect getting it to handle it will open a huge live mine
field, full of SMI ports. 8(

Any x86 PCI gurus got any ideas?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

