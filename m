Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313575AbSDPEMF>; Tue, 16 Apr 2002 00:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313577AbSDPEME>; Tue, 16 Apr 2002 00:12:04 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53509
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313575AbSDPEME>; Tue, 16 Apr 2002 00:12:04 -0400
Date: Mon, 15 Apr 2002 21:11:39 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Josh McKinney <forming@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
In-Reply-To: <20020416031127.GA1030@cy599856-a>
Message-ID: <Pine.LNX.4.10.10204152109300.7430-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep,

Edit ide-taskfile.c find ide_driveid_update

Changes the #if 1 to #if 0

Attempting to make the code compress but it appears that entry for
updating is more than a simple direct call.  Still banging it out.

Cheers,

On Mon, 15 Apr 2002, Josh McKinney wrote:

> On approximately Mon, Apr 15, 2002 at 12:59:20PM -0700, Andre Hedrick wrote:
> > 
> > http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3a.patch.bz2
> > 
> > Lets try it again, I diffed the wrong tree :-/
> > 
> 
> Well it compiled fine this time, but it seems to have problems with gcc-3.0.4 I am using to
> compile kernels.  This gcc has been fine for all other uses, but it must be something with this
> particular build because gcc-2.95.4 works without a problem.  Anyways, here is the oops report
> if it may interest you.
> 
> <1>Unable to handle kernel paging request at virtual address 3fff432a
> c01c2c90
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01c2c90>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 3fff427a   ebx: c02fc928   ecx: 00000001   edx: dda11e04
> esi: c02fc928   edi: dda11e98   ebp: bffff7f0   esp: dda11e04
> ds: 0018   es: 0018   ss: 0018
> Process hdparm (pid: 492, stackpage=dda11000)
> Stack: 3fff427a 00100000 0258e100 0010003f 000e0000 2d575744 39504d41 30353136
>        31003238 00000000 10000003 30320028 35422e30 57443032 57444320 30423630
>        3332422d 41304358 20202020 20202020 20202020 20202020 20202020 80102020
> Code: 0f b7 80 b0 00 00 00 8b 93 f0 00 00 00 66 89 82 b0 00 00 00
> 
> 
> >>EIP; c01c2c90 <ide_driveid_update+30/90>   <=====
> 
> >>eax; 3fff427a Before first symbol
> >>ebx; c02fc928 <ide_hwifs+388/20a8>
> >>edx; dda11e04 <_end+1d70bb50/2253ad4c>
> >>esi; c02fc928 <ide_hwifs+388/20a8>
> >>edi; dda11e98 <_end+1d70bbe4/2253ad4c>
> >>ebp; bffff7f0 Before first symbol
> >>esp; dda11e04 <_end+1d70bb50/2253ad4c>
> 
> Code;  c01c2c90 <ide_driveid_update+30/90>
> 00000000 <_EIP>:
> Code;  c01c2c90 <ide_driveid_update+30/90>   <=====
>    0:   0f b7 80 b0 00 00 00      movzwl 0xb0(%eax),%eax   <=====
> Code;  c01c2c97 <ide_driveid_update+37/90>
>    7:   8b 93 f0 00 00 00         mov    0xf0(%ebx),%edx
> Code;  c01c2c9d <ide_driveid_update+3d/90>
>    d:   66 89 82 b0 00 00 00      mov    %ax,0xb0(%edx)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

