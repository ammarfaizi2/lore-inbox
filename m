Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285186AbRLFRcw>; Thu, 6 Dec 2001 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRLFRcn>; Thu, 6 Dec 2001 12:32:43 -0500
Received: from elin.scali.no ([62.70.89.10]:10502 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S285185AbRLFRce>;
	Thu, 6 Dec 2001 12:32:34 -0500
Message-ID: <3C0FB84A.76D8C003@scali.no>
Date: Thu, 06 Dec 2001 19:26:18 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.9 kernel crash
In-Reply-To: <3C077FF8.AFBD8DB8@scali.no> <3C07E905.DF30E497@zip.com.au> <20011204003350.L2857@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Fri, Nov 30, 2001 at 12:16:05PM -0800, Andrew Morton wrote:
> 
> > There was a bug in ext3 which was fixed around about the 2.4.9
> > timeframe.  I don't know if the fix is present in that
> > particular Red Hat kernel.  It was fixed in ext3 0.9.8.  The
> > ext3 version number is displayed when you mount a filesystem.
> >
> > The 0.9.8 changelog says:
> >
> > - Fix an NFS oops when doing a local delete on an active, nfs-exported
> >   file.
> >
> > I never observed this bug - I think the fix came from Ted T'so.  I
> > do not know whether the bug manifested itself as "busy inodes
> > after unmount".  Perhaps Ted or Stephen can comment?
> 
> The NFS bug could present as "bit already cleared", but I don't think
> I ever saw it leave busy inodes behind.
> 

So what could this be then ?

(original message i case someone missed it) :
Hi all,

This just happened to my RedHat 7.2 box running the 2.4.9-13 update kernel from RedHat. The box is
running as a NFS server, exporting two ext3 volumes (one 36GB and one 73GB) :

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Unable to handle kernel NULL pointer dereference at virtual address 0000000b
 printing eip:
c01537aa
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01537aa>]    Not tainted
EFLAGS: 00010282
eax: fffffffb   ebx: c0a69580   ecx: c0a69590   edx: c0a69590
esi: cf12bce0   edi: fffffffb   ebp: fffffb4c   esp: cff6bf60
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=cff6b000)
Stack: c02dbdf8 ffffff55 cbf027c8 c181a8a0 cf12bcf8 cf12bce0 c0a69580 c0150eb6 
       c0a69580 00000419 00000000 c1022dc4 c1022dc4 c1022d9c 00000000 c01357a5 
       00000001 00000ed2 000000c0 000000c0 0008e000 c01512a1 00000000 c0135bab 
Call Trace: [<c0150eb6>] prune_dcache [kernel] 0xf6 
[<c01357a5>] page_launder [kernel] 0x8f5 
[<c01512a1>] shrink_dcache_memory [kernel] 0x21 
[<c0135bab>] do_try_to_free_pages [kernel] 0x1b 
[<c0135c35>] kswapd [kernel] 0x55 
[<c0105000>] stext [kernel] 0x0 
[<c0105866>] kernel_thread [kernel] 0x26 
[<c0135be0>] kswapd [kernel] 0x0 


Code: 8b 47 10 85 c0 74 04 53 ff d0 58 68 40 be 2d c0 8d 43 24 50 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000b
 printing eip:
c01537aa
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01537aa>]    Not tainted
EFLAGS: 00010282
eax: fffffffb   ebx: cc33a580   ecx: cc33a590   edx: cc33a590
esi: cf543aa0   edi: fffffffb   ebp: 00000000   esp: cc62dd34
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 979, stackpage=cc62d000)
Stack: c65bb8a0 c02da480 000008b4 c02da460 cf543ab8 cf543aa0 cc33a580 c0150eb6 
       cc33a580 0000045a 00000000 c1025008 c1025008 c1024fe0 00000000 c01357a5 
       00000001 00001648 000000d2 00000000 000000d2 c01512a1 00000000 c0135bab 
