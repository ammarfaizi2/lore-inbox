Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWJBUAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWJBUAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWJBUAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:00:22 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:8947 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S964933AbWJBUAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:00:18 -0400
Date: Mon, 2 Oct 2006 12:59:21 -0700
To: Dan Williams <dcbw@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002195921.GC14966@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at> <20061002165053.GA2986@gamma.logic.tuwien.ac.at> <1159808304.2834.89.camel@localhost.localdomain> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <1159816923.12691.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159816923.12691.29.camel@localhost.localdomain>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 03:22:03PM -0400, Dan Williams wrote:
> 
> Right; we need to get this settled and we need to figure out a way with
> Wireless Extensions to allow exact SSIDs to be sent and retrieved from
> the card/driver.  How much cruft do we add to drivers and/or WE bits to
> bend over backwards and preserve compatibility with a lot of older bits?
> I can think of a few ways here to preserve backwards compat, but most
> involve adding bits to 3 places in each driver and a new flag to WE,
> which puts us right back in the same situation we're in right now;
> inconsistent drivers and poor semantics both inside and outside the
> kernel.

	There is no way old tools are going to set/process those extra
flags, so it does not work. And this won't fix out-of-tree drivers...

> Maybe the answer here _is_ to bend over backwards to preserve
> compatibility, restore null-termination-and-increment-length bits in
> drivers and WE, and kludge all the user-space tools.

	Let's not throw the baby with the bathwater.
	This is *not* the first time I've done such incompatible
change in WE (size in set, pointer in scan, remove pointer in
events). The other time, it went completely under the radar, you guys
did not noticed anything (apart Jouni).
	The difference is that this time I attempted to do it a bit
quicker than usual. Maybe I was too fast this time. But I've noticed
that some distro have become slower to pick up changes than in the
past, which is frustrating me.
	To me, the solution is just to let a bit more time for the
userspace to propagate to the distro. And to educate users to pay
attention to the incompatibility warnings displayed by the tools.

> Dan

	Have fun...

	Jean
