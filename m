Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312747AbSDBC6U>; Mon, 1 Apr 2002 21:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312748AbSDBC6L>; Mon, 1 Apr 2002 21:58:11 -0500
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:10113 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S312747AbSDBC6A>;
	Mon, 1 Apr 2002 21:58:00 -0500
Message-ID: <3CA91D04.2050001@bcgreen.com>
Date: Mon, 01 Apr 2002 18:52:52 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org
Subject: Frustrating stack overflow exploits
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading through an article last week about buffer overflows,
( http://www.enseirb.fr/~glaume/bof/report.html ) a thought
came to me:

It appears that stack overflow exploits are based on knowing (roughly)
where the stack is going to be when the buffer overflows.  It appears to
me that it would be possible to frustrate people attempting to exploit
such bugs by having the stack start at a random location in (say) a
10MB range near the top of memory.

As a result of such a change, most current buffer overflows would only
succeed once in a few thousand tries, unless one was able to overrun the
buffer by a large number of Kilobytes (something which is a good bit
harder to do, in many cases).  This would really only frustrate
execute-arbitrary-code types of exploits (you could still cause
a program to 'return' to a wrong location, but this -- again
adds work for the cracker.

The only costs I can see to this are:
  1) the stack would no longer be contiguous with other high-memory areas,
  2) you would lose s small ammount of VM headroom (only a problem for programs
     that actually use a large proportion of the address space)

The advantage is that this would add (possibly prohibitive) cost to
some form of stack overflow attacks. It effectively makes the stack
non-executable for an attacker who can't determine where the stack
starts for a given process -- security by obfuscation. In many ways,
this isn't much different than what is now done in choosing random
initial sequence numbers for TCP connections.

Similar changes could be made to the base address of the heap, with
similar costs.

Making this sort of change to the BSS and text segments would probably
require changes to the loader (I don't know the details of the loader
so I really can't say, for sure). but would similarly make it very
difficult for an intruder to jump to an arbitrary piece of known
loaded code.

I realize that this isn't as good as actually fixing the broken code
(anybody willing to lead a bsd=style code audit?), but it would provide
some protection against badly written code from all sorts of sources --
including proprietary code for which a security audit would not be possible.

Thoughts??

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

