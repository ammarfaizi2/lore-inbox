Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbULGNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbULGNLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbULGNLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:11:34 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:62675 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261806AbULGNLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:11:23 -0500
Date: Tue, 7 Dec 2004 14:11:22 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: what does __foo means.
Message-ID: <20041207131122.GA25796@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	krishna <krishna.c@globaledgesoft.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41B5A5E1.9010608@globaledgesoft.com> <Pine.LNX.4.53.0412071354060.16729@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0412071354060.16729@yvahk01.tjqt.qr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2004 at 01:54:25PM +0100, Jan Engelhardt wrote:
> >Hi all,
> >
> >    Can anyone tell me does double underscore before a function mean?
> >    In which scenario a programmer must use it.
> 
> From the POV of a compiler, _ is like [a-z]. The programmer may use it freely.

Nonsense. The _ is used to provide for a new namespace, __ for a second one.
It is common to have a public function 'foo()' which does lots of error
checking and has a stable api. foo() in turn calls _foo() to do the actual
work, perhaps doing additional checking and verification.

The _namespace is bound by certain rules, some of which apply to the kernel
as well. The compiler is free to output symbols in the _Namespace, as well
as in the __namespace.

"To get specific, identifiers with two leading underscores are reserved for
 the compiler as well as identifiers beginning with a single underscore and
 using an upper case alphabetic character for the second. "

The linux kernel breaks this by using __ for even more private things.

I don't have K&R handy to check this. We might have some more liberty
because we do not link in libc.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
