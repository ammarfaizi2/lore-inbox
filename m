Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131050AbRBHLob>; Thu, 8 Feb 2001 06:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbRBHLoV>; Thu, 8 Feb 2001 06:44:21 -0500
Received: from [202.212.27.182] ([202.212.27.182]:14088 "HELO antiopikon")
	by vger.kernel.org with SMTP id <S131050AbRBHLoL>;
	Thu, 8 Feb 2001 06:44:11 -0500
Date: Thu, 8 Feb 2001 20:44:15 +0900
From: Augustin Vidovic <vido@ldh.org>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: Alan Cox <alan@redhat.com>, Andrey Savochkin <saw@saw.sw.com.sg>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
Message-ID: <20010208204415.A19308@ldh.org>
Reply-To: vido@ldh.org
In-Reply-To: <20010208201539.A19229@ldh.org> <200102081126.f18BQpS18016@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102081126.f18BQpS18016@moisil.dev.hydraweb.com>; from ionut@moisil.cs.columbia.edu on Thu, Feb 08, 2001 at 03:26:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 03:26:51AM -0800, Ion Badulescu wrote:
> syslogd does not suppress messages, it suppresses *identical* messages.
> So what was the *first* message logged by syslogd, the one followed by
> "last message repeated XXX times"?

It's not "last message repeatead XXX times", it's :
...
Jan 30 00:01:18 XXX kernel: NET: 8298 messages suppressed. 
Jan 30 00:01:24 XXX kernel: NET: 2929 messages suppressed. 
Jan 30 00:01:38 XXX kernel: NET: 1225 messages suppressed. 
Jan 30 00:01:43 XXX kernel: NET: 4397 messages suppressed. 
Jan 30 00:01:48 XXX kernel: NET: 2342 messages suppressed. 
...
(ad nauseam)

This suppression of thousands of lines was described as a DOS-protection
in the docs I read.

> Umm, no. With your patch, both the diagnostic and the activation are wrong,
> whereas before only the diagnostic was wrong.

With my patch, the test becomes (eeprom[3] & 0x03), which is not null
for every possible non-null value of the two lower bits :

	bit1	bit0	[bit1,bit0]&[1,1]
	0	0	00
	0	1	01
	1	0	10
	1	1	11

Whereas the other test is more restrictive, because it excludes the "11"
from the results.
The old cards still get the workaround enabled this this wider test.

> > Now, I do not get _any_ message in the logs, which means that the network
> > cards activity is closer to normality than before the patch.
> 
> So your patch did not do you any good. Case closed, as far as the work-around
> is concerned.

To the contrary, it seems to do a lot of good, because the NET subsystem
does not send any more panic messages to the kernel, and the cluster has
not meltdown again so far.

> If you post the original log messages, we might be able to find the real
> bug...

Sorry, I can't, as they were suppressed (as you can see in the example
I copy-pasted before in this mail), and now I don't get any other one.

> [and please don't drop the Cc:]

Ok, if you insist.

-- 
Augustin Vidovic                   http://www.vidovic.org/augustin/
"Nous sommes tous quelque chose de naissance, musicien ou assassin,
 mais il faut apprendre le maniement de la harpe ou du couteau."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
