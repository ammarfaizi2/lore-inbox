Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWE3OMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWE3OMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWE3OMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:12:07 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15295 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932300AbWE3OMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:12:06 -0400
Subject: RE: Long delay on bootup with wait_hwif_ready
From: Steven Rostedt <rostedt@goodmis.org>
To: David Balazic <david.balazic@hermes.si>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
       Matt Domsch <Matt_Domsch@dell.com>
In-Reply-To: <B216E7A91F67B6429E3ACF162402A02D0E5F90@hsl-lj-mail.hermes.si>
References: <B216E7A91F67B6429E3ACF162402A02D0E5F90@hsl-lj-mail.hermes.si>
Content-Type: text/plain
Date: Tue, 30 May 2006 10:11:12 -0400
Message-Id: <1148998272.8104.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:10 +0200, David Balazic wrote:
> Hi!
> 
> My "final conclusion" last time was, that there is some memory
> area, that comes out too short in certain cases.
> This is some early kernel boot code, that deals with the BIOS (and
> confuses it, it seems, by running out the mentioned memory area).
> 
> As I understood, the kernel could be tweaked to increase/decrease
> the problemtatic memory area (or the usage of it).
> 
> It is some kind of stack, heap or segment, I don't know, but somebody
> mentioned it last time.
> 
> Regards,
> David
> 
> PS: Feel free to ask me for testing patches ;-)
> I still have the same PC (with a certain weird behavior lately,
> I can't switch the IDE mode from "RAID" to "normal" ...)
> 

After rereading the thread (after my first cup of coffee this time), I
see that the problem was slightly different than what I had. The thread
showed some delay before the console was initialized (the EDD code). But
I'm experiencing the delay with the wait_not_busy.

My problem is that the secondary status register is returning busy when
there isn't anything there.  So I have to wait 35 seconds for the
timeout to expire.  This could just be a fluke with the way the board is
designed (it wouldn't surprise me).

-- Steve


