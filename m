Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbSIXTnj>; Tue, 24 Sep 2002 15:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSIXTnj>; Tue, 24 Sep 2002 15:43:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10767 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261623AbSIXTni>;
	Tue, 24 Sep 2002 15:43:38 -0400
Message-ID: <3D90C183.5020806@pobox.com>
Date: Tue, 24 Sep 2002 15:48:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my suggestion, which will maintain compatibility with 2.2 and 2.4 
kernels, and require a -very- minimal kernel update, to support event 
logging.

When CONFIG_EVLOG is defined, printk outputs a tagged ASCII format: 
KERN_xxx, the format string (verbatim), and 0 or more argument values. 
Since this loses the argument tags (names) from the current IBM event 
logging code, you can re-gain this info by post-processing the printk. 
Post-processing can be done by a hacked cpp (see http://www.tinycc.org/ 
for a tiny, steal-able one) or a simple Perl script.

The only real difference at that point between IBM's implementation and 
my proposal is that some argument tags are expressions, not simple C 
identifiers (flag ? "true" : "false") instead of "flag".  This is a 
problem if you want to do SQLish queries on the tags in the event log, 
but its a work-around-able problem, IMO.

This scheme should fit with the backend code already created by IBM, 
which isn't too bad IMO.

Even if the details are disagreeable, I really think that we should work 
towards making printk (or 'warn', 'error', etc.) log the desired 
information, while still keeping older drivers useful, and keeping 
drivers source-compatible with older kernels.


Now, turning to a tangent topic that relates to either scheme...

With either your proposal or mine, event logging is far more useful if 
similar drivers spit out similar diagnostics.  i.e. it's less useful if 
8139too net driver spits out 'status16' in one interrupt event, and 
8139cp net driver spits out 'status32' in another.  Though they are 
different hardware and the values mean different things, my point is the 
concepts are similar, and thus better diagnostics are achieved with 
subsystem diagnostic standards.

Such standards are in actuality independent of event logging per se, but 
if IBM wants to push this thing, I would like to see some proposals as 
to what IBM actually wants drivers to log.  I have not seen that at all, 
and think that such proposals should be an integral part of an event 
logging system.  Otherwise the diagnostics are less useful, and IBM 
would have failed to demonstrate an adequate grasp of the problem domain 
[which then leads to other, typical software engineering problems...]

"What do you want to log?" is as important to me as "how do you want to 
log it?"  And the answers to the two questions are very much intertwined.

Comments?

	Jeff



