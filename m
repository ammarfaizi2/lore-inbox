Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSGZOOL>; Fri, 26 Jul 2002 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSGZOOL>; Fri, 26 Jul 2002 10:14:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18190 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317397AbSGZOOK>; Fri, 26 Jul 2002 10:14:10 -0400
Date: Fri, 26 Jul 2002 15:17:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: "'rwhite@pobox.com'" <rwhite@pobox.com>, "'Theodore Tso'" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Message-ID: <20020726151723.F19802@flint.arm.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>; from EdV@macrolink.com on Wed, Jun 26, 2002 at 10:48:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 10:48:30AM -0700, Ed Vance wrote:
> Does the spec say that VMIN behavior depends on the size of a 
> blocking read? No, it says that the read completes when VMIN or 
> more characters have been received. If VMIN is three and two 
> characters have been received, completing a blocking read of any 
> size is a violation. Should we also add a "read buffer size" 
> parameter to select and poll, etc. so they can report that read 
> data is available before satisfying VMIN, too? 
> 
> Ted, Russell, please weigh in on this. 

I just found this mail again.  Yes, I agree with your interpretation,
which reflects the code we presently have, as well as my reading of
SuS.  The SuS is quite clear that "A pending read shall not be
satisfied until MIN bytes are received".  It doesn't say "A pending
read shall not be satisfied until MIN bytes or the number of requested
bytes in read() are received"

In addition, it also says "MIN represents the minimum number of bytes
that should be received when the read() function returns successfully."
Successful completion for read() is defined as "Upon successful
completion, read() shall return a non-negative integer indicating the
number of bytes actually read."

So, for _any_ read() to a terminal with MIN set, for this call to
return data (ie, success) MIN bytes must have been received.

(Note that the behaviour where the number of bytes > MIN seems to be
a little vague, SuS just talks about "block the calling thread until
_some_ data becomes available" for the blocking case.)

I'd be interested to know if Ted agrees with my position here; he is
the author of the tty code, and is presently looking at that area.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

