Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbQKALNd>; Wed, 1 Nov 2000 06:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbQKALNY>; Wed, 1 Nov 2000 06:13:24 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:61194 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S129991AbQKALNH> convert rfc822-to-8bit;
	Wed, 1 Nov 2000 06:13:07 -0500
Date: Wed, 1 Nov 2000 13:13:04 +0200 (EET)
From: Pasi Kärkkäinen <pk@edu.joroinen.fi>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Forever shall I be." <zinx@microsoftisevil.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
In-Reply-To: <Pine.LNX.4.21.0010261508530.15696-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0011011306480.10457-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Oct 2000, Rik van Riel wrote:

> On Thu, 26 Oct 2000, Forever shall I be. wrote:
> > On Thu, Oct 26, 2000 at 02:57:30PM +0300, Pasi Kärkkäinen wrote:
> 
> > > __alloc_pages: 2-order allocation failed.
> > > __alloc_pages: 2-order allocation failed.
> > > __alloc_pages: 5-order allocation failed.
> > > __alloc_pages: 4-order allocation failed.
> > > __alloc_pages: 3-order allocation failed.
> > > __alloc_pages: 2-order allocation failed.
> > > __alloc_pages: 5-order allocation failed.
> > > 
> > > Any ideas?
> > 
> > I'm getting __alloc_pages: 7-order allocation failed.
> > all the time in 2.4.0-test9 on my "pIII (Katmai)".. kernel's
> > compiled with 2.95.2 + bounds, without -fbounds-checking
> 
> It means something in the system is trying to allocate a
> large continuous area of memory that isn't available...
> 
> The printk is basically a debug output indicating that we
> don't have the large physically contiguous area available
> that's being requested.
> 
> Basically everything bigger than order-1 (2 contiguous
> pages) is unreliable at runtime. Orders 2 and 3 should
> usually be available (if you only allocate very few of
> them) and higher orders should not be relied upon.
> 
> If somebody is seeing a lot of these messages, it means
> that some driver in the system is asking unreasonable
> things from the VM subsystem ;)
> 
> (and buffer allocations are failing)
> 

I added show_stack(0); to the mm/page_alloc.c :

        /* No luck.. */
        printk(KERN_ERR "__alloc_pages: %lu-order allocation failed.\n", order)
        show_stack(0);
        return NULL;

Then, when the first stack-dump came to kern.log, I gave it to
ksymoops. The result can be seen on

http://edu.joroinen.fi/~pk/ksymoops-output.

Hope that helps someone. If not, I may do further tests.

- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
