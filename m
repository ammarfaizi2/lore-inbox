Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUH3KbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUH3KbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 06:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUH3KbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 06:31:22 -0400
Received: from open.hands.com ([195.224.53.39]:46311 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267563AbUH3Kas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 06:30:48 -0400
Date: Mon, 30 Aug 2004 11:42:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: fireflier firewall userspace program doing userspace packet filtering
Message-ID: <20040830104202.GG3712@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, this message is probably directed at catching rusty's attention
(hi rusty) but anyone who is able to help, assistance much appreciated.
please reply cc as i ain't subscribing to lkml!

background:

	i find only _one_ firewall program [in debian] that
	is capable of doing firewall on-demand "popup" rule
	creation and packet filtering, it's called "fireflier".

	this also the _only_ program that i know of that also
	does user-space packet filtering.

	in other words, not only can fireflier allow you to
	create rules as-and-when packets come in or out (and
	they are queued/blocked until they are "approved")
	but also it allows you to create firewall rules on a
	PER-PROGRAM basis.

	which is very cool, and i don't see _any_ other firewall
	program doing that - for linux.


[if anyone knows of any such MATURE AND STABLE userspace firewall
 programs with the same capability as fireflier please do let me know
 because the questions stop]


with that background in mind, here is the problem:

	fireflier's "per-program" userspace packet filtering
	is very basic: it contains NO state-based filtering.
	none.  zip.  nada.

	therefore, when a program dies, the "pid" of the
	program, which is part of the rule, becomes lost,
	such that FIN ACK and RST packets get thrown to the
	queue... and consequently to the user, because you can
	be certain that there will not have been a RST or FIN
	ACK firewall rule created!!!

with the background and the problem in mind, here is the question:

	is it possible to leverage - and i mean without cut/pasting
	large parts of kernel-space code into fireflier-in-userspace -
	the EXISTING kernel's iptables functionality in some way,
	such that per-program packet filtering may be performed?

i don't actually care whether code is moved into kernel (100 lines),
i don't care if code is added in userspace (100 lines).  what i am
looking for is a QUICK way to, say... leverage an existing API
in the kernel, add one extra field (a pid) to the kernel as a hack,
add a callback and a void* to the ip tracking structures as an
"extra packet check" as a hack, that sort of thing, where the userspace
callback gets its original void* plus the packet handed to it.

the last thing i want is to cut/paste several man-years of code
from the kernel to user-space - things like ip_conntrack.


ultimate aim:

	to be able to "enhance" existing iptables firewall rule
	checking rather than to be backed into a corner of "replacing"
	existing functionality.... just because of one extra check
	[the pid]

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

