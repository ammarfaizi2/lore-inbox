Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131427AbQLMPjU>; Wed, 13 Dec 2000 10:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbQLMPjK>; Wed, 13 Dec 2000 10:39:10 -0500
Received: from sanrafael.dti2.net ([195.57.112.5]:46343 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S131427AbQLMPi6>;
	Wed, 13 Dec 2000 10:38:58 -0500
Message-ID: <000901c06516$97f8e150$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: "Carlos E. Gorges" <carlos@techlinux.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <873dftywn6.fsf@cartman.azz.net> <00121311262200.00911@shark.techlinux>
Subject: RE: Possible patch for reiserfs-3.6.22 against 2.4.0-test12
Date: Wed, 13 Dec 2000 16:08:33 +0100
Organization: DTI2 - Desarrollo de la Tecnología de las Comunicaciones
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Carlos!

    I have this oops with your patch. applied to clean 2.4.0test12+reiserfs
3.6.22

    reiserfs is compiled as module. I can mount the partition but after 4 o
5 seconds kupdate oops, dies and I have to reboot becauser I can no longer
write to any disk. The system didn't crashed I can open new terminal and run
programs.

    Please don't hesitate to contact me if you need more info.

    -Jorge

---------------------------------------------------------------------
ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.0-test12/ (specified)
     -m /boot/System.map-2.4.0-test12 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
d084d180
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[reiserfs:__insmod_reiserfs_S.text_L121821+106784/121888]
EFLAGS: 00010046
eax: 00000246   ebx: cf734680   ecx: 00000000   edx: cf734000
esi: cf734694   edi: 00000000   ebp: 00000000   esp: c15e7f0c
ds: 0018   es: 0018   ss: 0018
Process kupdate (pid: 6, stackpage=c15e7000)
Stack: 00000000 00000012 00000010 d084f450 c1550e00 00000000 c15e7f98
c15e623a
       d0856916 c1550e00 00003ce1 00000000 00000001 00000000 0000000c
0000000b
       00000000 00001cd6 cf9964c0 cfe57340 ceaed000 cf8de000 d08782f4
d084e21e
Call Trace: [reiserfs:__insmod_reiserfs_S.text_L121821+115696/121888]
[reiserfs:__insmod_reiserfs_S.rodata_L26959+23702/26976]
[scsi_mod:proc_scsi_Rba5e7901+345560/74510060]
[reiserfs:__insmod_reiserfs_S.text_L121821+111038/121888]
[reiserfs:__insmod_reiserfs_S.rodata_L26959+23279/26976]
[reiserfs:__insmod_reiserfs_S.text_L121821+50184/121888] [tvecs+13774/62872]
Code: 8b 51 04 89 71 04 89 4b 14 89 56 04 89 32 50 9d b9 01 00 00
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  00000003 Before first symbol
   3:   89 71 04                  mov    %esi,0x4(%ecx)
Code;  00000006 Before first symbol
   6:   89 4b 14                  mov    %ecx,0x14(%ebx)
Code;  00000009 Before first symbol
   9:   89 56 04                  mov    %edx,0x4(%esi)
Code;  0000000c Before first symbol
   c:   89 32                     mov    %esi,(%edx)
Code;  0000000e Before first symbol
   e:   50                        push   %eax
Code;  0000000f Before first symbol
   f:   9d                        popf
Code;  00000010 Before first symbol
  10:   b9 01 00 00 00            mov    $0x1,%ecx
----------------------------------------------------------------

==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
Without wicker a basket cannot be done.
==============================================================

----- Mensaje original -----
De: "Carlos E. Gorges" <carlos@techlinux.com.br>
Para: <linux-kernel@vger.kernel.org>
Enviado: miércoles, 13 de diciembre de 2000 14:14
Asunto: Re: Possible patch for reiserfs-3.6.22 against 2.4.0-test12


> > Hiya.
> >
> > The latest reiserfs patch on ftp.namesys.com causes compilation errors
> > against test12 due to the task queue changes. Does this look correct?
> >
>
> Please, somebody can test this patch
>
> -- BOF --
> diff -ur linux-bk/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
> --- linux-bk/fs/reiserfs/journal.c Tue Dec 12 14:38:22 2000
> +++ linux/fs/reiserfs/journal.c Tue Dec 12 17:41:19 2000
> @@ -77,7 +77,9 @@
>
>  /* wait on this if you need to be sure you task queue entries have been
run */
>  static DECLARE_WAIT_QUEUE_HEAD(reiserfs_commit_thread_done) ;
> -DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ;
> +
> +/*DECLARE_TASK_QUEUE(reiserfs_commit_thread_tq) ; */
> +task_queue *reiserfs_commit_thread_tq = NULL;
>
>  #define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and
commit structs at 4k */
>
> @@ -1762,7 +1764,7 @@
>    ct->p_s_sb = p_s_sb ;
>    ct->jindex = jindex ;
>    ct->task_done = NULL ;
> -  ct->task.next = NULL ;
> +  INIT_LIST_HEAD(&ct->task.list);
>    ct->task.sync = 0 ;
>    ct->task.routine = (void *)(void *)reiserfs_journal_commit_task_func ;
>    ct->self = ct ;
> @@ -1777,7 +1779,7 @@
>    ct = kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_BUFFER) ;
>    if (ct) {
>      setup_commit_task_arg(ct, p_s_sb, jindex) ;
> -    queue_task(&(ct->task), &reiserfs_commit_thread_tq);
> +    queue_task(&(ct->task), reiserfs_commit_thread_tq);
>      wake_up(&reiserfs_commit_thread_wait) ;
>    } else {
>  #ifdef CONFIG_REISERFS_CHECK
> @@ -1813,13 +1814,13 @@
>    lock_kernel() ;
>    while(1) {
>
> -    while(reiserfs_commit_thread_tq) {
> -      run_task_queue(&reiserfs_commit_thread_tq) ;
> +    while(reiserfs_commit_thread_tq) {
> + run_task_queue(reiserfs_commit_thread_tq) ;
>      }
>
>      /* if there aren't any more filesystems left, break */
>      if (reiserfs_mounted_fs_count <= 0) {
> -      run_task_queue(&reiserfs_commit_thread_tq) ;
> +      run_task_queue(reiserfs_commit_thread_tq) ;
>        break ;
>      }
>      wake_up(&reiserfs_commit_thread_done) ;
> diff -ur linux-bk/include/linux/reiserfs_fs.h
linux/include/linux/reiserfs_fs.h
> --- linux-bk/include/linux/reiserfs_fs.h Tue Dec 12 14:39:34 2000
> +++ linux/include/linux/reiserfs_fs.h Tue Dec 12 17:31:09 2000
> @@ -1565,8 +1565,8 @@
>    int do_not_lock ;
>  } ;
>
> -extern task_queue reiserfs_commit_thread_tq ;
> -extern task_queue reiserfs_end_io_tq ;
> +extern task_queue *reiserfs_commit_thread_tq ;
> +extern task_queue *reiserfs_end_io_tq ;
>  extern wait_queue_head_t reiserfs_commit_thread_wait ;
>
>  /* biggest tunable defines are right here */
> -- EOF --
>
> cya;
>
> --
> _________________________
> Carlos E Gorges
> (carlos@techlinux.com.br)
> Tech informática LTDA
> Brazil
> _________________________
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
