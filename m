Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271608AbRHUIkB>; Tue, 21 Aug 2001 04:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271609AbRHUIjv>; Tue, 21 Aug 2001 04:39:51 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:9191 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271608AbRHUIji> convert rfc822-to-8bit;
	Tue, 21 Aug 2001 04:39:38 -0400
Date: Tue, 21 Aug 2001 09:39:49 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <605512235.998386789@[169.254.45.213]>
In-Reply-To: <9lrc6u$6pv$1@abraham.cs.berkeley.edu>
In-Reply-To: <9lrc6u$6pv$1@abraham.cs.berkeley.edu>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Alex Bligh - linux-kernel  wrote:
>> OK; well in which case it doesn't solve the problem.
>
> I don't see why not.  Apply this change, and use /dev/urandom.
> You'll never block, and the outputs should be thoroughly unpredictable.
> What's missing?

See message to Oliver - para on waiting for sufficient entropy;
/dev/urandom (before that arrives) is just as theoretically
vulnerable as before.

> (I don't see why so many people use /dev/random rather than /dev/urandom.
> I harbor suspicions that this is a misunderstanding about the properties
> of pseudorandom number generation.)

Things like (from the manpage):

       When read, the /dev/random device will only return  random
       bytes  within the estimated number of bits of noise in the
       entropy pool.  /dev/random should  be  suitable  for  uses
       that  need  very  high quality randomness such as one-time
       pad or key generation.  When the entropy  pool  is  empty,
       reads  to /dev/random will block until additional environ­
       mental noise is gathered.

       When read, /dev/urandom device will return as  many  bytes
       as are requested.  As a result, if there is not sufficient
       entropy in the entropy pool, the returned values are theo­
       retically  vulnerable  to  a  cryptographic  attack on the
       algorithms used by the driver.  Knowledge  of  how  to  do
       this is not available in the current non-classified liter­
       ature, but it  is  theoretically  possible  that  such  an
       attack  may  exist.  If this is a concern in your applica­
       tion, use /dev/random instead.

So writers of ssh, ssl etc. all go use /dev/random, which is not
'theoretically vulnerable to a cryptographic attack'. This means,
in practice, that they are dysfunctional on some headless systems
without Robert's patch. Robert's patch may make them slightly
less 'perfect', but not as imperfect as using /dev/urandom instead.
Using /dev/urandom has another problem: Do we expect all applications
now to have a compile option 'Are you using this on a headless
system in which case you might well want to use /dev/urandom
instead of /dev/random?'. By putting a config option in the kernel,
this can be set ONCE and only degrade behaviour to the minimal
amount possible.


--
Alex Bligh
