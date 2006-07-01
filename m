Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWGAFAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWGAFAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 01:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWGAFAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 01:00:24 -0400
Received: from web32009.mail.mud.yahoo.com ([68.142.207.106]:51613 "HELO
	web32009.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932330AbWGAFAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 01:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UmYvbzf8U36LmEltkMkqCIOLgLsNtouSw7zDtAL05ZvrA76ors6xg4o82guV67QJg6NPwEUtzUx0hxAmEFwVt0eoLaVBr0Mxy75ATgYgtihBt6oJHer0CLZXVBAYl0AP/z8Nf+/bZZeisVUE9R9lZUl8o+qizzGK+JgS0sCojAs=  ;
Message-ID: <20060701050023.31696.qmail@web32009.mail.mud.yahoo.com>
Date: Fri, 30 Jun 2006 22:00:23 -0700 (PDT)
From: Congjun Yang <congjuny@yahoo.com>
Subject: keyboard raw mode
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a special POS keyboard that comes with a
magnetic swipe reader. When a card is swiped, the
keyboard prefixes the card data with a seqneuce
starting with "1d 9d 9d". I guess this design is to
allow applications to tell card swipes from key
presses, as the two left control break codes "9d 9d"
cannot be generated from key presses.

The keyboard worked fine with kernel 2.4.7. If I put
the keyboard in raw mode, I can receive the sequence
"1d 9d 9d". A simple test can be done with "showkey
-s". However, newer kernels seem to treat the second
break code as a hardware error, which in my case it's
not, and simply discard it.

While it's necessary to have a work around for certain
hardwares that tender to produce such errors, but why
would the fix be done at "raw" level? In raw mode, I
would expect to receive whatever is generated from the
keyboard, including possibly errors. If I decide to
put the keyboard in raw mode, I assume the
responsibility of handling raw data.

Along the same line, why would atkbd.c complain about
"Unknown key code..." when an unknown key is pressed
in raw mode (e.g. "showkey -s")? It shouldn't care if
I just want to get the scan codes, should it? I have
to do setkeycodes before I can see the scan codes!?




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
