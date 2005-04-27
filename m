Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVD0I5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVD0I5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 04:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVD0I5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 04:57:36 -0400
Received: from web40728.mail.yahoo.com ([66.218.92.66]:63912 "HELO
	web40728.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261189AbVD0I4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 04:56:34 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=uDECswFOSVBCtewALz8N9rlgk0/ZmWffxCpbGJo+FgWzJ4Wt4AYxB0K00JmKoXHrOQ8UJdsq0l2t0BgSJ4iXGBIfrCX1kUo38pji0kdAUXkyo/oeZ5fL2kwTZTaPh9iSqlWb/wWp2UeOAlbCTOd46sQR0Ov+mSRAwkegROn/t7I=  ;
Message-ID: <20050427085634.5871.qmail@web40728.mail.yahoo.com>
Date: Wed, 27 Apr 2005 01:56:33 -0700 (PDT)
From: dipankar das <dipankar_dd@yahoo.com>
Subject: Re: [kernel oops when locking the cluster using HAS]
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-869884599-1114592193=:5618"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-869884599-1114592193=:5618
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,


Summary of Problem :
The kernel genrates a oops message when the cluster is
locked by High Availability Services.

 1. Crash dump is attached with analysis.

 2. lock decb 0xc03cdd00(%ecx) it fails here really
cant make out why ?

 3.
(gdb) shell cat /proc/cpuinfo
processor       : 0
cpu_package     : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 7
cpu MHz         : 1599.865
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
mmx fxsr sse sse2 ss ht tm
bogomips        : 3191.60

processor       : 1
cpu_package     : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 7
cpu MHz         : 1599.865
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
mmx fxsr sse sse2 ss ht tm
bogomips        : 3198.15

processor       : 2
cpu_package     : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 7
cpu MHz         : 1599.865
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
mmx fxsr sse sse2 ss ht tm
bogomips        : 3198.15

processor       : 3
cpu_package     : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 1.60GHz
stepping        : 7
cpu MHz         : 1599.865
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 clflush dts acpi
mmx fxsr sse sse2 ss ht tm

Thanks in advance for your inputs.

- Dipankar
 




--- KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
wrote:
> Hi,
> 
> This is a updated version of a patch for counting
> bouce buffer page.
> A major change is :
> /proc/vmstat is used to show usage.
> 
> Thanks
> -- Kame
> > 
> This is a patch for counting the number of pages for
> bounce buffer.
> It's shown in /proc/vmstat.
> 
> Currently, the number of bounce pages are not
> counted anywhere.
> So, if there are many bounce pages, it seems that
> there are
> leaked pages. And it's difficult for a user to
> imagine the usage of
> bounce pages. So, it's meaningful to show # of bouce
> pages.
> 
> Signed-off-by: KAMEZAWA Hiroyuki
> <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
> 
> ---
> 
> 
>
linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h
> |    1 +
>  linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c         
>      |    2 ++
>  linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c      
>      |    1 +
>  3 files changed, 4 insertions(+)
> 
> diff -puN mm/highmem.c~count_bounce mm/highmem.c
> --- linux-2.6.12-rc2-mm3/mm/highmem.c~count_bounce
> 2005-04-25 12:04:28.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kamezawa/mm/highmem.c
> 2005-04-27 10:25:51.000000000 +0900
> @@ -325,6 +325,7 @@ static void bounce_end_io(struct
> bio *bi
>  			continue;
>  
>  		mempool_free(bvec->bv_page, pool);	
> +		dec_page_state(nr_bounce);
>  	}
>  
>  	bio_endio(bio_orig, bio_orig->bi_size, err);
> @@ -405,6 +406,7 @@ static void
> __blk_queue_bounce(request_q
>  		to->bv_page = mempool_alloc(pool, q->bounce_gfp);
>  		to->bv_len = from->bv_len;
>  		to->bv_offset = from->bv_offset;
> +		inc_page_state(nr_bounce);
>  
>  		if (rw == WRITE) {
>  			char *vto, *vfrom;
> diff -puN mm/page_alloc.c~count_bounce
> mm/page_alloc.c
> ---
> linux-2.6.12-rc2-mm3/mm/page_alloc.c~count_bounce
> 2005-04-27 10:15:39.000000000 +0900
> +++ linux-2.6.12-rc2-mm3-kamezawa/mm/page_alloc.c
> 2005-04-27 10:17:18.000000000 +0900
> @@ -1902,6 +1902,7 @@ static char *vmstat_text[] = {
>  	"nr_page_table_pages",
>  	"nr_mapped",
>  	"nr_slab",
> +	"nr_bounce",
>  
>  	"pgpgin",
>  	"pgpgout",
> diff -puN include/linux/page-flags.h~count_bounce
> include/linux/page-flags.h
> ---
>
linux-2.6.12-rc2-mm3/include/linux/page-flags.h~count_bounce
> 2005-04-27 10:23:15.000000000 +0900
> +++
>
linux-2.6.12-rc2-mm3-kamezawa/include/linux/page-flags.h
> 2005-04-27 10:24:11.000000000 +0900
> @@ -89,6 +89,7 @@ struct page_state {
>  	unsigned long nr_page_table_pages;/* Pages used
> for pagetables */
>  	unsigned long nr_mapped;	/* mapped into pagetables
> */
>  	unsigned long nr_slab;		/* In slab */
> +	unsigned long nr_bounce;	/* pages for bounce
> buffers */
>  #define GET_PAGE_STATE_LAST nr_slab
>  
>  	/*
> 
> _
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-869884599-1114592193=:5618
Content-Type: text/plain; name="crashdump.txt"
Content-Description: crashdump.txt
Content-Disposition: inline; filename="crashdump.txt"

Kernel Ooops when lockig cluster

root@CLA-0(clusterid):/var/mnt/local/sysimg/flexiserver/opt/_BP/nodes/SSN-0/var/crash# grep -A55 "Unable to handle" t |
ksymoops -m /System.map
ksymoops 2.4.3 on i686 2.4.17_MVL21CGE_38-cpi1. Options used
-V (default)
-k /proc/ksyms (default)
-l /proc/modules (default)
-o /lib/modules/2.4.17_MVL21CGE_38-cpi1/ (default)
-m /System.map (specified)

Warning (compare_maps): mismatch on symbol inflate , ksyms_base says
c02e8088, System.map says c020c114. Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name , ksyms_base
says c0249ff0, System.map says c01725dc. Ignoring ksyms_base entry
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Unable to handle kernel paging
request at virtual address 8f7d1d00
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: c011d81d
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: *pde = 00000000
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Oops: 0002
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: CPU: 2
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: EIP: 0010:
Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: EFLAGS: 00010006
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: eax: e97b2000 ebx: f5195ca4
ecx: cf400000 edx: e97bc000
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: esi: 00000001 edi: e97b2000
ebp: e97bd990 esp: e97bd95c
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: ds: 0018 es: 0018 ss: 0018
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Process smfloader (pid: 5695,
stackpage=e97bd000)
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Stack: f5195ca4 00000001
f5195c9c e97bd980 8f7d1d00 e97bd980 00000202 e97bd9d4
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 00000000 00000286 00163b06
00000200 00000200 e97bd9a0 c011d9ef e97b2000
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 00000000 f5195ca4 c02e49c3
f5195c80 fffff600 00000003 e97bda54 c02ee295
Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Call Trace: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: 

Apr 26 09:21:59 src@SSN-0/SSN-0 kernel: Code: f0 fe 89 00 1d 3d c0 0f 88
0c 09 1d 00 8b 77 20 8d 1c b6 c1

>>EIP; c011d81c <try_to_wake_up+64/22c> <=====
Trace; c011d9ee <wake_up_process+a/10>
Trace; c02e49c2 <rwsem_wake+9a/de>
Trace; c02ee294 <stext_lock+91c/c58c>
Trace; c016c272 <elf_core_dump+5a/bc0>
Trace; f8867b74 <[bonding]bond_xmit_activebackup+194/200>
Trace; c025ffa0 <dev_queue_xmit+258/3e8>
Trace; c0271f1a <ip_output+132/1a0>
Trace; c028d8f4 <udp_getfrag+0/c4>
Trace; c0272c5e <ip_build_xmit+2a6/36c>
Trace; c028dddc <udp_sendmsg+3e0/468>
Trace; c028d8f4 <udp_getfrag+0/c4>
Trace; c0294936 <inet_sendmsg+3a/40>
Trace; c0258cd4 <sock_sendmsg+94/b4>
Trace; c02d92a2 <xprt_release_write+4a/ac>
Trace; c02daf16 <do_xprt_transmit+452/464>
Trace; c02db924 <rpc_run_timer+0/c0>
Trace; c011dc88 <load_balance+58/494>
Trace; c02d82ba <rpc_release_client+3e/50>
Trace; c02dd266 <rpc_release_task+22e/254>
Trace; c02dca94 <__rpc_execute+3b8/3c8>
Trace; c02d8496 <rpc_call_sync+92/a4>
Trace; c02db924 <rpc_run_timer+0/c0>
Trace; c0140a2e <truncate_inode_pages+76/a4>
Trace; c013e35c <vmtruncate+dc/1d0>
Trace; c019fc46 <nfs_notify_change+136/148>
Trace; c016688e <notify_change+f2/11e>
Trace; c014e466 <do_truncate+4a/60>
Trace; c015983c <do_coredump+160/200>
Trace; c01071a4 <do_signal+354/44a>
Trace; c011cd6c <do_page_fault+0/534>
Trace; c0106576 <restore_sigcontext+116/13c>
Trace; c011cd6c <do_page_fault+0/534>
Trace; c0107a10 <trace_real_syscall_exit+8/10>
Trace; c01074c8 <error_code+34/40>
Trace; c01073e0 <signal_return+14/18>
Code; c011d81c <try_to_wake_up+64/22c>
00000000 <_EIP>:
Code; c011d81c <try_to_wake_up+64/22c> <=====
0: f0 fe 89 00 1d 3d c0 lock decb 0xc03d1d00(%ecx) <=====
Code; c011d822 <try_to_wake_up+6a/22c>
7: 0f 88 0c 09 1d 00 js 1d0919 <_EIP+0x1d0919> c02ee134
<stext_lock+7bc/c58c>
Code; c011d828 <try_to_wake_up+70/22c>
d: 8b 77 20 mov 0x20(%edi),%esi
Code; c011d82c <try_to_wake_up+74/22c>
10: 8d 1c b6 lea (%esi,%esi,4),%ebx
Code; c011d82e <try_to_wake_up+76/22c>
13: c1 00 00 roll $0x0,(%eax)


2 warnings issued. Results may not be reliable.
root@CLA-0(clusterid):/var/mnt/local/sysimg/flexiserver/opt/_BP/nodes/SSN-0/var/crash# 

list *try_to_wake_up+0x64
0xc011d81c is in try_to_wake_up (sched.c:187).
list *try_to_wake_up+0x70
/kernel/include/asm/spinlock.h:136

0xc011d82c is in try_to_wake_up (sched.c:188).



Dump of assembler code for function try_to_wake_up:
0xc011d7b8 <try_to_wake_up>:    push   %ebp
0xc011d7b9 <try_to_wake_up+1>:  mov    %esp,%ebp
0xc011d7bb <try_to_wake_up+3>:  sub    $0x28,%esp
0xc011d7be <try_to_wake_up+6>:  push   %edi
0xc011d7bf <try_to_wake_up+7>:  push   %esi
0xc011d7c0 <try_to_wake_up+8>:  push   %ebx
0xc011d7c1 <try_to_wake_up+9>:  mov    0x8(%ebp),%edi
0xc011d7c4 <try_to_wake_up+12>: movl   $0x0,0xffffffec(%ebp)
0xc011d7cb <try_to_wake_up+19>: movb   $0x6,0xfffffff4(%ebp)
0xc011d7cf <try_to_wake_up+23>: mov    0x88(%edi),%eax
0xc011d7d5 <try_to_wake_up+29>: mov    %eax,0xfffffff5(%ebp)
0xc011d7d8 <try_to_wake_up+32>: mov    (%edi),%eax
0xc011d7da <try_to_wake_up+34>: mov    %eax,0xfffffff9(%ebp)
0xc011d7dd <try_to_wake_up+37>: lea    0xfffffff4(%ebp),%eax
0xc011d7e0 <try_to_wake_up+40>: push   %eax
0xc011d7e1 <try_to_wake_up+41>: push   $0xa
0xc011d7e3 <try_to_wake_up+43>: call   0xc013ce8c <trace_event>
0xc011d7e8 <try_to_wake_up+48>: add    $0x8,%esp
0xc011d7eb <try_to_wake_up+51>: lea    0xfffffff0(%ebp),%eax
0xc011d7ee <try_to_wake_up+54>: mov    %eax,0xffffffd8(%ebp)
0xc011d7f1 <try_to_wake_up+57>: lea    0x0(%esi),%esi
0xc011d7f4 <try_to_wake_up+60>: mov    0xffffffd8(%ebp),%edx
0xc011d7f7 <try_to_wake_up+63>: mov    %edx,0xffffffe0(%ebp)
0xc011d7fa <try_to_wake_up+66>: mov    0xffffffe0(%ebp),%eax
0xc011d7fd <try_to_wake_up+69>: pushf
0xc011d7fe <try_to_wake_up+70>: popl   (%eax)
0xc011d800 <try_to_wake_up+72>: cli
0xc011d801 <try_to_wake_up+73>: mov    0x20(%edi),%eax
0xc011d804 <try_to_wake_up+76>: lea    (%eax,%eax,4),%ecx
0xc011d807 <try_to_wake_up+79>: shl    $0x9,%ecx
0xc011d80a <try_to_wake_up+82>: lea    0xc03cdd00(%ecx),%edx
0xc011d810 <try_to_wake_up+88>: mov    %edx,0xffffffdc(%ebp)
0xc011d813 <try_to_wake_up+91>: mov    $0xffffe000,%edx
0xc011d818 <try_to_wake_up+96>: and    %esp,%edx
0xc011d81a <try_to_wake_up+98>: incl   0x4(%edx)
0xc011d81d <try_to_wake_up+101>:        lock decb 0xc03cdd00(%ecx)
0xc011d824 <try_to_wake_up+108>:        js     0xc02eb116 <stext_lock+1982>
0xc011d82a <try_to_wake_up+114>:        mov    0x20(%edi),%esi
0xc011d82d <try_to_wake_up+117>:        lea    (%esi,%esi,4),%ebx
0xc011d830 <try_to_wake_up+120>:        shl    $0x9,%ebx
0xc011d833 <try_to_wake_up+123>:        lea    0xc03cdd00(%ebx),%eax
0xc011d839 <try_to_wake_up+129>:        cmp    %eax,0xffffffdc(%ebp)
0xc011d83c <try_to_wake_up+132>:        je     0xc011d860 <try_to_wake_up+168>


gdb) shell cat /proc/scsi/
qla2300  scsi     sg
(gdb) shell cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 62 Lun: 00
  Vendor: IBM      Model: IC35L146F2DY10-0 Rev: F56A  Ser#: ECV4UN0B
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Tallies: timeouts 0 resets 0 par_errs 0 disk_errs 0 trans_errs 0 user_errs 41
Host: scsi0 Channel: 00 Id: 63 Lun: 00
  Vendor: IBM      Model: IC35L146F2DY10-0 Rev: F56A  Ser#: ECV73EHB
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Tallies: timeouts 0 resets 0 par_errs 0 disk_errs 0 trans_errs 0 user_errs 1
Host: scsi1 Channel: 00 Id: 62 Lun: 00
  Vendor: IBM      Model: IC35L146F2DY10-0 Rev: F56A  Ser#: ECV4UN0B
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Tallies: timeouts 0 resets 0 par_errs 0 disk_errs 0 trans_errs 0 user_errs 1
Host: scsi1 Channel: 00 Id: 63 Lun: 00
  Vendor: IBM      Model: IC35L146F2DY10-0 Rev: F56A  Ser#: ECV73EHB
  Type:   Direct-Access                    ANSI SCSI revision: 03
  Tallies: timeouts 0 resets 0 par_errs 0 disk_errs 0 trans_errs 0 user_errs 44


--0-869884599-1114592193=:5618--
