Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292235AbSBBHnn>; Sat, 2 Feb 2002 02:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292247AbSBBHnd>; Sat, 2 Feb 2002 02:43:33 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:12976 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S292235AbSBBHnV>;
	Sat, 2 Feb 2002 02:43:21 -0500
Date: Sat, 2 Feb 2002 02:42:36 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020202024236.B17031@nevyn.them.org>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, vandrove@vc.cvut.cz,
	torvalds@transmeta.com, garzik@havoc.gtf.org,
	linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
	ralf@gnu.org
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org> <3C5B56A4.B762948F@zip.com.au> <20020202073020.GA7014@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020202073020.GA7014@tapu.f00f.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 11:30:20PM -0800, Chris Wedgwood wrote:
> Is there no way to write something like:
> 
> --snip-- foo.c --snip--
> void
> blem()
> {
> }
> 
> void
> bar()
> {
>     blem();
>     return 0;
> }
> 
> int foo()
> {
>     return 1;
> }
> 
> int main(...)
> {
>     return foo();
> }
> --snip-- foo.c --snip--
> 
> compile and link it, have the linker know main or some part of crt0 is
> special, build a graph of the final ELF object, see that bar and blem
> are not connected to 'main' and discard them?
> 
> I'm pretty sure (but not 100% certain) that oher compilers can do
> this, maybe someone can test on other platforms?
> 
> A really smart linker (if given enough compiler help) could build a
> directional graph and still remove this code even if blem called foo.

One piece of the necessary compiler help would be -ffunction-sections. 
If they are in the same section in the same object file, they simply
can not be removed safely.  Relocation information for calls to local
functions is not reliably available at link time.


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
