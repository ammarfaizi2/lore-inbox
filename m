Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319628AbSIMMxh>; Fri, 13 Sep 2002 08:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319629AbSIMMxh>; Fri, 13 Sep 2002 08:53:37 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:29346 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S319628AbSIMMxf> convert rfc822-to-8bit; Fri, 13 Sep 2002 08:53:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: vda@port.imtp.ilyichevsk.odessa.ua, "Jim Sibley" <jlsibley@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
Date: Fri, 13 Sep 2002 07:54:21 -0500
User-Agent: KMail/1.4.1
Cc: riel@conectiva.com.br, ltc@linux.ibm.com, "Troy Reed" <tdreed@us.ibm.com>
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com> <200209130757.g8D7vxp09323@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200209130757.g8D7vxp09323@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209130754.21751.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 07:53 am, Denis Vlasenko wrote:
> On 11 September 2002 16:08, Jim Sibley wrote:
> >                                     resource
> >      group                          priority                kill priority
> >      system                         0                       0 - never
> > kill support                        1                       1
> >      payroll                        2                       2
> >      production                     3                       3
> >      general user                   4                       4
> >      production backgournd          5                       3
>
>                                                              ^^^
>                                  make sure testing and general user are
> killed BEFORE production
>
> >      testing                        6                       5
>
> I like this. Maybe map it to user gid and provide /proc interface?
>
> Let's say on your server you allocated gids this way:
> 0   -   system
> 100 -   support
> 110 -   payroll
> 120 -   production
> 200 -  general user
> 130 -   production background
> 500 - testing
>
> # echo "0 100 110 120 200 130 500" >/proc/resourceprio
> # echo "0 100 110 120 130 200 500" >/proc/killprio

Don't base it on gid. Remember, a user can be a member of multiple
gids for file access. At this point you may get a payroll/production
conflict, or a production/production background conflict.

You really have to use a resource accounting structure that allows
one and only one id per process. A user may (like groups) have
access to multiple resource accounts, but a given process should
only have one.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
