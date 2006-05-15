Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWEOW2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWEOW2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWEOW2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:28:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10384 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965025AbWEOW2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:28:17 -0400
Subject: Re: /dev/random on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Day <imipak@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 23:41:07 +0100
Message-Id: <1147732867.26686.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 14:39 -0700, Jonathan Day wrote:
> http://www.securiteam.com/unixfocus/5RP0E0AIKK.html
> 
> (Just because something is claimed does not make it
> so, but it's usually worth checking.)

"Holes in the Linux Random Number Generator"

[I would cc the authors but they seem to have forgotten to include their
email addresses. I've cc'd the IEEE instead, especially as the paper
gets a trademark incorrect and that wants fixing before printing.]

Indeed. 

A paper by people who can't work out how to mail linux-kernel or
vendor-sec, or follow "REPORTING-BUGS" in the source, and think the
person found in a file called MAINTAINERS is in fact a "moderator"
doesn't initial inspire confidence. The also got the "Red Hat" name
wrong. It is "Red Hat" and it is a registered trademark.

Certainly there are lot of errors in the background but then their
expertise appears to be random numbers and that part of the material
looks much more solid.

> I know there have been patches around for ages to
> improve the entropy of the random number generator,
> but how active is work on this section of the code?

Going through the claims

I would dismiss 2.2 for the cases of things like Knoppix because CDs
introduce significant randomness because each time you boot the CD is
subtly differently positioned. The OpenWRT case seems more credible. The
hard disk patching one is basically irrelevant, at that point you
already own the box and its game over since you can just do a
virtualisation attack or patch the OS to record anything you want.

2.3 Collecting Entropy

Appears to misdescribe the behaviour of get_random_bytes. The authors
description is incorrect. The case where cycle times are not available
is processors lacking TSC support (pre pentium). This is of course more
relevant for some embedded platforms which do lack cycle times and thus
show the behaviour described. There are some platforms that therefore
show the properties they are commenting on so it is still a relevant
discussion in those cases.

3.4 Security Engineering

The denial of service when no true entropy exists is intentional and
long discussed. User consumption of entropy can be controlled by
conventional file permissions, acls and SELinux already, or by a policy
daemon or combinations thereof. It is clearly better to refuse to give
out entropy to people than to give false entropy.

Unix/Linux philosophy is "policy belongs outside the kernel", therefore
a daemon is the correct implementation if required. The paper perhaps
makes an interesting case for this.


Generally

The random number mathematics involved is not for me to comment on,
several of the points raised are certainly good, and I will forward the
paper URL on to vendor-sec to ensure other relevant folk see it.

Thanks for forwarding it.

Alan

