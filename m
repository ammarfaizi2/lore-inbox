Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSDZLhu>; Fri, 26 Apr 2002 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSDZLht>; Fri, 26 Apr 2002 07:37:49 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:24252 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S313827AbSDZLht>;
	Fri, 26 Apr 2002 07:37:49 -0400
Message-ID: <3CC93C0A.1030500@iram.es>
Date: Fri, 26 Apr 2002 13:37:46 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.5) Gecko/20011016
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Zealey <mark@zealos.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Assembly question
In-Reply-To: <20020425083225.GA30247@webvilag.com> <20020425235240.GA28851@itsolve.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Zealey wrote:

 > On Thu, Apr 25, 2002 at 10:32:25AM +0200, Szekeres Istvan wrote:
 >
 >
 >> void p_memset_dword( void *d, int b, int l ) { __asm__ ("rep\n\t" 
"stosl\n\t"
 >>

 >> : : "D" (d), "a" (b), "c" (l) : "memory","edi", "eax", "ecx"
 >>
 >
 > An input or output operand is implicitly clobbered, so it should be
      ^^^^^
I had expected gcc specialists to jump on that one: if you don't
explicitly tell gcc that an input is clobbered, it may reuse it later if
it needs the same value. So the clobbers are necessary...

Your statement about output operands is also incorrect, since clobbered
means that the register has an unknown value, which can not be used for
_anything_, while outputs are results from the statement and they'll
likely be used later (if none of the outputs is ever used and the asm 
statement is not marked volatile, gcc will not even bother to emit it).

	Regards,
	Gabriel.

