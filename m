Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbQLBWb2>; Sat, 2 Dec 2000 17:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130560AbQLBWbS>; Sat, 2 Dec 2000 17:31:18 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:65295 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130498AbQLBWbA>;
	Sat, 2 Dec 2000 17:31:00 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012022200.eB2M0Wu473578@saturn.cs.uml.edu>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
To: david@linux.com (David Ford)
Date: Sat, 2 Dec 2000 17:00:32 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A295EA3.F0E47E9@linux.com> from "David Ford" at Dec 02, 2000 12:42:11 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
> Igmar Palsenberg wrote:

>> I've seen lots of programs that will assume that if we request x bytes
>> from /dev/random it will return x bytes.
>
> I find this really humorous honestly.  I see a lot of people
> assuming that if you write N bytes or read N bytes that you will
> have done N bytes.  There are return values for these functions
> that tell you clearly how many bytes were done.
>
> Any programmer who has evolved sufficiently from a scriptie
> should take necessary precautions to check how much data was
> transferred.  Those who don't..well, there is still tomorrow.

Yeah, people write annoying little wrapper functions that
bounce right back into the kernel until the job gets done.
This is slow, it adds both source and object bloat, and it
is a source of extra bugs. What a lovely API, eh?

The fix: write_write_write_damnit() and read_read_read_damnit(),
which go until they hit a fatal error or complete the job.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
