Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316296AbSEVRaV>; Wed, 22 May 2002 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSEVRaU>; Wed, 22 May 2002 13:30:20 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:62980 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316296AbSEVRaT>; Wed, 22 May 2002 13:30:19 -0400
Date: Wed, 22 May 2002 18:30:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522183012.J16934@flint.arm.linux.org.uk>
In-Reply-To: <E17AZoV-0002I7-00@the-village.bc.nu> <3CEBC496.9030900@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 06:17:26PM +0200, Martin Dalecki wrote:
> #include <linux/io.h>
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main(char *argv[], int argc)
> {
> 	int port = aoit(argv[0]);
> 	 int byte = aoit(argv[1]);
> 
> 	if (port > 0)
> 		return inb(port);		
> 	 else
> 			outb(port, byte);
> 
> 
> 		return 0;
> }

Erm:

1. not checking number of arguments passed.
2. thinking argv[0] is the first arg.
3. wrong test for in/out (port > 0 -> inb, port <= 0 -> outb)
4. returning the read byte via the program status code.
5. aoit is an undefined function.
6. including linux/*.h is fundamentally wrong for any user space
   program.

That's one bug every 2 lines.  Should I continue? 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

