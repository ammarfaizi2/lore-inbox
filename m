Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269159AbRGaC2t>; Mon, 30 Jul 2001 22:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269160AbRGaC2j>; Mon, 30 Jul 2001 22:28:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32268 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269159AbRGaC2Z>; Mon, 30 Jul 2001 22:28:25 -0400
Message-ID: <3B661925.FA8E461D@zip.com.au>
Date: Tue, 31 Jul 2001 12:34:13 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com> <20010730224930.A18311@caldera.de> <3B65CFC5.A6B4FC08@namesys.com>,
		<3B65CFC5.A6B4FC08@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 01:21:09AM +0400 <20010730234934.B20969@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig wrote:
> 
> For example I've just turned of the debugging on my ext3-using boxens.

FYI...  CONFIG_JBD_DEBUG is really just that - debug stuff.  Mainly,
it enables the printks which are controlled by /proc/sys/fs/jbd-debug.

Early on, sct made the decision that the assertion checks in ext3:

	akpm-1:/usr/src/ext3> grep -r ASSERT . | wc -l
	    187

cannot be disabled.  Each and every one of these will nicely
crash the machine.  The idea being, as you stated earlier,
that data integrity is golden - if we detect an inconsistency
we take the machine out and let recovery fix it up.

Turns out that at present we're over-aggressive on this. A modest
filesytem inconsistency (bit already free in bitmap, whatever)
or an IO error could force a panic.  Stephen is working on changing
the fs to be more selective in its handling of errors - less severe
errors will turn the fs readonly.

I would support your decision to enable reiserfs checking.  It's
a valuable feature.  It can save your data from hardware failures
as well as software failures.  Perhaps Hans' team should look into
moving the expensive checks into a different ifdef.

-
