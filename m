Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBADcx>; Wed, 31 Jan 2001 22:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbRBADcn>; Wed, 31 Jan 2001 22:32:43 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:28697 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129135AbRBADc0>;
	Wed, 31 Jan 2001 22:32:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Power usage Q and parallel make question (separate issues) 
In-Reply-To: Your message of "Wed, 31 Jan 2001 19:02:03 -0800."
             <3A78D1AB.2C2E743B@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 14:32:07 +1100
Message-ID: <11659.980998327@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 19:02:03 -0800, 
LA Walsh <law@sgi.com> wrote:
>This seems to serialize the delete, run the mod-installs in parallel, then run the
>depmod when they are done.  

It works, until somebody does this

 make -j 4 modules modules_install

There is not, and never has been, any interlock between make modules
and make modules_install.  If you let modules_install run in parallel
then people will be tempted to issue the incorrect command above
instead of the required separate commands.

 make -j 4 modules
 make -j 4 modules_install

You gain a few seconds on module_install but leave more room for user
error.

All of this is cleaned up in the 2.5 kbuild system (work in progress).
I have carefully coded the 2.5 kbuild system so it can be used on 2.4
kernels as well.  If you don't mind being an earlier adopter, this will
be fixed in a few weeks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
