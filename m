Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSADLOI>; Fri, 4 Jan 2002 06:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288598AbSADLN7>; Fri, 4 Jan 2002 06:13:59 -0500
Received: from out1.bigplanet.com ([216.169.198.51]:47264 "EHLO
	out1.bigplanet.com") by vger.kernel.org with ESMTP
	id <S288597AbSADLNp>; Fri, 4 Jan 2002 06:13:45 -0500
Date: Fri, 04 Jan 2002 05:38:30 -0500
From: Andy Gaynor <silver@silver.unix-fu.org>
Subject: Re: losetuping files in tmpfs fails?
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Message-id: <3C358626.B88DA942@silver.unix-fu.org>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3C2F0AEE.ACABAAFA@silver.unix-fu.org>
 <3C34E4DF.F439FD70@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all for your responses to ...

silver@silver.unix-fu.org (Yers truly) wrote:
> [Lookey, I can't loop to files in tmpfs!]

Before trying out a new kernel feature, I give the docs at least a quick look
for bugs and warnings.  The higher the signal-to-noise ratio, the closer I
look.  tmpfs.txt is conversational, so I only gave it a cursory scan.  The
notes on the loop restriction are kind of obscured.  The first is the second
line of "usage" 3.  Having read the first line, completely innocuous and
unrelated to the restriction, I moved on.  The second was "todo" 2 at the very
bottom, and todos aren't usually very interesting to first-time users.  This is
an important restriction with no obvious justification (the cynical might even
call such a bug), and should be prominently advertised.

akpm@zip.com.au (Andrew Morton) wrote:
> It's not obvious that there's a burning need to support loop-on-tmpfs though,
> is there?

Completeness is enough.  /tmp is a general purpose area and should generally
work.  Given /tmp's transient nature, it's quite reasonable to trade away
persistence for other features, including speed and flexibility.  However,
there is no obvious justification for trading away other features, like the
ability to contain the objects of loops.

    As for specific need, it's common practice to create temporary filesystems
in a file before sending them to removable volumes.  The activity on such
filesystems is usually intensive and short-lived, making them ideal candidates
for tmpfs's features.  It pleases me to get better mileage from my generous
swap partitions, which occupy prime prime real estate on my hard drives: fast
low-order fast locations strategically placed between system and data areas.

Regards, [Ag]   Andy Gaynor   silver@silver.unix-fu.org
