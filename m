Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRKIFPr>; Fri, 9 Nov 2001 00:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279378AbRKIFPi>; Fri, 9 Nov 2001 00:15:38 -0500
Received: from samrat.cisco.com ([192.135.241.27]:41977 "EHLO samrat.cisco.com")
	by vger.kernel.org with ESMTP id <S279303AbRKIFPY>;
	Fri, 9 Nov 2001 00:15:24 -0500
Date: Fri, 9 Nov 2001 10:43:48 +0000 (/etc/localtime)
From: Vino Thomas <jvt@technologist.com>
To: Krishna Kumar <kumarkr@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>, ak@muc.de, andrewm@uow.edu.au,
        "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        IPV6 Mailing List <netdev@oss.sgi.com>, owner-netdev@oss.sgi.com,
        tim@physik3.uni-rostock.de
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <OFE014018A.D6D3430D-ON88256AFE.005C057D@boulder.ibm.com>
Message-ID: <Pine.LNX.4.20.0111091041490.546-100000@vjacob-pc.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krishna,

In 'Case 3' Change the line

	jiffies = start + HZ - 1;
to
	jiffies = start + HZ - 91;

and see the difference.

Regards,
Vino.

On Thu, 8 Nov 2001, Krishna Kumar wrote:

> 
> Hi Linus,
> 
> > >
> > > In short: It is wrong to do
> > >
> > >          if (jiffies <= start+HZ)
> > >
> > > and it is _right_ to do
> > >
> > >          if (jiffies - start <= HZ)
> >
> > Actually this last part is wrong, isn't it ? jiffies <= start + HZ is
> also
> > a correct way to do it, since start+HZ will overflow to the current value
> > of jiffies when HZ time elapses. So the above two statements are
> IDENTICAL.
> >
> > No.
> >
> > Try it out with a few examples. You'll see.
> >
> >                    Linus
> 
> I am sorry, but I still don't see the difference. I wrote a small program
> with different
> cases, but the values still come same irrespective of the input arguments
> to the
> checks. Could you tell under what conditions the checks wuold fail ? The
> 2's
> complement  works the same for addition and subtraction. I have included
> the
> test program below.
> 
> Thanks,
> 
> - KK
> 
> ---------------------------------------------------------------------------------------------
> /*
>      if (jiffies <= start+HZ)
>      if (jiffies - start <= HZ)
> */
> 
> #define HZ 100
> 
> main()
> {
>      unsigned long start, jiffies;
> 
>      /* Case 1 */
>      start = ((unsigned long) -1);
>      jiffies = start + HZ;
>      if (jiffies <= start + HZ) {
>            printf("Less Case 1\n");
>      }
>      if (jiffies - start <= HZ) {
>            printf("Less Case 2\n");
>      }
> 
>      /* Case 2 */
>      start = ((unsigned long) -10);
>      jiffies = start + HZ + 1;
>      if (jiffies <= start + HZ) {
>            printf("Less Case 3\n");
>      }
>      if (jiffies - start <= HZ) {
>            printf("Less Case 4\n");
>      }
> 
>      /* Case 3 */
>      start = ((unsigned long) -10);
>      jiffies = start + HZ - 1;
>      if (jiffies <= start + HZ) {
>            printf("Less Case 5\n");
>      }
>      if (jiffies - start <= HZ) {
>            printf("Less Case 6\n");
>      }
> }
> 
> 
> 

