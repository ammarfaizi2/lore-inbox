Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbRFQWIF>; Sun, 17 Jun 2001 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbRFQWHq>; Sun, 17 Jun 2001 18:07:46 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:8320 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S263003AbRFQWHi>;
	Sun, 17 Jun 2001 18:07:38 -0400
Date: Mon, 18 Jun 2001 01:09:08 +0300
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
Message-ID: <20010618010908.A12284@spiral.extreme.ro>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010617224015.A8341@spiral.extreme.ro> <200106172113.f5HLDhJ377473@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200106172113.f5HLDhJ377473@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sun, Jun 17, 2001 at 05:13:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 05:13:43PM -0400, Albert D. Cahalan wrote:
> > Is there any logical reason why if, given fd is a connected, AF_INET,
> > SOCK_STREAM socket, and one does a write(fd, buffer, len); close(fd);
> > to the peer, over a rather slow network (read modem, satelite link, etc),
> > the data gets lost (the remote receives the disconnect before the last
> > packet). According to socket(7), even if SO_LINGER is not set, the data
> > is flushed in the background.
> > 
> > Is it Linux or TCP specific? Or some obvious techincal detail I'm missing?
> 
> The UNIX API (Linux, BSD, Solaris, OSF/1...) requires that you
> put that write() call in a loop, because you can get partial
> writes. Repeat until done... the OS might do 1 byte at a time.

Not so true. The write is completed successfuly, ie.
size == write(fd, buf, size); so the data actually gets to the kernel's
network buffer, only the background polling is not done properly, in the
way I see things.
