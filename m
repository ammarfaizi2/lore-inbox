Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbTCSXl1>; Wed, 19 Mar 2003 18:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbTCSXl0>; Wed, 19 Mar 2003 18:41:26 -0500
Received: from shuzbut.anathoth.gen.nz ([202.49.159.11]:33152 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S263266AbTCSXkq>; Wed, 19 Mar 2003 18:40:46 -0500
Subject: Re: Ptrace patch for 2.4.x BREAKS kill() 2 interesting effects for
	.pid and dot locking? (was Re: Ptrace hole / Linux 2.2.25)
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, debian-security@lists.debian.org,
       Herbert Xu <herbert@debian.org>
In-Reply-To: <1048113787.23160.21.camel@luther>
References: <1048104545.20129.24.camel@zion> 
	<1048109690.23160.5.camel@luther>  <1048113787.23160.21.camel@luther>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-M8qrggAvfCUMJZ+098hj"
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Mar 2003 11:51:31 +1200
Message-Id: <1048117897.22536.27.camel@luther>
Mime-Version: 1.0
X-Virus-Scanned-By: Amavis with CLAM Anti Virus on shuzbut.anathoth.gen.nz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M8qrggAvfCUMJZ+098hj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am eating my own shorts here....

kill() 2 does actually behave the way it is supposed to.

BUT these are correct:

- Debian netsaint does definitely have problems with its Web frond end
NOT being able to some see the netsaint process running as netsaint user
from the Web server running as www-data.

- User Mode Linux SKAs mode is definitely BORKED!

Work around described below is correct as far as I have read.ie
recompile kernel with no auto-module loading, or echo garbage executable
name (one that does not exist) int /proc/sys/kernel/modprobe.

Best Regards

On Thu, 2003-03-20 at 10:43, Matthew Grant wrote:
    Hi There!
   =20
    Sorry about making a racket, but I am posting this for the edification
    of all, as there is a work around without breaking your server for this
    one.
   =20
    As you can read below, I have found that the patch on 2.4.x also BREAKS
    kill() 2 when executed for signal 0 on a process ID that the user is no=
t
    the owner of, except for root of course.
   =20
    This has all sorts of interesting effects for processing .pid files, an=
d
    probably dot locking.....  Makes the patch as it stands unacceptable fo=
r
    2.4.21, and vendor kernels I would say... (See below for effects on
    Debian netsaint...)
   =20
    I have been just digging harder, and the vulnerability is only
    exploitable if you are using the kernel auto module loader, so compile
    your kernel with out auto module loader enabled, or echo some garbage
    into /proc/sys/kernel/modprobe after loading all your modules.  It has
    to be an invalid executable name in there as any executable file will
    open the bug to exploit.
   =20
    Here are the effects on a netsaint box I look after:
   =20
    bucket: -foo- [~]=20
    $ ls -l /var/run/netsaint/netsaint.pid=20
    -rw-r--r--    1 root     root            5 Mar 19 16:32 /var/run/netsai=
nt/netsaint.pid
   =20
    bucket: -foo- [~]=20
    $ cat !$
    cat /var/run/netsaint/netsaint.pid
    4276
   =20
    bucket: -foo- [~]=20
    $ kill -0 4276
    bash: kill: (4276) - Operation not permitted
   =20
    and the netsaint Web front end can't find the process alive that it
    wants to talk to via a unix pipe so that it can start and stop
    notifications etc....
   =20
    Could I please say this to the kernel developers, please fix it
    properly!
   =20
    Thanks heaps,=20
   =20
    Matthew Grant
   =20
    On Thu, 2003-03-20 at 09:34, Matthew Grant wrote:
        Dear All,
       =20
        The patch also breaks kill(2) on a process with signal number 0 - T=
his
        is used by a lot of monitoring programs running as one user ID to m=
ake
        sure a process with another user ID is running.
       =20
        This causes trouble with packages like nagios and netsaint, as well=
 as
        other stuff.
       =20
        Alan, don't want to bash you around, but isn't there another fix
        possible that doesn't break this function call and UML skas mode?
       =20
        Cheers,
       =20
        Matthew Grantal
       =20
        On Thu, 2003-03-20 at 08:09, Matthew Grant wrote:
            Mistyped linux-kernel address  %-<=20
           =20
            -----Forwarded Message-----=20
           =20
            From: Matthew Grant <grantma@anathoth.gen.nz>
            To: Alan Cox <alan@lxorguk.ukuu.org.uk>
            Cc: Jeff Dike <jdike@karaya.com>, liinux-kerel@vger.kernel.org
            Subject: Re: Ptrace hole / Linux 2.2.25
            Date: 20 Mar 2003 07:55:45 +1200
           =20
            Alan,
           =20
            This patch really breaks UML using the skas mode of thread trac=
ing skas3
            patch on quite a significant amount of machines out there. The =
skas mode
            is a lot more secure than the traditional UML tt mode. I guess =
this is
            related to the below...
           =20
            I am running a UML site that a lot of hospitals ad clinics in B=
angldesh
            depend on for there email.  It allows them to work around the c=
orruption
            and agrandidement of the ISPs over there.  The skas3 mode patch=
 is
            needed for the site to run securely.  Tracing thread mode does =
not cut
            it.
           =20
            There are also a large number of other telehoused ISP virtual h=
osting=20
            machines that use this stuff, and it is actually proving to be =
quite
            reliable.
           =20
            I have attached the skas3 patch that Jeff Dike is currently usi=
ng, and
            the patch that you have produced.  Could you please look into t=
he clash
            between them, and get it fixed.
           =20
            Thank you - there are lots out there who will appreciate this.
           =20
            Cheers,
           =20
            Matthew Grant
           =20
            On Mon, 2003-03-17 at 18:39, Ben Pfaff wrote:
            > I am concerned about this change because it will break sandbo=
xing
            > software that I have written, which uses prctl() to turn
            > dumpability back on so that it can open a file, setuid(), and
            > then execve() through the open file via /proc/self/fd/#. With=
out
            > calling prctl(), the ownership of /proc/self/fd/* becomes roo=
t,
            > so the process cannot exec it after it drops privileges. It u=
ses
            > prctl() in other places to get the same effect in /proc, but
            > that's one of the most critical.
           =20
            The dumpability is per mm, which means that you have to conside=
r
            all the cases of a thread being created in parallel to dumpabil=
ity
            being enabled.
           =20
            So consider a three threaded process. Thread one triggers kerne=
l thread
            creation, thread two turns dumpability back on, thread three pt=
races
            the new kernel thread.
           =20
            Proving that is safe is non trivial so the current patch choose=
s not
            to attempt it. For 2.4.21 proper someone can sit down and do th=
e needed
            verification if they wish=20
           =20
            --=20
            =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
            Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz      /~~~~\
            A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/**=
****\
            =3D=3D=3DGPG KeyID: 2EE20270  FingerPrint:
            8C2535E1A11DF3EA5EA19125BA4E790E2EE20270=3D=3D
           =20
            _______________________________________________________________=
_________
           =20
            diff -Naur host/arch/i386/config.in host-ptrace/arch/i386/confi=
g.in
            --- host/arch/i386/config.in	Fri Aug  9 15:57:14 2002
            +++ host-ptrace/arch/i386/config.in	Sun Nov 10 18:40:09 2002
            @@ -291,6 +291,8 @@
                bool '    Use real mode APM BIOS call to power off' CONFIG_=
APM_REAL_MODE_POWER_OFF
             fi
            =20
            +bool '/proc/mm' CONFIG_PROC_MM
            +
             endmenu
            =20
             source drivers/mtd/Config.in
            diff -Naur host/arch/i386/kernel/ldt.c host-ptrace/arch/i386/ke=
rnel/ldt.c
            --- host/arch/i386/kernel/ldt.c	Fri Oct 26 00:01:41 2001
            +++ host-ptrace/arch/i386/kernel/ldt.c	Sun Nov  3 18:37:48 2002
            @@ -24,11 +24,12 @@
              * assured by user-space anyway. Writes are atomic, to protect
              * the security checks done on new descriptors.
              */
            -static int read_ldt(void * ptr, unsigned long bytecount)
            +static int read_ldt(struct task_struct *task, void * ptr,=20
            +		    unsigned long bytecount)
             {
             	int err;
             	unsigned long size;
            -	struct mm_struct * mm =3D current->mm;
            +	struct mm_struct * mm =3D task->mm;
            =20
             	err =3D 0;
             	if (!mm->context.segments)
            @@ -64,9 +65,10 @@
             	return err;
             }
            =20
            -static int write_ldt(void * ptr, unsigned long bytecount, int =
oldmode)
            +static int write_ldt(struct task_struct *task, void * ptr,=20
            +		     unsigned long bytecount, int oldmode)
             {
            -	struct mm_struct * mm =3D current->mm;
            +	struct mm_struct * mm =3D task->mm;
             	__u32 entry_1, entry_2, *lp;
             	int error;
             	struct modify_ldt_ldt_s ldt_info;
            @@ -148,23 +150,29 @@
             	return error;
             }
            =20
            -asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned lo=
ng bytecount)
            +int modify_ldt(struct task_struct *task, int func, void *ptr,=20
            +	       unsigned long bytecount)
             {
             	int ret =3D -ENOSYS;
            =20
             	switch (func) {
             	case 0:
            -		ret =3D read_ldt(ptr, bytecount);
            +		ret =3D read_ldt(task, ptr, bytecount);
             		break;
             	case 1:
            -		ret =3D write_ldt(ptr, bytecount, 1);
            +		ret =3D write_ldt(task, ptr, bytecount, 1);
             		break;
             	case 2:
             		ret =3D read_default_ldt(ptr, bytecount);
             		break;
             	case 0x11:
            -		ret =3D write_ldt(ptr, bytecount, 0);
            +		ret =3D write_ldt(task, ptr, bytecount, 0);
             		break;
             	}
             	return ret;
            +}
            +
            +asmlinkage int sys_modify_ldt(int func, void *ptr, unsigned lo=
ng bytecount)
            +{
            +	return(modify_ldt(current, func, ptr, bytecount));
             }
            diff -Naur host/arch/i386/kernel/process.c host-ptrace/arch/i38=
