Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUIINwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUIINwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUIINwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:52:49 -0400
Received: from imap.gmx.net ([213.165.64.20]:36066 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264098AbUIINwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:52:39 -0400
X-Authenticated: #17725021
Date: Thu, 9 Sep 2004 15:48:28 +0200
From: Henry Margies <henry.margies@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Is there a problem in timeval_to_jiffies?
Message-Id: <20040909154828.5972376a.henry.margies@gmx.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: %3lz3@K$hA\]+AEANQT9>.M`@Pfo]3I,M,_JWswT5MBOpjXQ'VST8|DGMhkv8j,9Xb%j3jG
 |onl!dcPab\nF3>j.1\:ixCGSM)nHq&UXeDDhN@x^5I
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.


I'm working on an arm based embedded device running kernel 2.6.9.
I asked this question also on the arm mailing list, but nobody
could answer me my questions there, so I will try here :)

I have some problems with itimers. For example, if I set up a
timer using a period of 20ms, the system needs 30ms to send the
signal. I figured out, that it needs always 10ms more than I
want.

The problem seems to be located in the timeval_to_jiffies()
function.

In function do_setitimer() the following calculation is done:

     i = timeval_to_jiffies(&value->it_interval);

... where i is the interval for my timer. The problem is, that
for it_interval = 0 seconds and 20000 microseconds, i = 3. But
shouldn't it be 2? It looks like, the problem is somewhere in
here (timeval_to_jiffies()):

      return (((u64)sec * SEC_CONVERSION) +
                (((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
                 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >>
			SEC_JIFFIE_SC;

I don't understand all of the formula in detail. But for me, it
looks like the problem is in USEC_ROUND.

Any ideas?

Thx in advance,
Henry

-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!

