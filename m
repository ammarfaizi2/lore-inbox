Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRKHRAN>; Thu, 8 Nov 2001 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276647AbRKHRAE>; Thu, 8 Nov 2001 12:00:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:62348 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276591AbRKHQ75>; Thu, 8 Nov 2001 11:59:57 -0500
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, ak@muc.de, andrewm@uow.edu.au,
        "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        owner-netdev@oss.sgi.com, tim@physik3.uni-rostock.de
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE014018A.D6D3430D-ON88256AFE.005C057D@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Thu, 8 Nov 2001 08:55:51 -0800
X-MIMETrack: Serialize by Router on D03NM066/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/08/2001 09:59:35 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

> >
> > In short: It is wrong to do
> >
> >          if (jiffies <= start+HZ)
> >
> > and it is _right_ to do
> >
> >          if (jiffies - start <= HZ)
>
> Actually this last part is wrong, isn't it ? jiffies <= start + HZ is
also
> a correct way to do it, since start+HZ will overflow to the current value
> of jiffies when HZ time elapses. So the above two statements are
IDENTICAL.
>
> No.
>
> Try it out with a few examples. You'll see.
>
>                    Linus

I am sorry, but I still don't see the difference. I wrote a small program
with different
cases, but the values still come same irrespective of the input arguments
to the
checks. Could you tell under what conditions the checks wuold fail ? The
2's
complement  works the same for addition and subtraction. I have included
the
test program below.

Thanks,

- KK

---------------------------------------------------------------------------------------------
/*
     if (jiffies <= start+HZ)
     if (jiffies - start <= HZ)
*/

#define HZ 100

main()
{
     unsigned long start, jiffies;

     /* Case 1 */
     start = ((unsigned long) -1);
     jiffies = start + HZ;
     if (jiffies <= start + HZ) {
           printf("Less Case 1\n");
     }
     if (jiffies - start <= HZ) {
           printf("Less Case 2\n");
     }

     /* Case 2 */
     start = ((unsigned long) -10);
     jiffies = start + HZ + 1;
     if (jiffies <= start + HZ) {
           printf("Less Case 3\n");
     }
     if (jiffies - start <= HZ) {
           printf("Less Case 4\n");
     }

     /* Case 3 */
     start = ((unsigned long) -10);
     jiffies = start + HZ - 1;
     if (jiffies <= start + HZ) {
           printf("Less Case 5\n");
     }
     if (jiffies - start <= HZ) {
           printf("Less Case 6\n");
     }
}