6/kernel/process.c
            --- host/arch/i386/kernel/process.c	Fri Aug  9 15:57:14 2002
            +++ host-ptrace/arch/i386/kernel/process.c	Wed Nov  6 22:12:45 =
2002
            @@ -551,13 +551,11 @@
              * we do not have to muck with descriptors here, that is
              * done in switch_mm() as needed.
              */
            -void copy_segments(struct task_struct *p, struct mm_struct *ne=
w_mm)
            +void mm_copy_segments(struct mm_struct *old_mm, struct mm_stru=
ct *new_mm)
             {
            -	struct mm_struct * old_mm;
             	void *old_ldt, *ldt;
            =20
             	ldt =3D NULL;
            -	old_mm =3D current->mm;
             	if (old_mm && (old_ldt =3D old_mm->context.segments) !=3D NUL=
L) {
             		/*
             		 * Completely new LDT, we initialize it from the parent:
            @@ -570,6 +568,16 @@
             	}
             	new_mm->context.segments =3D ldt;
             	new_mm->context.cpuvalid =3D ~0UL;	/* valid on all CPU's - th=
ey can't have stale data */
            +}
            +
            +void copy_segments(struct task_struct *p, struct mm_struct *ne=
w_mm)
            +{
            +	mm_copy_segments(current->mm, new_mm);
            +}
            +
            +void copy_task_segments(struct task_struct *from, struct mm_st=
ruct *new_mm)
            +{
            +	mm_copy_segments(from->mm, new_mm);
             }
            =20
             /*
            diff -Naur host/arch/i386/kernel/ptrace.c host-ptrace/arch/i386=
/kernel/ptrace.c
            --- host/arch/i386/kernel/ptrace.c	Fri Aug  9 15:57:14 2002
            +++ host-ptrace/arch/i386/kernel/ptrace.c	Mon Nov 11 19:03:38 2=
002
            @@ -147,6 +147,11 @@
             	put_stack_long(child, EFL_OFFSET, tmp);
             }
            =20
            +extern int modify_ldt(struct task_struct *task, int func, void=
 *ptr,=20
            +		      unsigned long bytecount);
            +
            +extern struct mm_struct *proc_mm_get_mm(int fd);
            +
             asmlinkage int sys_ptrace(long request, long pid, long addr, l=
ong data)
             {
             	struct task_struct *child;
            @@ -415,6 +420,53 @@
             			child->ptrace |=3D PT_TRACESYSGOOD;
             		else
             			child->ptrace &=3D ~PT_TRACESYSGOOD;
            +		ret =3D 0;
            +		break;
            +	}
            +
            +	case PTRACE_FAULTINFO: {
            +		struct ptrace_faultinfo fault;
            +
            +		fault =3D ((struct ptrace_faultinfo)=20
            +			{ .is_write	=3D child->thread.error_code,
            +			  .addr		=3D child->thread.cr2 });
            +		ret =3D copy_to_user((unsigned long *) data, &fault,=20
            +				   sizeof(fault));
            +		if(ret)
            +			break;
            +		break;
            +	}
            +	case PTRACE_SIGPENDING:
            +		ret =3D copy_to_user((unsigned long *) data,=20
            +				   &child->pending.signal,
            +				   sizeof(child->pending.signal));
            +		break;
            +
            +	case PTRACE_LDT: {
            +		struct ptrace_ldt ldt;
            +
            +		if(copy_from_user(&ldt, (unsigned long *) data,=20
            +				  sizeof(ldt))){
            +			ret =3D -EIO;
            +			break;
            +		}
            +		ret =3D modify_ldt(child, ldt.func, ldt.ptr, ldt.bytecount);
            +		break;
            +	}
            +
            +	case PTRACE_SWITCH_MM: {
            +		struct mm_struct *old =3D child->mm;
            +		struct mm_struct *new =3D proc_mm_get_mm(data);
            +
            +		if(IS_ERR(new)){
            +			ret =3D PTR_ERR(new);
            +			break;
            +		}
            +
            +		atomic_inc(&new->mm_users);
            +		child->mm =3D new;
            +		child->active_mm =3D new;
            +		mmput(old);
             		ret =3D 0;
             		break;
             	}
            diff -Naur host/arch/i386/kernel/sys_i386.c host-ptrace/arch/i3=
86/kernel/sys_i386.c
            --- host/arch/i386/kernel/sys_i386.c	Mon Mar 19 15:35:09 2001
            +++ host-ptrace/arch/i386/kernel/sys_i386.c	Mon Nov 11 17:23:25=
 2002
            @@ -40,7 +40,7 @@
             }
            =20
             /* common code for old and new mmaps */
            -static inline long do_mmap2(
            +long do_mmap2(struct mm_struct *mm,
             	unsigned long addr, unsigned long len,
             	unsigned long prot, unsigned long flags,
             	unsigned long fd, unsigned long pgoff)
            @@ -55,9 +55,9 @@
             			goto out;
             	}
            =20
            -	down_write(&current->mm->mmap_sem);
            -	error =3D do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
            -	up_write(&current->mm->mmap_sem);
            +	down_write(&mm->mmap_sem);
            +	error =3D do_mmap_pgoff(mm, file, addr, len, prot, flags, pgo=
ff);
            +	up_write(&mm->mmap_sem);
            =20
             	if (file)
             		fput(file);
            @@ -69,7 +69,7 @@
             	unsigned long prot, unsigned long flags,
             	unsigned long fd, unsigned long pgoff)
             {
            -	return do_mmap2(addr, len, prot, flags, fd, pgoff);
            +	return do_mmap2(current->mm, addr, len, prot, flags, fd, pgof=
f);
             }
            =20
             /*
            @@ -100,7 +100,7 @@
             	if (a.offset & ~PAGE_MASK)
             		goto out;
            =20
            -	err =3D do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offs=
et >> PAGE_SHIFT);
            +	err =3D do_mmap2(current->mm, a.addr, a.len, a.prot, a.flags,=
 a.fd, a.offset >> PAGE_SHIFT);
             out:
             	return err;
             }
            diff -Naur host/include/asm-i386/processor.h host-ptrace/includ=
e/asm-i386/processor.h
            --- host/include/asm-i386/processor.h	Sun Nov 10 18:47:37 2002
            +++ host-ptrace/include/asm-i386/processor.h	Mon Nov 11 17:33:3=
0 2002
            @@ -436,6 +436,8 @@
             extern int kernel_thread(int (*fn)(void *), void * arg, unsign=
ed long flags);
            =20
             /* Copy and release all segment info associated with a VM */
            +extern void mm_copy_segments(struct mm_struct *old_mm,=20
            +			     struct mm_struct *new_mm);
             extern void copy_segments(struct task_struct *p, struct mm_str=
uct * mm);
             extern void release_segments(struct mm_struct * mm);
            =20
            diff -Naur host/include/asm-i386/ptrace.h host-ptrace/include/a=
