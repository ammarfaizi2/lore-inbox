Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271613AbRH1Pzc>; Tue, 28 Aug 2001 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271614AbRH1PzW>; Tue, 28 Aug 2001 11:55:22 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:43459 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271613AbRH1PzQ>; Tue, 28 Aug 2001 11:55:16 -0400
Date: Tue, 28 Aug 2001 16:55:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010828165513.A7602@flint.arm.linux.org.uk>
In-Reply-To: <3B8BA883.3B5AAE2E@linux-m68k.org> <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com> <9mge9l$sb9$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9mge9l$sb9$1@forge.intermeta.de>; from mailgate@hometree.net on Tue, Aug 28, 2001 at 03:44:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 03:44:53PM +0000, Henning P. Schmiedehausen wrote:
> >I'll show you a real example from drivers/acorn/scsi/acornscsi.c:
> >	min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);
> 
> >this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
> >an integer constant. So the above is actually a signed comparison, and
> >I'll bet you that was not what the author intended.
> 
> And the mistake of the author was not to write "unsigned int this_residual".
> That's the bug. Not the min() function.

Hmm, everyone's talking about my code.  And I agree with Henning that
"this_residual" should be unsigned.  Unfortunately, it's defined in the
generic SCSI layer.  I'd really like it to be fixed in the SCSI layer
no matter what the outcome of the min/max debarcle^wdebate is.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

