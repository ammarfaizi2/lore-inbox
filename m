Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSACICQ>; Thu, 3 Jan 2002 03:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSACICH>; Thu, 3 Jan 2002 03:02:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54283 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288241AbSACIBw>; Thu, 3 Jan 2002 03:01:52 -0500
Message-ID: <3C340EA9.FE084B4C@zip.com.au>
Date: Wed, 02 Jan 2002 23:56:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: Momchil Velikov <velco@fadata.bg>, Oliver Xymoron <oxymoron@waste.org>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
In-Reply-To: <02010216180403.01928@manta> <Pine.LNX.4.43.0201021322120.30079-100000@waste.org> <3C337EF1.4C7C72AB@zip.com.au>, <3C337EF1.4C7C72AB@zip.com.au> <87ell8wgo9.fsf@fadata.bg> <3C340601.E9A3507F@zip.com.au>,
		<3C340601.E9A3507F@zip.com.au>; from akpm@zip.com.au on Wed, Jan 02, 2002 at 11:19:29PM -0800 <20020102234226.A23580@lucon.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" wrote:
> 
> ...
> Compile doesn't emit the size info for
> 
> extern char a;

You're right.  I goofed.
 
> One way to fix it is to remove
> 
> extern char a;
> 
> and put
> 
> extern int a;
> 
> in a header file which is included by everyone.
> 

Yup.  Problem is, we have about 1500 instances in the kernel :(

(Wouldn't it be nice if `int a;' generated a compiler error
if a declaration `extern int a;' was not in scope?)

Oh well.  Seems that disabling -fno-common and enabling
--warn-common is the only way to autodetect bugs such as this.

-
