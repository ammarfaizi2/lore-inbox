Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUFQPCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUFQPCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUFQPCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:02:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57310 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266527AbUFQO7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:59:19 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16593.45358.706034.192053@segfault.boston.redhat.com>
Date: Thu, 17 Jun 2004 10:56:46 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Takao Indoh <indou.takao@soft.fujitsu.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Dave Anderson <anderson@redhat.com>, mpm@selenic.com
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-Reply-To: <20040617123239.GA24647@elte.hu>
References: <20040527210447.GA2029@elte.hu>
	<C7C4545F11DFBEindou.takao@soft.fujitsu.com>
	<20040617121356.GA24338@elte.hu>
	<20040617121847.GA30894@infradead.org>
	<20040617123239.GA24647@elte.hu>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [3/4] [PATCH]Diskdump - yet another crash dump function; Ingo Molnar <mingo@elte.hu> adds:

mingo> * Christoph Hellwig <hch@infradead.org> wrote:

>> Btw, now that we got you in the loop, any chance to see a forward-port
>> of netdump to 2.6?  I think diskdump and netdump could share a lot of
>> infrastructure, and given we already have the net polling hooks adding
>> netdump shouldn't be that much work anymore.

mingo> i think a forward port of netdump might already exist - Jeff, Dave?

Yes, I ported the code forward to 2.6.  The netpoll infrastructure needed a
little tweaking to accommodate netdump, but nothing major.  Namely, we need
to reset some locks, and I added an element to the netpoll data structure
for the dump function.  I also updated the zap_completion_queue function to
touch the nmi watchdog.

mingo> i agree that netdump and diskdump should be merged. (Red Hat is
mingo> involved in the diskdump project too so this is an ultimate goal
mingo> even though the patches are divergent.) Basically diskdumping is
mingo> another IO transport - the format, userspace tools and much of the
mingo> non-IO kernel mechanism is shared. Diskdumping is more complex on
mingo> the driver level and it also needs to be more careful because it
mingo> writes to media so it verifies various assumptions by reading
mingo> on-disk sectors before writing to the area.

I'm not quite sure what infrastructure would be shared between the two.
Page selection, perhaps?  Anything else?

-Jeff
