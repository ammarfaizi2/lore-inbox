Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136695AbREGWp6>; Mon, 7 May 2001 18:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136697AbREGWpt>; Mon, 7 May 2001 18:45:49 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:48137 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S136695AbREGWph>; Mon, 7 May 2001 18:45:37 -0400
Message-ID: <3AF72730.3030604@eisenstein.dk>
Date: Tue, 08 May 2001 00:52:32 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> In particular, does anybody have a buggy Pentium to test with the F0 0F
> lock-up bug? It _should_ be caught with the error-code test (it's a
> protection fault, not a non-present fault and thus the F0 0F case never
> enters the vmalloc path), but it's been several years since the thing..
> 
> If anybody has such a beast, please try this kernel patch _and_ running
> the F0 0F bug-producing program (search for it on the 'net - it must be
> out there somewhere) to verify that the code still correctly handles that
> case.
> 

I have a Thinkpad with a buggy pentium (see cat /proc/cpuinfo below) and 
I tried running the F00F test program available from 
http://lwn.net/2001/0329/a/ltp-f00f.php3 first on a 2.2.17 kernel that 
I've been running for ages without problems I got this output:

Testing for proper f00f instruction handling.
SIGILL received from f00f instruction.  Good.

Then I tried 2.4.4 with your patch applied and got the same output (and 
no lockup), so according to that test program your patch does not break 
the F00F handling code. :-)

If you want me to test other patches, just let me know and I'll be happy 
to do so!

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 8
model name      : Mobile Pentium MMX
stepping        : 1
cpu MHz         : 232.111
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 463.67


Best regards,
Jesper Juhl - juhl@eisenstein.dk

