Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSHAECV>; Thu, 1 Aug 2002 00:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHAECV>; Thu, 1 Aug 2002 00:02:21 -0400
Received: from [209.237.59.50] ([209.237.59.50]:9975 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S318601AbSHAECU>; Thu, 1 Aug 2002 00:02:20 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <200208010325.g713PAA340197@saturn.cs.uml.edu>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 31 Jul 2002 21:05:42 -0700
In-Reply-To: <200208010325.g713PAA340197@saturn.cs.uml.edu>
Message-ID: <52lm7rw7e1.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Albert" == Albert D Cahalan <acahalan@cs.uml.edu> writes:

    Albert> As I said, "one could get fancy", thus missing the 2.6.xx
    Albert> kernel.  It's pretty obvious that you could do SCSI and IP
    Albert> with much less code. What's with the "HCA DDK" anyway, UDI
    Albert> reborn? I see all sorts of layers for IPC and what looks
    Albert> like VI/VIA, etc.

    Albert> Ditch the lofty goals, and you might make the 2.6.xx
    Albert> kernel.  You can stick to being a FireWire alternative for
    Albert> now.

The idea behind the HCA DDK is to let IB hardware drivers only
implement the details of the hardware they support, while keeping the
generic code generic.  It's similar in spirit to the way Linux doesn't
force ethernet drivers to implement the whole TCP stack.

Unfortunately the "VI layer" you mention is just about the lowest
level it makes sense to talk to IB hardware.  IB chips really do
operate in terms of queue pairs, completion queues, memory regions and
so on.  Other stuff like path record lookup is a necessary to use an
IB fabric (nodes are identify by a GUID, but packets need to be sent
to a LID, and the mapping of GUID->LID is not necessarily fixed).

I agree that it's a shame that the IB spec is so absurdly complex.
And it probably is true that you could come up with a simplified way
of using IB hardware that would be easier to code for.  However, I
don't think you'll find much interest in the IB world in implementing
Linux-specific, non-interoperable, non-IB-spec-compliant software.

Best,
  Roland
