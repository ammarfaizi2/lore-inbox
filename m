Return-Path: <linux-kernel-owner+w=401wt.eu-S937344AbWLKRw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937344AbWLKRw5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937358AbWLKRw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:52:57 -0500
Received: from ns.firmix.at ([62.141.48.66]:50231 "EHLO ns.firmix.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937344AbWLKRw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:52:56 -0500
Subject: Re: Mark bitrevX() functions as const
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Akinobu Mita <akinobu.mita@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612111828550.28981@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612110803340.12500@woody.osdl.org>
	 <29447.1165840536@redhat.com>  <29623.1165853572@redhat.com>
	 <Pine.LNX.4.61.0612111828550.28981@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 11 Dec 2006 18:51:50 +0100
Message-Id: <1165859510.3308.30.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.409 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 18:35 +0100, Jan Engelhardt wrote:
[...]
> I can just second this. What should be marked const is [1]the things 
> pointed to, not [2]the local copy of a function argument.
> 
> This[2] is what I believe almost every other software project does, 

Yes, also for the reason to educate people to actually use "const" as
much as possible - if only to make it for humans clear what may change
somewhere and what not.

> though they often fail at [1]. Or have you seen Glibc trying to pull a
> int strtoul(const char *const nptr, char **const endptr, const int 
> base)? It just makes the prototypes and headers longer without having 

glibc functions like strtoul() are an extremely bad example for this
because there are standards out there which the define the function
signature - so it is often not really the choice of some glibc
developer/maintainer/project lead.
Or you have very old implementations like e.g. the RPC/XDR library which
simply ignore the "const" keyword.

> too much benefit. And maybe the code author may even want to reuse the 
> args directly as walking pointers or countdown integers, for example.

And that is the other problem of such functions and C as such: One wants
the "const char *" in the argument list (if possible) since it allows to
pass "const char *" and "char *". The return value should similarly be
"char *" because then you can use it in the above mentioned way for
"const char *" and "char *".
Alas that gives you a chance to "cast" "const char *" to "char *" and
not even trigger a compiler warning (as opposed a real type cast). Of
course this can be handled/fixed by review but it takes people to
actually do this.
The only sane solution is to get out the same const-ness as passed in -
but this is syntactically not possible in plain simple C.

And the above paragraph is not arguing to remove the keyword "const".

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

