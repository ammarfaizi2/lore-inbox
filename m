Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTBJLvm>; Mon, 10 Feb 2003 06:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBJLvl>; Mon, 10 Feb 2003 06:51:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5293
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267403AbTBJLvi>; Mon, 10 Feb 2003 06:51:38 -0500
Subject: Re: Setjmp/Longjmp in the kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030209221044.GA8761@morningstar.nowhere.lie>
References: <20030209221044.GA8761@morningstar.nowhere.lie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044882041.418.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Feb 2003 13:00:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-09 at 22:10, John W. M. Stevens wrote:
> Among these is a simple exception support system.  The core
> of this system is based on the existence of a setjmp/longjmp
> facility.  In digging through the source code, I've found a
> few, architechturally specific implementations of such a
> facility, but no generalized, multi-platform support.

setjmp/longjmp are normally very hard to follow and maintain,
especially when the kernel has locks, sleeping rules and
multiple threads flying around.

You will see lots of code which does either


int foo_func()
{
	alloc this
	alloc that
	_foo_func()
	free this
	free that
}

or has a single exit path and uses goto out type constructs 

instead

