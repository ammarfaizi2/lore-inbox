Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDWVdb>; Mon, 23 Apr 2001 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDWVdW>; Mon, 23 Apr 2001 17:33:22 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:31399 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132226AbRDWVdP>; Mon, 23 Apr 2001 17:33:15 -0400
Date: Mon, 23 Apr 2001 23:33:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Matt <madmatt@bits.bris.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl arg passing
Message-ID: <20010423233312.Y682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk> <Pine.LNX.4.21.0104232051040.7619-100000@bits.bris.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0104232051040.7619-100000@bits.bris.ac.uk>; from madmatt@bits.bris.ac.uk on Mon, Apr 23, 2001 at 08:58:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 08:58:54PM +0100, Matt wrote:
> Matt aka Doofus festures mentioned the following:
> 
> | struct instruction_t local;
> | __s16 *temp;
> | 
> | copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
> | temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
> | copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
> 
> I meant that last line to be:
> 
> copy_from_user( temp, local.rxbuf, sizeof( __s16 ) * local.rxlen );
>                       ^^^^^^^^^^^
> That's the main crux of my query, can I retrieve the value of a pointer
> in some struct passed via ioctl? In this case, the struct/chunk of memory
> referenced by local.rxbuf, (which is rxlen x 2 bytes big).

Yes, that works (with the obvious note on checking argument sizes
and not kmallocing too much memory).

All "read" functions do the same. As you were clever enough to
copy the pointer itself into kernel space, too (which many driver
writes forget!), you have done the right thing here.

Congratulations! ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
