Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265181AbSJPQf0>; Wed, 16 Oct 2002 12:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSJPQf0>; Wed, 16 Oct 2002 12:35:26 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:30479 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265181AbSJPQfK>; Wed, 16 Oct 2002 12:35:10 -0400
Date: Wed, 16 Oct 2002 17:40:57 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021016164057.GB85246@compsoc.man.ac.uk>
References: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de> <20021015.190019.41374479.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015.190019.41374479.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181rE9-000Gyq-00*SD6MToojF2g* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 07:00:19PM -0700, David S. Miller wrote:

>    +               return (u32)dentry;
>    
>    Um, isn't this supposed to uniquely identify the dentry?
>    On a platform with 64-bit pointers there's now the theoretical
>    possibility of different dentries getting the same cookie ...
> 
> That's true.
> 
> We dealt with this (trying to use a kernel pointer as a cache held by
> userspace) in tcp_diag by making the actual object opaque.  It was
> actually two u32's, and that way it worked independant of kernel
> vs. user word size.

I'm not sure that's an option :

o userspace needs to know the size of the cookie in the event buffer
o userspace would like to use the cookie as a hash value to avoid
  repeated lookups

Perhaps the best solution would be to use a separate u32 ID value,
allocated linearly. I could just refuse to allocate new dcookies in
theoretical case of overflow.

The other possibility is a dcookiefs (cat
/dev/oprofile/dcookie/34343234) but that's a lot of extra
code/complexity ...

regards
john
-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