sm-i386/ptrace.h
            --- host/include/asm-i386/ptrace.h	Sun Sep 23 19:20:51 2001
            +++ host-ptrace/include/asm-i386/ptrace.h	Sun Nov 10 18:36:22 2=
002
            @@ -51,6 +51,22 @@
            =20
             #define PTRACE_SETOPTIONS         21
            =20
            +struct ptrace_faultinfo {
            +	int is_write;
            +	unsigned long addr;
            +};
            +
            +struct ptrace_ldt {
            +	int func;
            +  	void *ptr;
            +	unsigned long bytecount;
            +};
            +
            +#define PTRACE_FAULTINFO 52
            +#define PTRACE_SIGPENDING 53
            +#define PTRACE_LDT 54
            +#define PTRACE_SWITCH_MM 55
            +
             /* options set using PTRACE_SETOPTIONS */
             #define PTRACE_O_TRACESYSGOOD     0x00000001
            =20
            diff -Naur host/include/linux/mm.h host-ptrace/include/linux/mm=
.h
            --- host/include/linux/mm.h	Fri Aug 30 15:03:44 2002
            +++ host-ptrace/include/linux/mm.h	Mon Nov 11 19:08:53 2002
            @@ -492,6 +492,9 @@
             int get_user_pages(struct task_struct *tsk, struct mm_struct *=
mm, unsigned long start,
             		int len, int write, int force, struct page **pages, struct v=
m_area_struct **vmas);
            =20
            +extern long do_mprotect(struct mm_struct *mm, unsigned long st=
art,=20
            +			size_t len, unsigned long prot);
            +
             /*
              * On a two-level page table, this ends up being trivial. Thus=
 the
              * inlining and the symmetry break with pte_alloc() that does =
all
            @@ -539,9 +542,10 @@
            =20
             extern unsigned long get_unmapped_area(struct file *, unsigned=
 long, unsigned long, unsigned long, unsigned long);
            =20
            -extern unsigned long do_mmap_pgoff(struct file *file, unsigned=
 long addr,
            -	unsigned long len, unsigned long prot,
            -	unsigned long flag, unsigned long pgoff);
            +extern unsigned long do_mmap_pgoff(struct mm_struct *mm,=20
            +				   struct file *file, unsigned long addr,
            +				   unsigned long len, unsigned long prot,
            +				   unsigned long flag, unsigned long pgoff);
            =20
             static inline unsigned long do_mmap(struct file *file, unsigne=
d long addr,
             	unsigned long len, unsigned long prot,
            @@ -551,7 +555,7 @@
             	if ((offset + PAGE_ALIGN(len)) < offset)
             		goto out;
             	if (!(offset & ~PAGE_MASK))
            -		ret =3D do_mmap_pgoff(file, addr, len, prot, flag, offset >>=
 PAGE_SHIFT);
            +		ret =3D do_mmap_pgoff(current->mm, file, addr, len, prot, fl=
ag, offset >> PAGE_SHIFT);
             out:
             	return ret;
             }
            diff -Naur host/include/linux/proc_mm.h host-ptrace/include/lin=
ux/proc_mm.h
            --- host/include/linux/proc_mm.h	Wed Dec 31 19:00:00 1969
            +++ host-ptrace/include/linux/proc_mm.h	Mon Nov 11 17:41:09 200=
2
            @@ -0,0 +1,44 @@
            +/*=20
            + * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
            + * Licensed under the GPL
            + */
            +
            +#ifndef __PROC_MM_H
            +#define __PROC_MM_H
            +
            +#define MM_MMAP 54
            +#define MM_MUNMAP 55
            +#define MM_MPROTECT 56
            +#define MM_COPY_SEGMENTS 57
            +
            +struct mm_mmap {
            +	unsigned long addr;
            +	unsigned long len;
            +	unsigned long prot;
            +	unsigned long flags;
            +	unsigned long fd;
            +	unsigned long offset;
            +};
            +
            +struct mm_munmap {
            +	unsigned long addr;
            +	unsigned long len;=09
            +};
            +
            +struct mm_mprotect {
            +	unsigned long addr;
            +	unsigned long len;
            +        unsigned int prot;
            +};
            +
            +struct proc_mm_op {
            +	int op;
            +	union {
            +		struct mm_mmap mmap;
            +		struct mm_munmap munmap;
            +	        struct mm_mprotect mprotect;
            +		int copy_segments;
            +	} u;
            +};
            +
            +#endif
            diff -Naur host/mm/Makefile host-ptrace/mm/Makefile
            --- host/mm/Makefile	Fri Aug  9 15:57:31 2002
            +++ host-ptrace/mm/Makefile	Sun Nov 10 18:37:33 2002
            @@ -17,5 +17,6 @@
             	    shmem.o
            =20
             obj-$(CONFIG_HIGHMEM) +=3D highmem.o
            +obj-$(CONFIG_PROC_MM) +=3D proc_mm.o
            =20
             include $(TOPDIR)/Rules.make
            diff -Naur host/mm/mmap.c host-ptrace/mm/mmap.c
            --- host/mm/mmap.c	Fri Aug  9 15:57:31 2002
            +++ host-ptrace/mm/mmap.c	Mon Nov 11 17:24:18 2002
            @@ -390,10 +390,11 @@
             	return 0;
             }
            =20
            -unsigned long do_mmap_pgoff(struct file * file, unsigned long =
addr, unsigned long len,
            -	unsigned long prot, unsigned long flags, unsigned long pgoff)
            +unsigned long do_mmap_pgoff(struct mm_struct *mm, struct file =
* file,=20
            +			    unsigned long addr, unsigned long len,
            +			    unsigned long prot, unsigned long flags,=20
            +			    unsigned long pgoff)
             {
            -	struct mm_struct * mm =3D current->mm;
             	struct vm_area_struct * vma, * prev;
             	unsigned int vm_flags;
             	int correct_wcount =3D 0;
            diff -Naur host/mm/mprotect.c host-ptrace/mm/mprotect.c
            --- host/mm/mprotect.c	Fri Aug  9 15:57:31 2002
            +++ host-ptrace/mm/mprotect.c	Mon Nov 11 17:47:58 2002
            @@ -264,7 +264,8 @@
             	return 0;
             }
            =20
            -asmlinkage long sys_mprotect(unsigned long start, size_t len, =
unsigned long prot)
            +long do_mprotect(struct mm_struct *mm, unsigned long start, si=
ze_t len,=20
            +		 unsigned long prot)
             {
             	unsigned long nstart, end, tmp;
             	struct vm_area_struct * vma, * next, * prev;
            @@ -281,9 +282,9 @@
             	if (end =3D=3D start)
             		return 0;
            =20
            -	down_write(&current->mm->mmap_sem);
            +	down_write(&mm->mmap_sem);
            =20
            -	vma =3D find_vma_prev(current->mm, start, &prev);
            +	vma =3D find_vma_prev(mm, start, &prev);
             	error =3D -ENOMEM;
             	if (!vma || vma->vm_start > start)
             		goto out;
            @@ -332,6 +333,11 @@
             		prev->vm_mm->map_count--;
             	}
             out:
            -	up_write(&current->mm->mmap_sem);
            +	up_write(&mm->mmap_sem);
             	return error;
            +}
            +
            +asmlinkage long sys_mprotect(unsigned long start, size_t len, =
unsigned long prot)
            +{
            +	return(do_mprotect(current->mm, start, len, prot));
             }
            diff -Naur host/mm/proc_mm.c host-ptrace/mm/proc_mm.c
            --- host/mm/proc_mm.c	Wed Dec 31 19:00:00 1969
            +++ host-ptrace/mm/proc_mm.c	Mon Nov 11 19:07:52 2002
            @@ -0,0 +1,173 @@
            +/*=20
            + * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
            + * Licensed under the GPL
            + */
            +
            +#include "linux/proc_fs.h"
            +#include "linux/proc_mm.h"
            +#include "linux/file.h"
            +#include "asm/uaccess.h"
            +#include "asm/mmu_context.h"
            +
            +static struct file_operations proc_mm_fops;
            +
            +struct mm_struct *proc_mm_get_mm(int fd)
            +{
            +	struct mm_struct *ret =3D ERR_PTR(-EBADF);
            +	struct file *file;
            +
            +	file =3D fget(fd);
            +	if (!file)
            +		goto out;
            +
            +	ret =3D ERR_PTR(-EINVAL);
            +	if(file->f_op !=3D &proc_mm_fops)
            +		goto out_fput;
            +
            +	ret =3D file->private_data;
            +
            + out_fput:
            +	fput(file);
            + out:
            +	return(ret);
            +}
            +
            +extern long do_mmap2(struct mm_struct *mm, unsigned long addr,=
=20
            +		     unsigned long len, unsigned long prot,=20
            +		     unsigned long flags, unsigned long fd,
            +		     unsigned long pgoff);
            +
            +static ssize_t write_proc_mm(struct file *file, const char *bu=
ffer,
            +			     size_t count, loff_t *ppos)
            +{
            +	struct mm_struct *mm =3D file->private_data;
            +	struct proc_mm_op req;
            +	int n, ret;
            +
            +	if(count > sizeof(req))
            +		return(-EINVAL);
            +
            +	n =3D copy_from_user(&req, buffer, count);
            +	if(n !=3D 0)
            +		return(-EFAULT);
            +
            +	ret =3D count;
            +	switch(req.op){
            +	case MM_MMAP: {
            +		struct mm_mmap *map =3D &req.u.mmap;
            +
            +		ret =3D do_mmap2(mm, map->addr, map->len, map->prot,=20
            +			       map->flags, map->fd, map->offset >> PAGE_SHIFT);
            +		if((ret & ~PAGE_MASK) =3D=3D 0)
            +			ret =3D count;
            +=09
            +		break;
            +	}
            +	case MM_MUNMAP: {
            +		struct mm_munmap *unmap =3D &req.u.munmap;
            +
            +		down_write(&mm->mmap_sem);
            +		ret =3D do_munmap(mm, unmap->addr, unmap->len);
            +		up_write(&mm->mmap_sem);
            +
            +		if(ret =3D=3D 0)
            +			ret =3D count;
            +		break;
            +	}
            +	case MM_MPROTECT: {
            +		struct mm_mprotect *protect =3D &req.u.mprotect;
            +
            +		ret =3D do_mprotect(mm, protect->addr, protect->len,=20
            +				  protect->prot);
            +		if(ret =3D=3D 0)
            +			ret =3D count;
            +		break;
            +	}
            +
            +	case MM_COPY_SEGMENTS: {
            +		struct mm_struct *from =3D proc_mm_get_mm(req.u.copy_segment=
s);
            +
            +		if(IS_ERR(from)){
            +			ret =3D PTR_ERR(from);
            +			break;
            +		}
            +
            +		mm_copy_segments(from, mm);
            +		break;
            +	}
            +	default:
            +		ret =3D -EINVAL;
            +		break;
            +	}
            +
            +	return(ret);
            +}
            +
            +static int open_proc_mm(struct inode *inode, struct file *file=
)
            +{
            +	struct mm_struct *mm =3D mm_alloc();
            +	int ret;
            +
            +	ret =3D -ENOMEM;
            +	if(mm =3D=3D NULL)
            +		goto out_mem;
            +
            +	ret =3D init_new_context(current, mm);
            +	if(ret)
            +		goto out_free;
            +
            +	spin_lock(&mmlist_lock);
            +	list_add(&mm->mmlist, &current->mm->mmlist);
            +	mmlist_nr++;
            +	spin_unlock(&mmlist_lock);
            +
            +	file->private_data =3D mm;
            +
            +	return(0);
            +
            + out_free:
            +	mmput(mm);
            + out_mem:
            +	return(ret);
            +}
            +
            +static int release_proc_mm(struct inode *inode, struct file *f=
ile)
            +{
            +	struct mm_struct *mm =3D file->private_data;
            +
            +	mmput(mm);
            +	return(0);
            +}
            +
            +static struct file_operations proc_mm_fops =3D {
            +	.open		=3D open_proc_mm,
            +	.release	=3D release_proc_mm,
            +	.write		=3D write_proc_mm,
            +};
            +
            +static int make_proc_mm(void)
            +{
            +	struct proc_dir_entry *ent;
            +
            +	ent =3D create_proc_entry("mm", 0222, &proc_root);
            +	if(ent =3D=3D NULL){
            +		printk("make_proc_mm : Failed to register /proc/mm\n");
            +		return(0);
            +	}
            +	ent->proc_fops =3D &proc_mm_fops;
            +
            +	return(0);
            +}
            +
            +__initcall(make_proc_mm);
            +
            +/*
            + * Overrides for Emacs so that we follow Linus's tabbing style=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--=-M8qrggAvfCUMJZ+098hj--
