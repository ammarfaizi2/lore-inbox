Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTJATNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJATNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:13:21 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49337 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262131AbTJATNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:13:18 -0400
Date: Wed, 01 Oct 2003 14:06:23 -0500
From: John Lange <john.lange@bighostbox.com>
Subject: A new model for ports and kernel security?
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1065035183.5142.50.camel@mars>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It will not surprise me if this topic has been discussed before but my
search of the archives did not turn up anything meaningful.

I have a question and a suggestion.

What I'm wondering is, why do we have this requirement that only root
processes can connect to low ports (under 1024) ?

My understanding is that this is a hold-over from ancient days gone past
where it was meant to be a security feature. Since only root processes
can listen on ports less than 1024, you could "trust" any connection
made to a low port to be "secure". In other words, nobody could be
"bluffing" on a telnet port that didn't have root access therefore it
was "safe" to type in your password.

I don't know if the above is the real reason or not but if it is,
clearly it has outlived its usefulness as a "security" feature.

Regardless, does not the requirement that only root can bind to low
ports now create more of a security problem than it ever solved?

Are not processes forced to run as root (at least at startup) that have
security holes in them not the leading cause of "remote root exploits"?

So if the root-low-port requirement isn't serving any purpose and is
indeed the cause of security problems is it not time to do away with it?

Furthermore, while only root can bind to low-ports, ANY user can bind to
high ports. This also causes a ton of security concerns as well!

So I would like to propose the following improvement to kernel security
and I invite your comments.

Suggestion: A groups based port binding security system for both
outgoing and incoming port binding.

For example, the group "root" is allowed to listen to ports "*" (all)
and allowed outgoing connections to "*" (all) as well.

The group "www" would be allowed to bind to ports "80, 443" (http,
https) and not allowed ANY outgoing connections.

The group "mail" (or postfix, or whatever) would be allowed to listen to
port "25" (smtp) and connect to "25".

The group "users" would not be allowed to listen at all but might be
allowed to connect to 20-21, 80, 443. 

etc.

This accomplishes two major things:

- no process ever needs to run as root.

- no unauthorized process can ever listen on a port or make connections.
On servers that allow remote users this prevents things like bots, spam
relays, ftp drops and all sorts of mischief.

I envision a simplistic "/etc/ports" with the format,
"<groupid>,<incoming ports>,<outgoing ports>"

I realize similar things can be accomplished in other ways (with
iptables I believe) but it just seems to me that this should be a
fundamental part of the systems security and therefore should be in the
kernel by default (just as the root binding to low ports is currently).

I hereby make the disclaimer that I am not a kernel hacker, just a
sysadmin. So feel free to give me the smackdown if this violates some 
kernel rule.

-- 
John Lange


