Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266912AbRGHQhS>; Sun, 8 Jul 2001 12:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRGHQhJ>; Sun, 8 Jul 2001 12:37:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59079 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266912AbRGHQgz>;
	Sun, 8 Jul 2001 12:36:55 -0400
Message-ID: <3B488C22.16F127E9@mandrakesoft.com>
Date: Sun, 08 Jul 2001 12:36:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu
Subject: Re: Memory region check in drivers/pcmcia/rsrc_mgr.c
In-Reply-To: <15174.62880.772230.734585@tango.paulus.ozlabs.org>
		<Pine.LNX.4.33.0107071103070.31249-100000@penguin.transmeta.com> <15176.6825.508736.915376@tango.paulus.ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> +static struct resource *resource_parent(unsigned long b, unsigned long n,
> +                                       int flags, socket_info_t *s)
> +static inline int check_io_resource(unsigned long b, unsigned long n,
> +                                   socket_info_t *s)
> +static inline int check_mem_resource(unsigned long b, unsigned long n,
> +                                    socket_info_t *s)
> +static struct resource *make_resource(unsigned long b, unsigned long n,
> +                                     int flags, char *name)
> +static int request_io_resource(unsigned long b, unsigned long n,
> +                              char *name, socket_info_t *s)
> +static int request_mem_resource(unsigned long b, unsigned long n,
> +                               char *name, socket_info_t *s)

patch looks ok.  I wonder if this stuff is useful to other users?

resource_parent appears to be the only actual user of socket_info_t
data.  Since resource_parent only uses one datum out of all of
socket_info_t, you could reasonably eliminate this code's dependency on
socket_info_t.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
