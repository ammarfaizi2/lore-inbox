Return-Path: <linux-kernel-owner+w=401wt.eu-S1030202AbWLULyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWLULyN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWLULyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:54:13 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52977 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030202AbWLULyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:54:12 -0500
X-Originating-Ip: 24.163.66.209
Date: Thu, 21 Dec 2006 06:48:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: coding style and re-inventing the wheel way too many times
Message-ID: <Pine.LNX.4.64.0612210614020.32046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=2.007, required 5, ALL_TRUSTED -1.80, BAYES_40 -0.18,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-SpamScore: ss
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  this little project of mine of submitting the occasional code
"cleanup" has turned out to be way more daunting than i originally
thought, given how many source files insist on constantly re-inventing
the wheel.  consider a couple useful macros defined in
include/linux/kernel.h:

  #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
  #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))

  first, there's the obvious inconsistency in upper versus lower case,
and why no corresponding "round down" macro?  in any event, a rough
first attempt to see what could be re-worded using DIV_ROUND_UP (with,
admittedly, lots of false positives):

  $ grep -Er " ?+ ?([^ -]+) ?- ?1\) ?/ ?\1" *

ouch.  the same could be said for

  #define __ALIGN_MASK(x,mask)    (((x)+(mask))&~(mask))

where you can see possible replacements (again, just a hacky first
attempt with lots of bogus "hits" but still):

  $ grep -Er "\+.*(.*)\)* ?&~ ?\(*\1" *

and the list just goes on.

  one thing that might be useful would be to pull out the set of
generically useful macros into a separate header file, say
include/linux/cool_macros.h or something like that, and just put a
pointer to that header file from the CodingStyle file and strongly
encourage kernel programmers to read it and use it.

  the obvious set of macros for that file would be things related to:

  - rounding up and down
  - alignment and masking
  - array size
  - sizeof field
  - container_of
  - variants of min and max

and that sort of thing, and that header file could just be included
from kernel.h.

  in any event, even *i* am not going to go near this kind of cleanup,
but is there anything actually worth doing about it?  just curious.

rday
