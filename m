Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSFYCsB>; Mon, 24 Jun 2002 22:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFYCsA>; Mon, 24 Jun 2002 22:48:00 -0400
Received: from otter.mbay.net ([206.55.237.2]:12299 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S314096AbSFYCsA> convert rfc822-to-8bit;
	Mon, 24 Jun 2002 22:48:00 -0400
From: John Alvord <jalvo@mbay.net>
To: Christian Robert <xtian-test@sympatico.ca>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Date: Mon, 24 Jun 2002 19:47:51 -0700
Message-ID: <ecmfhuopshut8luclo6asqorsj4b1sa13q@4ax.com>
References: <3D17BB4B.F5E2571F@sympatico.ca> <200206251043.28051.bhards@bigpond.net.au> <3D17CF60.1DD1B82D@sympatico.ca>
In-Reply-To: <3D17CF60.1DD1B82D@sympatico.ca>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe this is the result of floating point rounding errors. Floating
point is notorious for occaisional strange results. I suggest redoing
the test program to keep all results in integer and seeing what
happens...

john


On Mon, 24 Jun 2002 22:03:12 -0400, Christian Robert
<xtian-test@sympatico.ca> wrote:

>Brad Hards wrote:
>> 
>> On Tue, 25 Jun 2002 10:37, Christian Robert wrote:
>> >   gettimeofday (&tv, NULL);
>> How about checking the return value of the function call?
>> 
>> Brad
>> --
>> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
>
>$ time ./tloop
>Bump negative -4294967295
>Summary:
>-------
> Min = 0
> Max = 140068
> Avg = 1 (4064861295/3825797418)
>
>real    67m44.891s
>user    29m29.690s
>sys     27m53.130s
>
>
>Same thing. Took about an hour before getting the negative bump.
>
>Xtian.
>
>---- modified GetTime() checking return value of gettimeofday() -----
>
>LL GetTime (void)
>{
>  struct timeval tv;
>  LL     retval;
>  int    rc;
>
>  while (0 != (rc = gettimeofday (&tv, NULL)))
>    printf ("Wow! gettimeofday () returned %d\n", rc);
>
>  retval = (tv.tv_sec * 1000000) + (tv.tv_usec);
>  return retval;
>}
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

