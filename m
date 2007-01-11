Return-Path: <linux-kernel-owner+w=401wt.eu-S965032AbXAKELL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbXAKELL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 23:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbXAKELL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 23:11:11 -0500
Received: from secure.tummy.com ([66.35.36.132]:34430 "EHLO secure.tummy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965032AbXAKELK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 23:11:10 -0500
Date: Wed, 10 Jan 2007 21:09:17 -0700
From: Sean Reifschneider <jafo@tummy.com>
To: Neil Brown <neilb@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting ERESTARTNOHAND (514).
Message-ID: <20070111040917.GO7121@tummy.com>
References: <20070110234238.GB10791@tummy.com> <17829.34481.340913.519675@notabene.brown> <200701110140.51842.ak@suse.de> <17829.36029.240912.274302@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17829.36029.240912.274302@notabene.brown>
User-Agent: Mutt/1.4.2.2i
X-Hashcash: 1:26:070111:linux-kernel@vger.kernel.org::6D9GnPQjYIHwdRNh:000000000
	000000000000000000000005DIGp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 12:02:53PM +1100, Neil Brown wrote:
>On Thursday January 11, ak@suse.de wrote:
>> Normally it should be only visible in strace. Did you see it without
>> strace?
>
>No, only in strace.

I am absolutely seeing it outside of strace.  It is showing up as an errno
to the select call:

   if (select(0, (fd_set *)0, (fd_set *)0, (fd_set *)0, &t) != 0) {
      if (errno != EINTR) {
         PyErr_SetFromErrno(PyExc_IOError);
         return -1;
      }

This code is seeing errno=514.

>> > You don't mention in the Email which kernel version you use but I see
>> > from the web page you reference it is 2.6.19.1.  I'm using

The production system is running CentOS 4.4, 2.6.9 kernel.  However, it
looks to be the same issue all the way up to 2.6.19.1, and google shows
reports of it on 2.6.17.

Thanks,
Sean
-- 
 George Washington was first in war, first in peace -- and first to
 have his birthday juggled to make a long weekend.
Sean Reifschneider, Member of Technical Staff <jafo@tummy.com>
tummy.com, ltd. - Linux Consulting since 1995: Ask me about High Availability

