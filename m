Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSHHDxR>; Wed, 7 Aug 2002 23:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSHHDxR>; Wed, 7 Aug 2002 23:53:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:15086 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S317334AbSHHDxR>;
	Wed, 7 Aug 2002 23:53:17 -0400
Date: Thu, 8 Aug 2002 13:44:07 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates
Message-Id: <20020808134407.18fe4041.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002 12:17:13 -0700 (PDT)
Patrick Mochel <mochel@osdl.org> wrote:
> I've also created a macro[1] for defining device attributes, that goes
> like this:
> 
> DEVICE_ATTR(name,"strname",mode,show,store);
> 
> This will create a structure by the name of 'dev_attr_##name', where
> ##name is the first parameter, which can then be passed to
> device_create_file(). [2]

Hi Patrick,
	I'll grab 2.5.31 when it comes out and play with it.

Personally, I would get rid of the "strname" (make it implied by the variable
name), and use type instead of show & store, eg:

	DEVICE_ATTR(frobbable, O_RDWR, int);

This means you can (1) check that frobbable is actually an int at compile
time (__check_int), (2) you can use __show_int and __store_int as standard
routines, and (3) you can use your own types by:

	#define __check_frobbable_t(x) ((void)((&x) == (frobbable_t *)0)
	/* Define show_frobbable and store_frobbable here */

	DEVICE_ATTR(frobbable, O_RDWR, frobbable_t);

This ties into alot of other projects such as event logging, etc.

Rusty.
PS.  yeah yeah, I'll send code RSN.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
