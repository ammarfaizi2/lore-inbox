Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRKBSS0>; Fri, 2 Nov 2001 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKBSSQ>; Fri, 2 Nov 2001 13:18:16 -0500
Received: from modem-3583.leopard.dialup.pol.co.uk ([217.135.157.255]:60690
	"EHLO Mail.MemAlpha.cx") by vger.kernel.org with ESMTP
	id <S280764AbRKBSSF>; Fri, 2 Nov 2001 13:18:05 -0500
Posted-Date: Thu, 1 Nov 2001 23:51:40 GMT
Date: Thu, 1 Nov 2001 23:51:39 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Doug McNaught <doug@wireboard.com>
cc: Ville Herva <vherva@niksula.hut.fi>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
In-Reply-To: <m31yjjz6ws.fsf@belphigor.mcnaught.org>
Message-ID: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug.

>> Are you sure?

>>> find / -name "wanted-but-lost-download" | eat

>> Doesn't work - you're piping the stdin there, not stderr as per my
>> example above. AFAIK, there's no way to pipe stderr without also
>> piping stdout, hence this sort of solution just doesn't work.

> The Bourne shell is more perverse than you realize:
>
> $ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- | eat
>
> [stolen from "Csh Programming Considered Harmful" by Tom Christiansen]
>
> Horrible, but does work.  ;) 

Are you sure that works with BASH ? I've seen it listed (without the
`exec 3>&1;` at the beginning) as a CSH method for doing this, but I've
never had it work under bash, so presume the exec at the beginning is
needed for bash to be able to do this. Is that right?

Also, even if it's true, is that also true with all other possible
shells? Redirecting to /dev/null is independant of the shells, but
piping hacks like that aren't.

I'm not on bash at the moment, and don't have it available, but I'll try
it when I get home...

>>> zerofill | head -c 1440k > /tmp/floppy.img

>> How does zerofill know when to stop writing zeros out?

> Easy, it gets EPIPE on the write (or gets killed by SIGPIPE if it's
> stupid).

So it should be deliberately written to write them out in an infinite
loop? Makes a bizarre sort of sense, but not something I would ever do.

Also, as I've had pointed out to me, one sometimes needs to tell a
program to take input other than stdin from /dev/zero and that often
can't be done using pipes. The friend who pointed this out to me
recently had reason to do precicely this. The following isn't exactly
what he needed, but is similar...

 Q> ebcdic2ascii < /dev/ttyS1 | tr A-Z a-z | bindiff /dev/zero /dev/stdin

...and I would be very interested in a shell script to duplicate that
using the `zerofill` program referred to above.

>>> ssh foo@bar | block

>> Which of my examples is this an equivalent to? I don't recognise it.

> None; he's referring to the /dev/block example that started the
> thread.

> I'm still happy to keep /dev/null and /dev/zero.  ;)

So am I.

Best wishes from Riley.

