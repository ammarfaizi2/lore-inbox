Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVA2RDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVA2RDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVA2RDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:03:30 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:942 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261152AbVA2RDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:03:20 -0500
Message-ID: <41FBC200.9050404@comcast.net>
Date: Sat, 29 Jan 2005 12:04:00 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <41F95F79.6080904@comcast.net>	 <1106862801.5624.145.camel@laptopd505.fenrus.org>	 <41F96C7D.9000506@comcast.net>	 <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>	 <41FB2DD2.1070405@comcast.net>	 <1106986224.4174.65.camel@laptopd505.fenrus.org>	 <41FBB821.3000403@comcast.net> <1107017218.4174.130.camel@laptopd505.fenrus.org>
In-Reply-To: <1107017218.4174.130.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Sat, 2005-01-29 at 11:21 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>
>>
>>Arjan van de Ven wrote:
>>
>>>>I actually just tried to paxtest a fresh Fedora Core 3, unadultered,
>>>>that I installed, and it FAILED every test.  After a while, spender
>>>>reminded me about PT_GNU_STACK.  It failed everything but the Executable
>>>>Stack test after execstack -c *.  The randomization tests gave
>>>>13(heap-etexec), 16(heap-etdyn), 17(stack), and none for main exec
>>>>(etexec,et_dyn) or shared library randomization.
>>>
>>>
>>>because you ran prelink.
>>>and you did not compile paxtest with -fPIE -pie to make it a PIE
>>>executable.
>>>
> 
> 
> what I get is
> 
> Executable anonymous mapping             : Killed
> Executable bss                           : Killed
> Executable data                          : Vulnerable
> Executable heap                          : Killed
> Executable stack                         : Killed
> Executable anonymous mapping (mprotect)  : Vulnerable
> Executable bss (mprotect)                : Vulnerable
> Executable data (mprotect)               : Vulnerable
> Executable heap (mprotect)               : Vulnerable
> Executable shared library bss (mprotect) : Vulnerable
> Executable shared library data (mprotect): Vulnerable
> Executable stack (mprotect)              : Vulnerable
> Anonymous mapping randomisation test     : No randomisation
> Heap randomisation test (ET_EXEC)        : 13 bits (guessed)
> Heap randomisation test (ET_DYN)         : 13 bits (guessed)
> Main executable randomisation (ET_EXEC)  : 12 bits (guessed)
> Main executable randomisation (ET_DYN)   : 12 bits (guessed)
> Shared library randomisation test        : 12 bits (guessed)
> Stack randomisation test (SEGMEXEC)      : 17 bits (guessed)
> Stack randomisation test (PAGEEXEC)      : 17 bits (guessed)
> Return to function (strcpy)              : paxtest: bad luck, try
> different compiler options.
> Return to function (strcpy, RANDEXEC)    : paxtest: bad luck, try
> different compiler options.
> Return to function (memcpy)              : Vulnerable
> Return to function (memcpy, RANDEXEC)    : Vulnerable
> Executable shared library bss            : Killed
> Executable shared library data           : Killed
> Writable text segments                   : Vulnerable
> 
> 
> I'm not entirely happy yet (it shows a bug in mmap randomisation) but
> it's way better than what you get in your tests (this is the desabotaged
> 0.9.6 version fwiw)
> 

I used 0.9.6 too, it had a slight bug in the randomization test
(getmain.c), which I pointed out in another post.

void foo( int unused )
{
        printf( "%p\n", __builtin_return_address(0) );
        //printf( "0x%08x\n", ((unsigned long*)&unused)[-1] );
}

I'm curious as to what the hell you're doing to get these results.  Exec
Shield came with the sysctl sys/kernel/exec-shield = 1 and
sys/kernel/exec-shield-randomize = 1.  I tried exec-shield = 0, 1, 2,
and 3 and couldn't get anything but the stack to kill on a Barton cored
32 bit athlon xp.

The tests I did were on a Fedora Core 3 i net-installed last night, no
adulteration.  Whatever black magic you're doing, it's not working here.
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+8H/hDd4aOud5P8RAlIEAJkBwhIxdrXZ+jNz46oRg1SoSPmOHQCgiWfJ
HxzCBB43i6iLLhli5boKzoM=
=etT7
-----END PGP SIGNATURE-----
