Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291541AbSBAEtJ>; Thu, 31 Jan 2002 23:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291543AbSBAEs7>; Thu, 31 Jan 2002 23:48:59 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63887 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291541AbSBAEsr>;
	Thu, 31 Jan 2002 23:48:47 -0500
Date: Thu, 31 Jan 2002 23:48:45 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020131234845.B23792@havoc.gtf.org>
In-Reply-To: <E16WRmu-0003iO-00@the-village.bc.nu> <20020131.163054.41634626.davem@redhat.com> <20020131224635.F21864@havoc.gtf.org> <20020131.202509.78710127.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131.202509.78710127.davem@redhat.com>; from davem@redhat.com on Thu, Jan 31, 2002 at 08:25:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:25:09PM -0800, David S. Miller wrote:
>    From: Jeff Garzik <garzik@havoc.gtf.org>
>    Date: Thu, 31 Jan 2002 22:46:35 -0500
>    
>    Maybe not in this hypothetical future situation, but currently makefile
>    magic was added for crc32 specifically to ensure that it is linked
>    in when needed... even when CONFIG_CRC32=n.
>    
>    The Config.in for crc32 only exists for the case where no driver in the
>    built kernel uses it... but a 3rd party module might want it.
>    
> My point is this: Having to say something like "CONFIG_INEED_CRC32"
> for each driver that needs it is just plain stupid and a total eye
> sore.

I agree.

This is -not- the situation now, and it will never be the situation.

Did you read drivers/net/Makefile.lib ?

Another example, take a look at drivers/video/Config.in.  We actually do
not need those hideously long if statements "if foofb or barfb or bazfb"...
Makefile rules clean that shit up nicely.


> It would be really great if, some day, you just add your source
> file(s) to drivers/net and that is the only thing you ever touch.  You
> DO NOT touch Makefiles, you DO NOT touch Config.in files, you DO NOT
> add Config.help entries.

You are preaching to the choir.  ;-)


> The Makefile rules are auto-generated from keys in the *.c file(s), as
> are the Config.in and help entries.  Ie. cp driver.[ch]
> linux/drivers/net and then simply rebuild the tree.

Close...  Check out this thread from December.  I agree with Linus
we need metadata files (driver.conf), not yanking all that info out
of the source code.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0969.html
	and
http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.3/0801.html

To sum, Makefile rules are better than Config.in garbage because it can
be far more modular, and more resistant to breakage.  But, for the
longer term, we want 8139too.conf and lance.conf and...

Regards,

	Jeff



