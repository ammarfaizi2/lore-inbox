Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDDTUQ>; Thu, 4 Apr 2002 14:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDDTUM>; Thu, 4 Apr 2002 14:20:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30227 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310201AbSDDTTp>; Thu, 4 Apr 2002 14:19:45 -0500
Message-ID: <3CACA74A.1000004@zytor.com>
Date: Thu, 04 Apr 2002 11:19:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>	<a8flgc$ms2$1@cesium.transmeta.com>	<m1lmc3qtaz.fsf@frodo.biederman.org> <3CAC9BD4.5050500@zytor.com> <m1hemrqo9b.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
>>There can't be a "default load address".  0x90000 is actively dangerous and
>>trying to encourage it for anything than legacy kernels is WRONG. If you can't
>>handle this, then you need to go back to the drawing board.
> 
> 
> I agree.  But I do think being able to hard code the load address is a
> very good thing.
> 
> After digesting the requirements I plan on having setup.S call int 12h
> (so the information is available), and then having misc.c relocate the
> real mode code, and the command line, out of the way, of it's
> decompression buffer.  This removes the need for bootloaders to
> make a tradeoff between memory use efficiency and reliability.
> 
> This should give me about 630KB on machines designed to run DOS, where
> this matters.   Better than the current best of 572KB, with the real
> mode code @ 0x90000. 
> 
> And when your total size is 1-4MB.  +-640KB is a significant change.
> 

Agreed.  Note that so far putting the real mode code *above* 0x90000 is 
completely untested.  It *should* work with boot protocol 2.02 support; 
it almost certainly *does not* work with earlier boot protocols (due to 
the "move it back to 0x90000" braindamage.)

	-hpa

