Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRI3SmU>; Sun, 30 Sep 2001 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272667AbRI3SmL>; Sun, 30 Sep 2001 14:42:11 -0400
Received: from cs82093.pp.htv.fi ([212.90.82.93]:33158 "EHLO cs82093.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S272682AbRI3Sly>;
	Sun, 30 Sep 2001 14:41:54 -0400
Message-ID: <3BB7676C.1213CC84@welho.com>
Date: Sun, 30 Sep 2001 21:41:48 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> So far, I've found an implementation of getifaddrs() that makes it
> easy to retrieve the list of local IP addresses, and modified my
> benchmark to assign a different local ip address to each user;
> the users use bind() with that address and a zero port number,
> and expect the system to assign a port.
[...]
> It's tempting to patch tcp_v4_get_port() to check
> sk->rcv_saddr, and if it's nonzero, allow the
> same ephemeral port number to be reused on different interfaces.
[...]
> Can anyone comment on the wisdom of such a change?

Hi Dan,

It shouldn't break anything as far as I can see. However, patching the
kernel simply to accommodate a benchmark does not seem the right thing
to do. Since your client is already binding the source address, why not
simply bind the port as well? You can easily loop the whole 64K range if
you want. Or you could even pick a completely empty port range and bind
each client socket with the SO_REUSE flag (which is ok, since your
clients are using different source addresses). I don't see any reason to
modify the kernel for this, particularly as it wouldn't really help port
exhaustion in real-life situations.

Best Regards,

	Mika Liljeberg
