Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbTCMDlo>; Wed, 12 Mar 2003 22:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262147AbTCMDlo>; Wed, 12 Mar 2003 22:41:44 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:44993 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262141AbTCMDlm>; Wed, 12 Mar 2003 22:41:42 -0500
Subject: Re: [OOPS] 2.5.64
From: Shane Shrybman <shrybman@sympatico.ca>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <82830000.1047526931@[10.10.2.4]>
References: <1047526326.2261.9.camel@mars.goatskin.org>
	 <82830000.1047526931@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1047527545.2368.4.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Mar 2003 22:52:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 22:42, Martin J. Bligh wrote:
> Looks like the attatched patch might help.

Thanks. Actually, is was only trying 2.5.64 because mm3-5 won't let me
start X. I get a bunch of processes stuck like ...

shane     2009  0.0  0.5  6196 1996 ?        D    21:14   0:00
gnome-smproxy --sm-client-id default0
shane     2014  0.0  0.8  5720 3272 ?        D    21:14   0:00
/usr/bin/sawfish --sm-client-id=default2
shane     2024  0.0  1.0  8884 3972 ?        D    21:14   0:00
bonobo-moniker-archiver
--oaf-activate-iid=OAFIID:Bonobo_Moniker_archiver_Factory --oaf-ior-fd=8
shane     2037  0.0  0.6  6744 2584 ?        D    21:14   0:00 gmix -i
shane     2043  0.0  0.4  4048 1644 ?        D    21:14   0:00
xscreensaver -nosplash
shane     2051  0.0  1.1 17300 4336 ?        D    21:14   0:00 nautilus
-n --sm-client-id default8
shane     2055  0.0  0.8  7972 3452 ?        D    21:14   0:00 panel
--sm-client-id default7
root      2082  0.0  0.0  1492  296 tty2     R    21:17   0:00 grep  D

when gnome is starting. 2.5.64-mm1 is alright and doesn't have this
problem.


> 
> M.
> 
> --On Wednesday, March 12, 2003 22:32:06 -0500 Shane Shrybman <shrybman@sympatico.ca> wrote:
> 
> > Hi,
> > 
> > Got this oops during boot up. Machine is still alive.
> > 
> > Athlon TB, IDE
> > 
> > hde: drive_cmd: error=0x04 { DriveStatusError }
> > hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > hde: drive_cmd: error=0x04 { DriveStatusError }
> > SCSI subsystem initialized
> > parport_pc: Via 686A parallel port disabled in BIOS
> > lp: driver loaded but no devices found
> > Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000006c
> >  printing eip:
> > d88f440e
> > *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0060:[<d88f440e>]    Not tainted
> > EFLAGS: 00010206
> > EIP is at rpc_depopulate+0x1e/0x120 [sunrpc]
> > eax: 00000000   ebx: d5e6ba80   ecx: 0000006c   edx: d5e6baf4
> > esi: d5e6ba80   edi: d5731dc0   ebp: 00000000   esp: d59bdcd4
> > ds: 007b   es: 007b   ss: 0068
> > Process rpc.nfsd (pid: 1290, threadinfo=d59bc000 task=d5ea26c0)
> > Stack: 00000000 00000000 d5e6ba80 d5e6ba80 d5731dc0 00000000 d88f4942
> > d5e6ba80 
> >        d5d0a800 d7ffaac0 d59bdcf8 00000282 d56ccd40 00000010 00000001
> > d88eba5d 
> >        d6054d40 d59bddb4 d5c11740 d88e6302 d6054dd4 d6054d40 d88e6378
> > d6054d40 
> > Call Trace:
> >  [<d88f4942>] rpc_rmdir+0x52/0x90 [sunrpc]
> >  [<d88eba5d>] rpcauth_destroy+0xd/0x60 [sunrpc]
> >  [<d88e6302>] rpc_destroy_client+0x42/0x70 [sunrpc]
> >  [<d88e6378>] rpc_release_client+0x48/0x50 [sunrpc]
> >  [<d88eac04>] rpc_release_task+0x1b4/0x1e0 [sunrpc]
> >  [<d88ea5b5>] __rpc_execute+0x355/0x360 [sunrpc]
> >  [<c0119380>] default_wake_function+0x0/0x20
> >  [<d88e65ee>] rpc_call_setup+0x3e/0x60 [sunrpc]
> >  [<d88e64d8>] rpc_call_sync+0x68/0xa0 [sunrpc]
> >  [<d88e64e9>] rpc_call_sync+0x79/0xa0 [sunrpc]
> >  [<d88fffb8>] all_tasks+0x0/0x8 [sunrpc]
> >  [<d88fffb8>] all_tasks+0x0/0x8 [sunrpc]
> >  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
> >  [<d88e9700>] gcc2_compiled.+0x0/0xa0 [sunrpc]
> >  [<d88f6116>] +0xc52/0x105c [sunrpc]
> >  [<d890023c>] pmap_program+0x0/0x24 [sunrpc]
> >  [<d88f1558>] rpc_register+0xf8/0x130 [sunrpc]
> >  [<c0133807>] __alloc_pages+0x87/0x2b0
> >  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
> >  [<d89001f4>] pmap_procedures+0x30/0x60 [sunrpc]
> >  [<c0130000>] filemap_fdatawait+0xc0/0x160
> >  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
> >  [<d88eccc5>] svc_register+0x85/0xe0 [sunrpc]
> >  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
> >  [<d8927fd8>] nfsd_version3+0x0/0x28 [nfsd]
> >  [<d88ec92e>] gcc2_compiled.+0xce/0xe0 [sunrpc]
> >  [<d89130a9>] nfsd_svc+0x89/0x1a0 [nfsd]
> >  [<d89273e0>] nfsd_program+0x0/0x20 [nfsd]
> >  [<d89137ef>] gcc2_compiled.+0x10f/0x130 [nfsd]
> >  [<c0152c6f>] path_release+0xf/0x30
> >  [<c016870f>] sys_nfsservctl+0xaf/0xf0
> >  [<c013da04>] sys_munmap+0x34/0x50
> >  [<c010a767>] syscall_call+0x7/0xb
> > 
> > Code: ff 48 6c 0f 88 60 09 00 00 b8 00 e0 ff ff 21 e0 ff 40 10 8b 
> > 
> > Regards,
> > 
> > Shane
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
-- 
Shane Shrybman <shrybman@sympatico.ca>

