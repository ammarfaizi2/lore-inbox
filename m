Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266953AbSKVHEV>; Fri, 22 Nov 2002 02:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbSKVHEV>; Fri, 22 Nov 2002 02:04:21 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:46349
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266100AbSKVHEU>; Fri, 22 Nov 2002 02:04:20 -0500
Subject: Re: RFC - new raid superblock layout for md driver
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Organization: 
Message-Id: <1037949088.29451.20.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 23:11:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 20:09, Neil Brown wrote:
> My current design looks like:
> 	/* constant array information - 128 bytes */
>     u32  md_magic
>     u32  major_version == 1
>     u32  feature_map     /* bit map of extra features in superblock */
>     u32  set_uuid[4]
>     u32  ctime
>     u32  level
>     u32  layout
>     u64  size		/* size of component devices, if they are all
> 			 * required to be the same (Raid 1/5 */
Can you make 64 bit fields 64 bit aligned?  I think PPC will lay this
structure out with padding before size, which may well cause confusion. 
If your routines to load and save the header don't depend on structure
layout, then it doesn't matter.
        J

