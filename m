Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFYCDO>; Mon, 24 Jun 2002 22:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSFYCDN>; Mon, 24 Jun 2002 22:03:13 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:7161 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S313867AbSFYCDM>; Mon, 24 Jun 2002 22:03:12 -0400
Message-ID: <3D17CF60.1DD1B82D@sympatico.ca>
Date: Mon, 24 Jun 2002 22:03:12 -0400
From: Christian Robert <xtian-test@sympatico.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <3D17BB4B.F5E2571F@sympatico.ca> <200206251043.28051.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> 
> On Tue, 25 Jun 2002 10:37, Christian Robert wrote:
> >   gettimeofday (&tv, NULL);
> How about checking the return value of the function call?
> 
> Brad
> --
> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

$ time ./tloop
Bump negative -4294967295
Summary:
-------
 Min = 0
 Max = 140068
 Avg = 1 (4064861295/3825797418)

real    67m44.891s
user    29m29.690s
sys     27m53.130s


Same thing. Took about an hour before getting the negative bump.

Xtian.

---- modified GetTime() checking return value of gettimeofday() -----

LL GetTime (void)
{
  struct timeval tv;
  LL     retval;
  int    rc;

  while (0 != (rc = gettimeofday (&tv, NULL)))
    printf ("Wow! gettimeofday () returned %d\n", rc);

  retval = (tv.tv_sec * 1000000) + (tv.tv_usec);
  return retval;
}
