Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbSJWBjl>; Tue, 22 Oct 2002 21:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbSJWBil>; Tue, 22 Oct 2002 21:38:41 -0400
Received: from pool-129-44-58-33.ny325.east.verizon.net ([129.44.58.33]:4100
	"EHLO arizona.localdomain") by vger.kernel.org with ESMTP
	id <S262602AbSJWBht>; Tue, 22 Oct 2002 21:37:49 -0400
Date: Tue, 22 Oct 2002 21:43:45 -0400
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Container_of considered harmful - was Re: usb storage sddr09
Message-ID: <20021022214345.A5642@arizona.localdomain>
References: <200210172155.49349.tomlins@cam.org> <20021018193523.GA25316@win.tue.nl> <200210200952.23430.tomlins@cam.org> <20021020182436.GA25975@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020182436.GA25975@win.tue.nl>; from aebr@win.tue.nl on Sun, Oct 20, 2002 at 08:24:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 08:24:36PM +0200, Andries Brouwer wrote:
> The oops is a dereference of fffffff0 in base/bus.c:driver_attach().
> I have seen several such oopses lately, various places in the kernel.
> The cause here is a NULL pointer that is turned into fffffff0 by
> container_of() and then fed to get_device(). And get_device() tests
> that it gets a non-NULL pointer, but that does not protect against
> fffffff0.

Just as an anecdote - I built a variant of container_of to protect against
cases where NULL can creep in:

#define test_container_of(ptr, type, member) ({               \
        const typeof( ((type *)0)->member ) *__p = (ptr);     \
        __p ? container_of(__p, type, member) : NULL;})

It calls the real container_of only if 'ptr' is not NULL.

-Kevin

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
