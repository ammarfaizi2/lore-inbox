Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRCRMRb>; Sun, 18 Mar 2001 07:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRCRMRW>; Sun, 18 Mar 2001 07:17:22 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61199 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131207AbRCRMRE>;
	Sun, 18 Mar 2001 07:17:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
        mc@cs.stanford.edu, Andrew Morton <andrewm@uow.edu.au>,
        netdev@oss.sgi.com
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors forlinux 2.4.1 
In-Reply-To: Your message of "Sun, 18 Mar 2001 06:29:50 CDT."
             <3AB49C2E.4792071B@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Mar 2001 23:16:16 +1100
Message-ID: <24784.984917776@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001 06:29:50 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Junfeng Yang wrote:
>> Start --->
>>             busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
>> Error --->
>
>This sizeof() construct may be a special case for your checker, but it's
>a common one for the kernel...  It definitely doesn't de-reference a
>pointer.

IMHO the above line is a bad construct.  If the type of the variable
changes it is extremely easy to miss the fact that *alloc is now
returning the wrong size.  I always do

	busy = kmalloc(sizeof(*busy), GFP_KERNEL);

and let the compiler insert the correct type.

For the checker, you can also have typeof().  kdb has this line

	typeof (*ef)    local_ef;

The type definition of ef is kdb_eframe_t which is "pointer to some
arch dependent type" and local_ef is in arch independent code, much
easier to do this than use multiple #ifdef.  Of course it would have
been even easier if kdb had separate types for the struct and the
pointer to the struct, then I would not need typeof().  OTOH I am sure
that somebody will find a use for typeof().

