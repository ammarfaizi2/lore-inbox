Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSG0XIW>; Sat, 27 Jul 2002 19:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318856AbSG0XIW>; Sat, 27 Jul 2002 19:08:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44040 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318854AbSG0XIU>; Sat, 27 Jul 2002 19:08:20 -0400
Date: Sun, 28 Jul 2002 00:11:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Robert White <rwhite@pobox.com>
Cc: Ed Vance <EdV@macrolink.com>, "'Theodore Tso'" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Message-ID: <20020728001135.G32766@flint.arm.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE> <20020726151723.F19802@flint.arm.linux.org.uk> <200207271507.56873.rwhite@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207271507.56873.rwhite@pobox.com>; from rwhite@pobox.com on Sat, Jul 27, 2002 at 03:07:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 03:07:56PM -0700, Robert White wrote:
> I agree that that is what that line of the text says, my position is that
> the entire statement was was written nieavely, and proveably so.

Ok, so lets go through your claims.

> Throughout the entire section the standard (not the linux manual page)
> discusses "satisfying a read" (singular).

The text refers you, via a hyperlink to the read() function.  Which is
singular, because the interface is singular.  I fail to see what point
you're making here.

> The text was written with an
> "everybody will know basically what I mean" aditude that leaves it flawed
> for strict interpretation.

This sentence does not allow any misinterpretation:

   A pending read shall not be satisfied until MIN bytes are received
   (that is, the pending read shall block until MIN bytes are received),
   or a signal is received.

You call a read() on a blocking file descriptor.  It blocks until MIN bytes
are received.  End of story.  If you have MIN set to 10, and you've called
read(,,1), the pending read is blocked, for 1 byte and "shall block until
MIN bytes are received".  Crystal clear.

> And the linux manual pages still show through
> enough to use as the bases of my argument.

Who cares about the Linux manual pages when discussing a standard?  The
manual pages discuss an implementation of a standard that may very well
be buggy.  They are not a standard unto themselves.

As Alan Cox just confirmed to me - "Read SuSv3 , nothing else matters".

> Pre-Summary: My entire position rests on what the original author meant by 
> "receive".  That is, is it "receive into the driver" or "receive into the 
> user context".  He proveably meant receive into the user context (e.g. the 
> read buffer).

I disagree.  Firstly, this standard isn't describing your user space
program.  It's describing the behaviour of the read() system call with
respect to blocking.  Secondly, the third sentence of this paragraph
gives some insight into the purpose of VMIN:

  A program that uses case B to read record-based terminal I/O may block
  indefinitely in the read operation.

but that's only insight, and you can't hang too much on that.

> The best example to use for the "sloppyness" of writing in the standard and 
> manual page is that technically, if it is "receive into the driver", if you 
> have both VMIN and VTIME set non-zero, VTIME will not start until "a 
> character is received" which, by strict intrepertation of "received (by the 
> driver)", discounts the presence of any characters in the buffer.  Restated, 
> if it is "receive into the driver" this read will wait for a new character 
> even if there are hundreds of characters already buffered.

The standard covers that case:

  If data is in the buffer at the time of the read(), the result shall be
  as if data has been received immediately after the read().

So pre-existing data in the driver waiting to be read is treated as if
it were received _after_ you called read().  Which is sensible.

> (CITATION: from the linux manual page: "When both are set, a read will wait 
> until at least one character has been received, and then return  as  soon  as 
> either  MIN  characters  have been received or time TIME has passed since the 
> last character was received.")

The Linux manual page is not a standard.  It is therefore meaningless to
this discussion.

> [rest cut]

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

