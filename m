Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTBXV2B>; Mon, 24 Feb 2003 16:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTBXV2B>; Mon, 24 Feb 2003 16:28:01 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60668 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267493AbTBXV14>; Mon, 24 Feb 2003 16:27:56 -0500
Date: Mon, 24 Feb 2003 22:38:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030224213801.GF7685@fs.tum.de>
References: <Pine.LNX.3.95.1030224143236.14614A-100000@chaos> <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:02:39PM -0800, Linus Torvalds wrote:
>...
> Does gcc still warn about things like
> 
> 	#define COUNT (sizeof(array)/sizeof(element))
> 
> 	int i;
> 	for (i = 0; i < COUNT; i++)
> 		...
> 
> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> unsigned)?
> 
> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> 
> Any compiler that complains about the above should be shot in the head, 
> and the warning should be killed.


In the program below -Wall doesn't warn in neither 2.95 nor 3.2. You
need -Wsign-compare to get a warning. IMHO a warning is useful in this
example, some people might wrongly assume that the "Hello, world!" would
be printed more than once.


<--  snip  -->

#include <stdio.h>

int array[] = {1, 2, 3, 4, 5};

#define COUNT (sizeof(array)/sizeof(array[0]))

int main()
{
  int i;

  for (i = 0; i < COUNT; i++)
    {
      i -= 2;
      printf("Hello, world!\n");
    }

  return(0);
}

<--  snip  -->

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

