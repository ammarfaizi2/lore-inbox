Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSGROjb>; Thu, 18 Jul 2002 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSGROjb>; Thu, 18 Jul 2002 10:39:31 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:30449 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S318100AbSGROj1>;
	Thu, 18 Jul 2002 10:39:27 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716.165241.123987278.davem@redhat.com> <1026869741.2119.112.camel@irongate.swansea.linux.org.uk> <20020716.172026.55847426.davem@redhat.com> <mailman.1026868201.10433.linux-kernel2news@redhat.com> <200207180001.g6I015f02681@devserv.devel.redhat.com>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 18 Jul 2002 10:42:25 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/200207180001.g6I015f02681@devserv.devel.redhat.com>
Message-ID: <s5gadop9jxq.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> The problem with errors from close() is that NOTHING SMART can be
> done by the application when it receives it.

This is like saying "nothing smart" can be done when write() returns
ENOSPC.  Such statements are either trivially true or blatantly false,
depending on what you mean by "smart".

Failures happen.  They can happen on write(), they can happen on
close(), and they can happen on any system call for which the API
allows it.  There is no difference!  Your application either deals
with them and is correct or fails to deal with them and is broken.

If the API allows an error return, you *must* check for it, period.
This includes "impossible" errors.  You may think it is impossible for
gettimeofday() to return an error in some case, but if it ever did,
you should darn well want to know about it right away.

If you are that convinced that close() can not return an error in your
particular application (e.g., because you "know" you are using a local
disk, or the file descriptor is read-only), then treat such errors
like assertion failures.  Because that is what they are.

Checking system calls for errors, always, is fundamental to writing
reliable code.  Failing to check them is shoddy and amateurish
programming.  It is amazing that so many people would argue this
point.  Then again, maybe not, given how bad most software is...

 - Pat
