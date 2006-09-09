Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWIIBAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWIIBAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 21:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWIIBAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 21:00:05 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:5263 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751266AbWIIBAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 21:00:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Date: Sat, 9 Sep 2006 00:59:50 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <edt3m6$9kn$1@taverner.cs.berkeley.edu>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1157763590 9879 128.32.168.222 (9 Sep 2006 00:59:50 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sat, 9 Sep 2006 00:59:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore  wrote:
>On Fri, Sep 08, 2006 at 12:54:29AM +0200, Pavel Machek wrote:
>>		      Alternatively disallow suid/sgid-anything exec
>> when all "usual" capabilities are not present.
>
>This is probably too stringent: remove any trivial capability
>whatsoever and you lose a rather important ability.

This might not be so terrible.  At least, I'm not sure I'd rule it
out at this point -- it seems like it might be worth considering.

First of all, if you have intentionally created an underprivileged
process, it seems almost reasonable to think that you might not want
that process to be able to exec anything that is suid/sgid.

Second, there are very few programs out there that are sgid or
suid-to-something-other-than-root.  On my FC5 machine, the ones I can spot
are ssh-agent, locate, screen, sendmail, postfix, a bunch of games, and a
few other random programs that are probably very rarely used.  I'm having
a hard time imagining a use case where I'd want an underprivileged daemon
to be able to exec one of those programs.  Normally, if I'm running
one of those programs, I'm probably doing it from a command-line shell
(which will have full user privileges) or some other environment that
is running with full user privileges (e.g., startup scripts or login
scripts, in the case of ssh-agent).