Call Trace: [<c0150eb6>] prune_dcache [kernel] 0xf6 
[<c01357a5>] page_launder [kernel] 0x8f5 
[<c01512a1>] shrink_dcache_memory [kernel] 0x21 
[<c0135bab>] do_try_to_free_pages [kernel] 0x1b 
[<c0135d28>] try_to_free_pages [kernel] 0x28 
[<c0136a11>] _wrapped_alloc_pages [kernel] 0x1c1 
[<c0136acf>] __alloc_pages [kernel] 0xf 
[<c012df71>] generic_file_readahead [kernel] 0x201 
[<c012e29d>] do_generic_file_read [kernel] 0x26d 
[<c012e774>] generic_file_read [kernel] 0x64 
[<c012e610>] file_read_actor [kernel] 0x0 
[<d08f20a4>] __insmod_nfsd_S.text_L52160 [nfsd] 0x4044 
[<d0856920>] __insmod_ext3_S.data_L672 [ext3] 0xc0 
[<d08f720b>] __insmod_nfsd_S.text_L52160 [nfsd] 0x91ab 
[<d08ff080>] __insmod_nfsd_S.data_L2208 [nfsd] 0x660 
[<d08ee5b1>] __insmod_nfsd_S.text_L52160 [nfsd] 0x551 
[<d08ff080>] __insmod_nfsd_S.data_L2208 [nfsd] 0x660 
[<d08d2d9a>] svc_process_Rsmp_64b56219 [sunrpc] 0x34a 
[<d08fea38>] __insmod_nfsd_S.data_L2208 [nfsd] 0x18 
[<d08fea58>] __insmod_nfsd_S.data_L2208 [nfsd] 0x38 
[<d08ee39b>] __insmod_nfsd_S.text_L52160 [nfsd] 0x33b 
[<c0105866>] kernel_thread [kernel] 0x26 
[<d08ee190>] __insmod_nfsd_S.text_L52160 [nfsd] 0x130 


Code: 8b 47 10 85 c0 74 04 53 ff d0 58 68 40 be 2d c0 8d 43 24 50 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000000b
 printing eip:
c01537aa
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01537aa>]    Not tainted
EFLAGS: 00010282
eax: fffffffb   ebx: c7245900   ecx: c7245910   edx: c7245910
esi: c56779e0   edi: fffffffb   ebp: 00000000   esp: cc6ebd34
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 980, stackpage=cc6eb000)
Stack: c0933d20 c0933d20 00000003 c0141ea8 c56779f8 c56779e0 c7245900 c0150eb6 
       c7245900 00000000 c1015278 00000000 c12df20c c1015278 00000000 c01357a5 
       00000000 000020f2 000000d2 00000000 000000d2 c01512a1 00000000 c0135bab 
Call Trace: [<c0141ea8>] try_to_free_buffers [kernel] 0xf8 
[<c0150eb6>] prune_dcache [kernel] 0xf6 
[<c01357a5>] page_launder [kernel] 0x8f5 
[<c01512a1>] shrink_dcache_memory [kernel] 0x21 
[<c0135bab>] do_try_to_free_pages [kernel] 0x1b 
[<c0135d28>] try_to_free_pages [kernel] 0x28 
[<c0136a11>] _wrapped_alloc_pages [kernel] 0x1c1 
[<c0136acf>] __alloc_pages [kernel] 0xf 
[<c012df71>] generic_file_readahead [kernel] 0x201 
[<c012e408>] do_generic_file_read [kernel] 0x3d8 
[<c012e774>] generic_file_read [kernel] 0x64 
[<c012e610>] file_read_actor [kernel] 0x0 
[<d08f20a4>] __insmod_nfsd_S.text_L52160 [nfsd] 0x4044 
[<d0856920>] __insmod_ext3_S.data_L672 [ext3] 0xc0 
[<d08f720b>] __insmod_nfsd_S.text_L52160 [nfsd] 0x91ab 
[<d08ff080>] __insmod_nfsd_S.data_L2208 [nfsd] 0x660 
[<d08ee5b1>] __insmod_nfsd_S.text_L52160 [nfsd] 0x551 
[<d08ff080>] __insmod_nfsd_S.data_L2208 [nfsd] 0x660 
[<d08d2d9a>] svc_process_Rsmp_64b56219 [sunrpc] 0x34a 
[<d08fea38>] __insmod_nfsd_S.data_L2208 [nfsd] 0x18 
[<d08fea58>] __insmod_nfsd_S.data_L2208 [nfsd] 0x38 
[<d08ee39b>] __insmod_nfsd_S.text_L52160 [nfsd] 0x33b 
[<c0105866>] kernel_thread [kernel] 0x26 
[<d08ee190>] __insmod_nfsd_S.text_L52160 [nfsd] 0x130 


Code: 8b 47 10 85 c0 74 04 53 ff d0 58 68 40 be 2d c0 8d 43 24 50 
 <7>eth0: 0 multicast blocks dropped.


The machine did not crash completely and I was still able to access it from remote (through ssh).
When I looked at top, kswapd was 'defunct' (zombie). Is this something that is fixed in newer
'vanilla' kernels (e.g 2.4.16) ?



-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
