Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbRK2TgG>; Thu, 29 Nov 2001 14:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRK2Tf5>; Thu, 29 Nov 2001 14:35:57 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:35304 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S280766AbRK2Tfo>; Thu, 29 Nov 2001 14:35:44 -0500
Message-ID: <3C068ED1.D5E2F536@nortelnetworks.com>
Date: Thu, 29 Nov 2001 14:38:57 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC: ethernet links should remember routes the same as addresses
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just wanted to get some opinions on this for possible inclusion in 2.5.  
Alexey, if you have any comments...

The scenario is as follows:

Suppose I have a fancy routing setup, dynamically configured by different
binaries, scripts, etc, complete with multiple addresses per link, additional
routing rules and tables specified using iproute2, etc.

An ethernet driver hangs.  Could be a software bug, an intermittent hardware
issue, whatever.  It can be fixed up by setting the link down and up.

Currently, if I run "ip link set dev ethX down", all routes associated with that
IP address in the additional routing tables are lost.  This is somewhat
understandable, as the addresses are not actually available anymore.  However,
the addresses are still visible associated with the link.  Then I run "ip link
set dev ethX up".  The route in the main routing table comes back, but none of
the other routes do.  Somehow, all of those additional routes must be re-added.

Wouldn't it be nice if we could keep track of these additional routes?  Then you
could simply 'down' and 'up' the link and everything would be back the way it
was before.

Does this sound like a good idea?  How hard would this be to implement (not
knowing what the current code looks like, I don't know how this would be done)?

Chris Friesen


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
