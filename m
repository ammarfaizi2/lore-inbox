Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUEWPZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUEWPZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUEWPZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:25:18 -0400
Received: from mailbox.leidenuniv.nl ([132.229.102.4]:22171 "EHLO
	mailbox.leidenuniv.nl") by vger.kernel.org with ESMTP
	id S262972AbUEWPZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:25:10 -0400
From: Willem de Bruijn <wdebruij@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: question regarding strange kernel stats under high (network) load
Date: Sun, 23 May 2004 17:33:08 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405231733.08367.wdebruij@dds.nl>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  for a network monitoring project that I'm working on (see my sig if you're 
interested) I have to compare system load under high throughput. Directly 
comparing my implementation to tcpdump (LSF) seems fine, our user% and 
kernel% are lower. However, when I added an idle system I noticed some 
strange behaviour that remains on re-executing the tests: 

the kernel% is actually higher when nothing is running than when my code is 
running! Overall processing is lower (idle% is higher on the idle system), 
but that is thanks to the high %si (soft ints) that my code generates. 

In order to better explain my problem here is the output of top (the new one, 
with %si, %hi and %wa) for a 600Mbit throughput, the first line is for the 
idle system, the second for FFPF (my system) and the third for Linux Socket 
Filters:

Mbit		iperf in	iperf out		capt	recv	kern drop	% drop		tcpdump %	iperf %	user %	
kernel %	idle %																																																																																																																																																																																																																																																	
600		608	608								33	6	30	40																																																																																																																																																																																																																																																	
600		608	608		514084	517314	33	0.63		17	20	13	15	25																																																																																																																																																																																																																																																	
600		609	608		421215	517597	96382	31.4		76	33	17	49.5	0																																																																																																																																																																																																																																																	

the usage statistics are user%, kernel% and idle% (I haven't saved the si% 
results). What's odd is that although idle is higher for the idle system, 
kernel% is actually lower. I can understand that my code generates extra soft 
interrupts, but not that it has an effect on the `other' kernel load. Perhaps 
I don't understand the values good enough, in which case I would greatly 
appreciate your help. However, it could also signal a bug in the statistics 
reporting (although I don't hope that's the case, these results are great for 
my paper :). FYI, I used the command

top -b -n 5 -d 3 | grep "Cpu\|tcpdump\|iperf"

to generate these results.

thanks for your help,

  Willem
-- 
Willem de Bruijn
wdebruij_at_dds.nl
http://www.wdebruij.dds.nl/

current project : 
Fairly Fast Packet Filter (FFPF)
http://ffpf.sourceforge.net/

-- 
Dit bericht is gescand op virussen en andere gevaarlijke inhoud door ULCN MailScanner en het bericht lijkt schoon te zijn.
This message has been scanned for viruses and dangerous content by ULCN MailScanner, and is believed to be clean.

