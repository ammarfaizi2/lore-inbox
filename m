Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154712-8316>; Wed, 9 Sep 1998 19:35:47 -0400
Received: from caffeine.ix.net.nz ([203.97.100.28]:4731 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <155043-8316>; Wed, 9 Sep 1998 17:19:16 -0400
Date: Thu, 10 Sep 1998 11:55:03 +1200
From: Chris Wedgwood <chris@cybernet.co.nz>
To: Colin Plumb <colin@nyx.net>, tytso@MIT.EDU
Cc: andrejp@luz.fe.uni-lj.si, linux-kernel@vger.rutgers.edu
Subject: Re: GPS Leap Second Scheduled!
Message-ID: <19980910115503.A24728@caffeine.ix.net.nz>
References: <199809092013.OAA10252@nyx10.nyx.net> <19980910114515.A20254@caffeine.ix.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MGYHOYXEY6WxJCY8
X-Mailer: Mutt 0.94.5i
In-Reply-To: <19980910114515.A20254@caffeine.ix.net.nz>; from Chris Wedgwood on Thu, Sep 10, 1998 at 11:45:15AM +1200
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii

On Thu, Sep 10, 1998 at 11:45:15AM +1200, Chris Wedgwood wrote:

> The attached code on a PPro 200 gives me results of 2 usecs, using a
> P.II 300 and SYSENTER semantics, you can probably get this to less
> that 1usec.

Crap... here it is.



-cw

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tv-test.c"

#include <sys/time.h>
#include <unistd.h>
#include <stdio.h>

int	main()
{
	struct timeval	t1,t2,t3,t4;
	
	do{
		/* warm caches */
		gettimeofday(&t1,NULL);
		gettimeofday(&t2,NULL);
		gettimeofday(&t3,NULL);
		gettimeofday(&t4,NULL);

		gettimeofday(&t3,NULL);
		gettimeofday(&t4,NULL);
	}while(t3.tv_sec != t4.tv_sec); /* yuk */

	printf("%d usecs difference!\n",(int)(t4.tv_usec - t3.tv_usec));
	
	
	return	0;
}
                       
--MGYHOYXEY6WxJCY8--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
