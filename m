Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313050AbSC0QVP>; Wed, 27 Mar 2002 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313051AbSC0QVG>; Wed, 27 Mar 2002 11:21:06 -0500
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:10500 "HELO
	gandalf.physik.uni-konstanz.de") by vger.kernel.org with SMTP
	id <S313049AbSC0QUx>; Wed, 27 Mar 2002 11:20:53 -0500
Date: Wed, 27 Mar 2002 17:20:50 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: agx@sigxcpu.org, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: indydog driver race
Message-ID: <20020327172050.A17906@gandalf.physik.uni-konstanz.de>
In-Reply-To: <3CA0B784.6050809@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 10:01:40AM -0800, Dave Hansen wrote:
> indydog_open has a race
> 
> indydog_open(struct inode *inode, struct file *file)
> {
>          if( indydog_alive )
> 		return -EBUSY;	
> 	...
> 	 indydog_alive = 1;
>          return 0;
> }
> 
> If 2 opens happen simultaneously, there can be 2 tasks which both see 
> indydog_alive as 0 and both set it to 1, successfully opening the 
> device.  Block and char devices hold the BKL before calling the driver's 
> open function, but misc devices don't do the same.
As Dave and me discussed in private mail this can't actually happen on
non-preemtible kernels since IP22 is non-SMP(which is why I didn't
bother when I wrote it). Anyway, a race is a race, no excuses.

> 
> The BKL is not needed in the release function, as far as I can see. 
> Alan's softdog.c driver uses atomic ops without BKL to do the same thing 
> as your driver.  Patch to fix attached.
Tested and works on Mips/IP22. Thanks again Dave,
 -- Guido
