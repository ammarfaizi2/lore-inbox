Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292940AbSBVSAj>; Fri, 22 Feb 2002 13:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSBVSAa>; Fri, 22 Feb 2002 13:00:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31362 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292940AbSBVSAU>; Fri, 22 Feb 2002 13:00:20 -0500
Date: Fri, 22 Feb 2002 11:17:56 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020222111756.A11081@vger.timpanogas.org>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org> <20020220151053.A1198@vger.timpanogas.org> <3C7626A9.330A9249@scali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7626A9.330A9249@scali.com>; from sp@scali.com on Fri, Feb 22, 2002 at 12:08:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:08:25PM +0100, Steffen Persvold wrote:
> "Jeff V. Merkey" wrote:
> > 
> > On Wed, Feb 20, 2002 at 02:54:49PM -0700, Jeff V. Merkey wrote:
> > 
> > > struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
> > > {
> > >       unsigned long addr;
> > >       struct vm_struct **p, *tmp, *area;
> > >
> > >       area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
> > >       if (!area)
> > >               return NULL;
> > >       size += PAGE_SIZE;
> > >       addr = VMALLOC_START;
> > >       write_lock(&vmlist_lock);
> > >       for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
> > >
> > > ===============>  we barf here since the size + addr wraps
> > >
> > 
> > Also, this function should be moved to the /arch/i386/mm area since
> > it is doing pointer arithmetic with 32 bit assumptions (i.e.
> > unsigned long + unsigned long)  Last time I checked, unsigned long
> > was a construct for a 32 bit value in any gcc compiler version, ia64
> > or not.
> > 
> 
> Jeff,
> 
> I think you'll have to check again. In LP64 programming models (used on most
> 64-bit OS'es) 'long' is 64 bit. Thus a 'unsigned long' is always safe to use
> for pointer arithmetic since it will be 32 bit on 32bit machines and 64bit on
> 64bit machines.
> 
> Regards,
> -- 

Hi Steffan,

On early IA64 long long was assumed to be 64 bit, long 32 bit. After
emailing some folks off line I relaize this may not be the case 
any longer, but still is on some compiler options.

Say hi to Hugo for me next time you see him.  :-)  I have reviewed this
and we will need some changes to the page table setup in Linux 
and copy to/from user macros in order to get around this problem 
for preallocating prefetch space. 

Any ideas and joint work on this problem is appreciated.    

Jeff





>   Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
>  mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
> Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
> Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
