Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291312AbSBVLHW>; Fri, 22 Feb 2002 06:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSBVLHM>; Fri, 22 Feb 2002 06:07:12 -0500
Received: from elin.scali.no ([62.70.89.10]:273 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291312AbSBVLHG>;
	Fri, 22 Feb 2002 06:07:06 -0500
Message-ID: <3C7626A9.330A9249@scali.com>
Date: Fri, 22 Feb 2002 12:08:25 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13win4lin i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org> <20020220151053.A1198@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> On Wed, Feb 20, 2002 at 02:54:49PM -0700, Jeff V. Merkey wrote:
> 
> > struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
> > {
> >       unsigned long addr;
> >       struct vm_struct **p, *tmp, *area;
> >
> >       area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);
> >       if (!area)
> >               return NULL;
> >       size += PAGE_SIZE;
> >       addr = VMALLOC_START;
> >       write_lock(&vmlist_lock);
> >       for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
> >
> > ===============>  we barf here since the size + addr wraps
> >
> 
> Also, this function should be moved to the /arch/i386/mm area since
> it is doing pointer arithmetic with 32 bit assumptions (i.e.
> unsigned long + unsigned long)  Last time I checked, unsigned long
> was a construct for a 32 bit value in any gcc compiler version, ia64
> or not.
> 

Jeff,

I think you'll have to check again. In LP64 programming models (used on most
64-bit OS'es) 'long' is 64 bit. Thus a 'unsigned long' is always safe to use
for pointer arithmetic since it will be 32 bit on 32bit machines and 64bit on
64bit machines.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
