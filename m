Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVAMDgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVAMDgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVAMDgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:36:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261277AbVAMDg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:36:28 -0500
Date: Wed, 12 Jan 2005 22:35:42 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, marcelo.tosatti@cyclades.com,
       greg@kroah.com, chrisw@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113033542.GC1212@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112182838.2aa7eec2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 06:28:38PM -0800, Andrew Morton wrote:
 
 > IMO, local DoS holes are important mainly because buggy userspace
 > applications allow remote users to get in and exploit them, and for that
 > reason we of course need to fix them up.  Even though such an attacker
 > could cripple the machine without exploiting such a hole.
 > 
 > For the above reasons I see no need to delay publication of local DoS holes
 > at all.  The only thing for which we need to provide special processing is
 > privilege escalation bugs.
 > 
 > Or am I missing something?

The problem is it depends on who you are, and what you're doing with Linux
how much these things affect you.

A local DoS doesn't both me one squat personally, as I'm the only
user of computers I use each day. An admin of a shell server or
the like however would likely see this in a different light.
(though it can be argued a mallet to the kneecaps of the user
 responsible is more effective than any software update)

An information leak from kernel space may be equally as mundane to some,
though terrifying to some admins. Would you want some process to be
leaking your root password, credit card #, etc to some other users process ?

priveledge escalation is clearly the number one threat. Whilst some
class 'remote root hole' higher risk than 'local root hole', far
too often, we've had instances where execution of shellcode by
overflowing some buffer in $crappyapp has led to a shell
turning a local root into a remote root.

For us thankfully, exec-shield has trapped quite a few remotely
exploitable holes, preventing the above.

		Dave

