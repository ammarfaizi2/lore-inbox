Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275398AbRJQJ5E>; Wed, 17 Oct 2001 05:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275424AbRJQJ4y>; Wed, 17 Oct 2001 05:56:54 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:8458 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S275398AbRJQJ4d>; Wed, 17 Oct 2001 05:56:33 -0400
Message-ID: <3BCD56A2.B5362224@loewe-komp.de>
Date: Wed, 17 Oct 2001 12:00:02 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS related Oops in 2.4.[39]-xfs
In-Reply-To: <200110170928.f9H9SsP07618@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> Where did you get your kernel (the 2.4.9 version that is) this problem
> sounds familiar, but I am pretty sure we fixed this case in XFS somewhere
> between 2.4.3 and 2.4.9.
> 

ftp://oss.sgi.com/projects/xfs/download/patches/linux-2.4.9-xfs-2001-08-26.patch.bz2

the 2.4.3 was there in May, 2001.
-rwxr-xr-x    1 peewee   peewee      47713 Mai 17 16:15 linux-2.4.3-core-xfs-1.0.patch.gz

I cannot confirm the Oops in 2.4.9-xfs, but I _think_ it was in the same place.
Do you think, it's xfs related? Some dentries vanashing beneath xfs?

What version do you want me to try, 2.4.12-xfs?
I will apply my "safety" patch anyway (with a printk) ;-)

> 
> > noisy:/usr/src/linux # uname -a
> > Linux noisy 2.4.3-XFS #8 SMP Sam Mai 19 18:21:36 CEST 2001 i686 unknown
> >
> > dual board with just one processor
> > /usr/local and /home on LogicalVolumes
> > tried also 2.4.9-XFS (but see below)
> >
> > ------------ oops -------------
> > Warning (compare_maps): ksyms_base symbol __rta_fill_R__ver___rta_fill not fo
> > und in
> > System.map.  Ignoring ksyms_base entry
> > [other warnings stripped]
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:<c016b3c4>
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010246
> > eax: 00000000   ebx: 00000000   ecx: cff805b8 edx: 00000010
> > esi: ca018260   edi: ca0182e0   ebp: cb9e5800 esp: cb9edeec
> > ds: 0018   es: 0018   ss: 0018
> > Stack: 0100708b ca018360 c016b7d8 ca0182e0 00000002 cba07000 cb9efc00 cb9e580
> > 0
> >        ce078bc4 ca018360 00000000 ca018360 c016bb70 ce078a80 0102a048 0000000
> > 5
> > Call Trace: <c01bb7d8> <c016bb70> <c016a0b5>c0169b73> <c02a60bf> <c016999d> <
> > c01054c4>
> > Code: 8b 40 10 39 d0 74 21 8d 58 c8 39 f3 75 06 8b 5a 04 83 c3 c8
> >
> > >>EIP; c016b3c4 <nfsd_findparent+78/e8>   <=====
> > Trace; c01bb7d8 <xfs_buf_item_bits+38/58>
> > Trace; c016bb70 <fh_verify+26c/48c>
> > Trace; c016a0b5 <nfsd_proc_getattr+91/98>
> > Code;  c016b3c4 <nfsd_findparent+78/e8>
> > 00000000 <_EIP>:
> > Code;  c016b3c4 <nfsd_findparent+78/e8>   <=====
> >    0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
> > Code;  c016b3c7 <nfsd_findparent+7b/e8>
> >    3:   39 d0                     cmp    %edx,%eax
> > Code;  c016b3c9 <nfsd_findparent+7d/e8>
> >    5:   74 21                     je     28 <_EIP+0x28> c016b3ec <nfsd_findpa
> > rent+a0/e8>
> > Code;  c016b3cb <nfsd_findparent+7f/e8>
> >    7:   8d 58 c8                  lea    0xffffffc8(%eax),%ebx
> > Code;  c016b3ce <nfsd_findparent+82/e8>
> >    a:   39 f3                     cmp    %esi,%ebx
> > Code;  c016b3d0 <nfsd_findparent+84/e8>
> >    c:   75 06                     jne    14 <_EIP+0x14> c016b3d8 <nfsd_findpa
> > rent+8c/e8>
> > Code;  c016b3d2 <nfsd_findparent+86/e8>
> >    e:   8b 5a 04                  mov    0x4(%edx),%ebx
> > Code;  c016b3d5 <nfsd_findparent+89/e8>
> >   11:   83 c3 c8                  add    $0xffffffc8,%ebx
> >
> >
> > 31 warnings issued.  Results may not be reliable.
> > ------------ oops -------------
> >
[...]
