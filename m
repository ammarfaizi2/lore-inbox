Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135992AbRDTTJZ>; Fri, 20 Apr 2001 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135993AbRDTTJF>; Fri, 20 Apr 2001 15:09:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24448 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135990AbRDTTJA>; Fri, 20 Apr 2001 15:09:00 -0400
Date: Fri, 20 Apr 2001 15:07:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Victor Zandy <zandy@cs.wisc.edu>
cc: linux-kernel@vger.kernel.org, pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpx8zkvz9r5.fsf@goat.cs.wisc.edu>
Message-ID: <Pine.LNX.3.95.1010420145755.11087A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2001, Victor Zandy wrote:

> 
> Victor Zandy <zandy@cs.wisc.edu> writes:
> > We have found that one of our programs can cause system-wide
> > corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
> > run this program, the FPU gives bad results to all subsequent
> > processes.
> 
> We have now tested 2.4.2 and 2.2.19.
> 
> 2.2.19 has the same problem.
> 
> 2.4.3 does not seem to be affected.  Unfortunately, we really need a
> working 2.2 kernel at this time.
> 
> We also patched the 2.2.19 kernel with the PIII patch found in
> /pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre13/PIII-10.bz2
> on ftp.kernel.org.  Same problem.
> 
> Does anyone have any ideas for us?
> 
> Thanks.
> 
> Vic

Just for kicks, do whatever is necessary to "break" the fpu. Then run
this program:

int  main()
{
        __asm__("finit\n");
        return 0;
}

If it "fixes" it, there is no problem with the FPU, but with the
'C' runtime library which doesn't initialize the FPU to a known
state before it uses it. It is possible for the kernel to work
around th 'C' library problem by clearing the FPU after every
fork(). The last time I checked (years ago), 'finit' was executed
during the fork. Maybe it isn't anymore because it takes many
machine-cycles to complete.

If this doesn't "fix" it, then your hardware may have a problem
like overheating, etc., (loose heatsink?).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


