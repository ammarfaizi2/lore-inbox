Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269395AbUJFRDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269395AbUJFRDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbUJFQq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:46:56 -0400
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:20904 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S269342AbUJFQhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:37:01 -0400
Subject: [PATCH] RFC. User space backtrace on segv
From: Alex Bennee <kernel-hacker@bennee.com>
To: "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>,
       "Linux-SH (m17n)" <linux-sh@m17n.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1097080652.5420.34.camel@cambridge>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Oct 2004 17:37:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hacked up this little patch to dump the stack and attempt to generate
a back-trace for errant user-space tasks.

What:

Generates a back-trace of the user application on (in this case) a segv
caused by an unaligned access. This particular patch is against 2.4.22
on the SH which is what I'm working with but there no reason it couldn't
be more generalised.

How:

Its not the most intelligent approach as it basically walks up the stack
reading values and seeing if the address corresponds to one of the
processes executable VMA's. If it matches it assumes its the return
address treats that section as a "frame"

Why:

I work with embedded systems and for a myriad of reasons doing a full
core dump of the crashing task is a pain. Often just knowing the
immediate call stack and local variables is enough to look at what went
wrong with objdump -S.

Questions:

Have I replicated anything that is already hidden in the code base?
Would this be useful (as a CONFIG_ option) for embedded systems?

-- 
Alex, Kernel Hacker: http://www.bennee.com/~alex/

"Mach was the greatest intellectual fraud in the last ten years."
"What about X?"
"I said `intellectual'."
	;login, 9/1990

