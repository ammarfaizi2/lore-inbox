Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265045AbSJWPWq>; Wed, 23 Oct 2002 11:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265049AbSJWPWq>; Wed, 23 Oct 2002 11:22:46 -0400
Received: from almesberger.net ([63.105.73.239]:48390 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265045AbSJWPWo>; Wed, 23 Oct 2002 11:22:44 -0400
Date: Wed, 23 Oct 2002 12:28:41 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021023122841.G1421@almesberger.net>
References: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Wed, Oct 23, 2002 at 12:09:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
> This is nothing more than a call-back mechanism such as could be used by
> LSM or LTT.

Hmm, Greg has already voiced some violent disagreement regarding
LSM :-) That leaves LTT. Given the more exploratory nature of LTT,
I wonder if [dk]probes wouldn't be quite sufficient there, too.

Is the idea that people would deploy hooks locally, i.e. while
profiling or debugging, or that some hooks would be put permanently
in the kernel ? I can envision some rather nasty coding habits
developing if the latter would be used extensively. (INTERCAL has
"COME FROM", COBOL has "ALTER", ... ;-)

By the way, those hooks look like an excellent mechanism for
circumventing the GPL, so you might want to export them with
EXPORT_SYMBOL_GPL.

> Yes both kprobes and kernel hooks implement call-backs, but using INT3 to
> call functions is not the most efficient call mechanism,

Oh, you could probably have some "fast" probes by just checking
for a certain "anchor" pattern (e.g. a sequence of 5 nops on
i386), which could then be replaced with a direct call. This
optimization would have to be optional, in case some code yields
the anchor pattern such that it isn't also a basic block.

Hooks would still have the advantage of easier access to local
variables, of course.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
