Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313490AbSDEWFk>; Fri, 5 Apr 2002 17:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313648AbSDEWFb>; Fri, 5 Apr 2002 17:05:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43024 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313490AbSDEWFK>; Fri, 5 Apr 2002 17:05:10 -0500
Message-ID: <3CAE1F75.2010803@zytor.com>
Date: Fri, 05 Apr 2002 14:04:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>	<a8flgc$ms2$1@cesium.transmeta.com>	<m1lmc3qtaz.fsf@frodo.biederman.org> <3CAC9BD4.5050500@zytor.com>	<m1hemrqo9b.fsf@frodo.biederman.org> <3CACA74A.1000004@zytor.com> <m1zo0homsv.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>>Agreed.  Note that so far putting the real mode code *above* 0x90000 is
>>completely untested.  It *should* work with boot protocol 2.02 support; it
>>almost certainly *does not* work with earlier boot protocols (due to the "move
>>it back to 0x90000" braindamage.)
> 
> Having misc.c move the real mode code and the command line above
> 0x90000 avoids this issue.  I relocate the command line so
> cmd_line_ptr must be written.  This looses track of exactly which
> protocol version the bootloader was using, but it doesn't matter as
> all the kernel cares about is being able to find it's command line,
> and the command line can still be found.  For code coming in the new
> 32bit entry point we are above protocol version 2.02 when the problem
> was fixed.
> 
> I have now solved the space/reliability tradeoff with belt and suspenders.
> 
> I have modified misc.c to do an inplace decompression.  This means I
> use approximately 78KB of memory below 1MB and 8 bytes more than the
> decompressesed kernel above 1MB.  And if I have to except for the 5KB
> of real mode code I can put everything above 1MB.  The 78KB is 5KB
> real mode code 10KB decompressor code 61KB bss. 
> 
> The change is especially nice because now in my worst case of only
> using 5KB real mode data, I do better than the best case with previous
> kernels (assuming it isn't a zImage).  And if I ever get the bootmem
> bootmap fixed I can put initrds down at 2.6MB and not have to worry
> about them getting stomped :)
> 

Nice.

