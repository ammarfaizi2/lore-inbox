Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSF0MPz>; Thu, 27 Jun 2002 08:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSF0MPy>; Thu, 27 Jun 2002 08:15:54 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:55216 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316782AbSF0MPy>; Thu, 27 Jun 2002 08:15:54 -0400
Date: Thu, 27 Jun 2002 13:15:11 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Amos Waterland <apw@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: O_ASYNC question
Message-ID: <20020627131511.A16012@kushida.apsleyroad.org>
References: <20020625113052.A7510@kvasir.austin.ibm.com> <20020626211122.GL22961@holomorphy.com> <20020626163755.A10713@kvasir.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020626163755.A10713@kvasir.austin.ibm.com>; from apw@us.ibm.com on Wed, Jun 26, 2002 at 04:37:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amos Waterland wrote:
> When you say that it is 'not done for files', does that mean that it is
> not done by design, and no plans exist to implement it for files
> (perhaps because completion notification is fundamentally different than
> readiness notification?), or that the work just has yet to be done?
> Thanks.

It isn't implemented for files, per POSIX I believe - in the same way
that select() will always return readable and writable on files.

I believe (i.e. I assume in my code ;-) that you should treat a SIGIO as
something which occurs when an fd transitions from "not readable" to
"readable", or from "not writable" to "writable".  This applies even to
sockets: if you read only part of the readable data from a socket, then
you won't receive a SIGIO just because there is more unread data.

If the fd is permanently "readable" and "writable", such as with a file,
then there is no transition.  Following this logic, you don't actually
need a special case for different kinds of fd -- you just need to check
their status with poll(), select(), or by trying a read/write operation
and checking for EAGAIN.

Please, someone point out if this logic does not hold, thanks :-)

-- Jamie
