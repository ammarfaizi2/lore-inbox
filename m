Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262774AbSIPSQO>; Mon, 16 Sep 2002 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbSIPSQL>; Mon, 16 Sep 2002 14:16:11 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:11019 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S262774AbSIPSQK>;
	Mon, 16 Sep 2002 14:16:10 -0400
Message-Id: <200209161820.g8GIK5004509@fokkensr.vertis.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.5.35 xtime locking
Date: Mon, 16 Sep 2002 20:20:01 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0209161347591.14886-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0209161347591.14886-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 13:52, Adrian Bunk wrote:
>
> This change results in a compile error in the ATM drivers:
>
Yep, There are even many other places where xtime is used which may result in 
the same kind of compilation problems. Two possible solutions come to mind:

* Maintain both the ordinary xtime (timeval) and an xtime_nsec (timespec). 
xtime may then be a timeval shadow value of xtime_nsec.
* Just fix it everywhere.

I cannot tell fore sure which option Linus prefers, but I think ...

Some places may even have other problems as well (e.g. ATM drivers): xtime is 
a complex data type which needs  read_lock / read_unlock, but there's no 
locking in many places.
