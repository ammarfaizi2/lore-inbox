Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbTCMQdb>; Thu, 13 Mar 2003 11:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbTCMQdb>; Thu, 13 Mar 2003 11:33:31 -0500
Received: from jack.stev.org ([217.79.103.51]:12341 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S262454AbTCMQd2>;
	Thu, 13 Mar 2003 11:33:28 -0500
Message-ID: <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Stephan von Krawczynski" <skraw@ithnet.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Thu, 13 Mar 2003 16:50:46 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > strange looks alot like the ones i have seen though the whole 2.4.x
tree.
> >
> > this was discussed before somebody said they would send a patch myself
> > and sombody else were going to test it but the patch never happens.
> > >From what i can work out an error occurs on the cd drive and the
request
> > queue is then empty and the ide-scsi driver then attempts to access the
> > reuest queue that doesnt exist i never did manage to find out
> > where the request get removed from the queue though.
>
> Your explanation doesn't quite make sense, but I can take a look at the
> problem :-)
>
> What kernel is the below oops from? What compiler?

i can trigger this on any 2.4.x series kernel.
-> Insert dmaged / lightly scratched cd into drive
   dd /dev/scd0 bs=8192k of=file
   wait for opps.
   opps also cd tries to re read several times
   short hang then the following output

gcc versions.
Whatever shits with redhat 7.1 + 7.2 + 7.3 and the
updates between them in each of the redhat versions.
but normally
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)

or
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)

> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c01e5783>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010202
> > eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
> > esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
> > ds: 0018   es: 0018   ss: 0018
> > Process klogd (pid: 381, stackpage=cb23d000)
> > Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
> > c0327294
> >        c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
> > 0000000f
> >        c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
> > 0000000f
> > Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>]
[<c010c358>]
> > Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58 04 53
> >
> > >>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=====
> > Trace; c01cdd11 <ide_intr+c1/120>
> > Trace; c01e5700 <idescsi_pc_intr+0/290>
> > Trace; c010a0bd <handle_IRQ_event+3d/70>
> > Trace; c010a24d <do_IRQ+7d/c0>
> > Trace; c010c358 <call_do_IRQ+5/d>
> > Code;  c01e5783 <idescsi_pc_intr+83/290>
> > 00000000 <_EIP>:
> > Code;  c01e5783 <idescsi_pc_intr+83/290>   <=====
> >    0:   8b 72 18                  mov    0x18(%edx),%esi   <=====
> > Code;  c01e5786 <idescsi_pc_intr+86/290>
> >    3:   46                        inc    %esi
> > Code;  c01e5787 <idescsi_pc_intr+87/290>
> >    4:   89 72 18                  mov    %esi,0x18(%edx)
> > Code;  c01e578a <idescsi_pc_intr+8a/290>
> >    7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
> > Code;  c01e578d <idescsi_pc_intr+8d/290>
> >    a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
> > Code;  c01e5793 <idescsi_pc_intr+93/290>
> >   10:   8b 58 04                  mov    0x4(%eax),%ebx
> > Code;  c01e5796 <idescsi_pc_intr+96/290>
> >   13:   53                        push   %ebx
> >
> > <0>Kernel panic: Aiee, killing interrupt handler!
> >
> > 1 warning issued.  Results may not be reliable.
>
> --
> Jens Axboe


