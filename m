Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291309AbSBGU6e>; Thu, 7 Feb 2002 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291307AbSBGU6Y>; Thu, 7 Feb 2002 15:58:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39698 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291298AbSBGU6U>;
	Thu, 7 Feb 2002 15:58:20 -0500
Message-ID: <3C62EA2F.FDA9E241@zip.com.au>
Date: Thu, 07 Feb 2002 12:57:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Ingo Molnar <mingo@elte.hu>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, rml <rml@tech9.net>,
        nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <20020207125601.A21354@hq.fsmlabs.com> <Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>,
		<Pine.LNX.4.33.0202072305480.2976-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Feb 07, 2002 at 11:09:16PM +0100 <20020207133109.B21935@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
>         llseek:
>                 atomic_enquee request
>                 if no room gotta sleep
>                 else if trylock mutex
>                         return
>                      else
>                         do work
>                         loop:
>                              process any pending requests
>                              release lock;
>                              if pending_requests && !(trylock mutex) goto loop

This is how printk() works.  It was a very powerful and satisfactory
solution to a nasty locking/atomicity problem.  It'd be nice to have
a more generic way of expressing that solution.

-
