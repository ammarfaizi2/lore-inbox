Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135891AbRAYSpY>; Thu, 25 Jan 2001 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135907AbRAYSpN>; Thu, 25 Jan 2001 13:45:13 -0500
Received: from ashley.ivey.uwo.ca ([129.100.22.27]:61708 "EHLO
	ashley.ivey.uwo.ca") by vger.kernel.org with ESMTP
	id <S135891AbRAYSo4>; Thu, 25 Jan 2001 13:44:56 -0500
Message-Id: <200101251844.f0PIilH13457@ashley.ivey.uwo.ca>
Date: Thu, 25 Jan 2001 13:44:47 -0500
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
Content-Type: multipart/mixed;
	boundary=Apple-Mail-1413288812-1
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
Cc: jekacur@ca.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
To: khendricks@ivey.uwo.ca
X-Mailer: Apple Mail (2.337)
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v337)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1413288812-1
content-transfer-encoding: quoted-printable
content-type: text/plain;
	charset=us-ascii

Hi,

If it matters I am running some kernel fixes to enable RT signal =
handling properly.
A version of this patch was supposed to be included into the 2.4 series =
but I don't work with those kernels so I never checked to see if it was =
ever included.

I have attached the patch which should apply cleanly over stable 2.2 =
kernels just in case it helps.

By the way, this was not my patch it was contributed awhile ago by =
someone else.

The 2.3.XX version is out there someplace, perhaps someone remembers =
where.  I backported it to my stable kernel.

Hope this helps,

Kevin

--Apple-Mail-1413288812-1
content-disposition: attachment;
	filename=posix_stable.patch
content-type: application/octet-stream;
	x-unix-mode=0644;
	name=posix_stable.patch
content-transfer-encoding: quoted-printable

---=20arch/ppc/kernel/head.S.prev=09Wed=20Apr=2026=2010:38:24=202000=0A=
+++=20arch/ppc/kernel/head.S=09Wed=20Apr=2026=2011:02:18=202000=0A@@=20=
-23,6=20+23,10=20@@=0A=20=20*=20=20modify=20it=20under=20the=20terms=20=
of=20the=20GNU=20General=20Public=20License=0A=20=20*=20=20as=20=
published=20by=20the=20Free=20Software=20Foundation;=20either=20version=0A=
=20=20*=20=202=20of=20the=20License,=20or=20(at=20your=20option)=20any=20=
later=20version.=0A+=20*=0A+=20*=20=202000-04-10.=0A+=20*=20=20Add=20=
sys_rt_sigreturn=20in=20DoSyscall=20Handler.=0A+=20*=20=20Giovanna=20=
Ambrosini=20(ambrosini@lightning.ch).=0A=20=20*=09=0A=20=20*/=0A=20=0A@@=20=
-2169,6=20+2173,8=20@@=0A=20#endif=20/*=20SHOW_SYSCALLS=20*/=0A=20=09=
cmpi=090,r0,0x7777=09/*=20Special=20case=20for=20'sys_sigreturn'=20*/=0A=20=
=09beq-=0910f=0A+=20=20=20=20=20=20=20=20cmpi=20=20=20=200,r0,0x6666=20=20=
=20=20=20/*=20Special=20case=20for=20'sys_rt_sigreturn'=20*/=0A+=20=20=20=
=20=20=20=20=20beq-=20=20=20=2016f=0A=20=09lwz=09r10,TASK_FLAGS(r2)=0A=20=
=09andi.=09r10,r10,PF_TRACESYS=0A=20=09bne-=0950f=0A@@=20-2215,6=20=
+2221,12=20@@=0A=20/*=20sys_sigreturn=20*/=0A=2010:=09addi=09=
r3,r1,STACK_FRAME_OVERHEAD=0A=20=09bl=09sys_sigreturn=0A+=20=20=20=20=20=20=
=20=20cmpi=20=20=20=200,r3,0=20=20=20=20=20=20=20=20=20=20/*=20Check=20=
for=20restarted=20system=20call=20*/=0A+=20=20=20=20=20=20=20=20bge=20=20=
=20=20=20int_return=0A+=20=20=20=20=20=20=20=20b=20=20=20=20=20=20=2020b=0A=
+/*=20sys_rt_sigreturn=20*/=0A+16:=20=20=20=20=20addi=20=20=20=20=
r3,r1,STACK_FRAME_OVERHEAD=0A+=20=20=20=20=20=20=20=20bl=20=20=20=20=20=20=
sys_rt_sigreturn=0A=20=09cmpi=090,r3,0=09=09/*=20Check=20for=20restarted=20=
system=20call=20*/=0A=20=09bge=09int_return=0A=20=09b=0920b=0A---=20=
arch/ppc/kernel/signal.c.prev=09Wed=20Apr=2026=2010:38:39=202000=0A+++=20=
arch/ppc/kernel/signal.c=09Wed=20Apr=2026=2010:56:47=202000=0A@@=20-14,6=20=
+14,16=20@@=0A=20=20*=20=20modify=20it=20under=20the=20terms=20of=20the=20=
GNU=20General=20Public=20License=0A=20=20*=20=20as=20published=20by=20=
the=20Free=20Software=20Foundation;=20either=20version=0A=20=20*=20=202=20=
of=20the=20License,=20or=20(at=20your=20option)=20any=20later=20version.=0A=
+=20*=0A+=20*=0A+=20*=202000-04-7.=0A+=20*=20Define=20a=20real-time=20=
signal=20frame=20with=20siginfo=20and=20ucontext=0A+=20*=20structures=20=
(setup_rt_frame()).=0A+=20*=20Stuck=20up=20a=20real-time=20signal=20=
frame=20when=20setting=20the=20signal=0A+=20*=20frame=20with=20=
SA_SIGINFO=20flags.=0A+=20*=20Add=20sys_rt_sigreturn()=20to=20undo=20the=20=
signal=20stack.=0A+=20*=0A+=20*=20Giovanna=20Ambrosini=20=
(ambrosini@lightning.ch)=0A=20=20*/=0A=20=0A=20#include=20=
<linux/sched.h>=0A@@=20-121,13=20+131,6=20@@=0A=20}=0A=20=0A=20=0A=
-asmlinkage=20int=20sys_rt_sigreturn(unsigned=20long=20__unused)=0A-{=0A=
-=09printk("sys_rt_sigreturn():=20%s/%d=20not=20yet=20implemented.\n",=0A=
-=09=20=20=20=20=20=20=20current->comm,current->pid);=0A-=09=
do_exit(SIGSEGV);=0A-}=0A-=0A=20asmlinkage=20int=0A=20=
sys_sigaltstack(const=20stack_t=20*uss,=20stack_t=20*uoss)=0A=20{=0A@@=20=
-171,13=20+174,11=20@@=0A=20=20*=20When=20we=20have=20signals=20to=20=
deliver,=20we=20set=20up=20on=20the=0A=20=20*=20user=20stack,=20going=20=
down=20from=20the=20original=20stack=20pointer:=0A=20=20*=09a=20sigregs=20=
struct=0A-=20*=09one=20or=20more=20sigcontext=20structs=0A+=20*=20one=20=
or=20more=20sigcontext=20structs=20with=0A=20=20*=09a=20gap=20of=20=
__SIGNAL_FRAMESIZE=20bytes=0A=20=20*=0A=20=20*=20Each=20of=20these=20=
things=20must=20be=20a=20multiple=20of=2016=20bytes=20in=20size.=0A=20=20=
*=0A-=20*=20XXX=20ultimately=20we=20will=20have=20to=20stack=20up=20a=20=
siginfo=20and=20ucontext=0A-=20*=20for=20each=20rt=20signal.=0A=20=20*/=0A=
=20struct=20sigregs=20{=0A=20=09elf_gregset_t=09gp_regs;=0A@@=20-188,6=20=
+189,15=20@@=0A=20=09int=09=09abigap[56];=0A=20};=0A=20=0A+struct=20=
rt_sigframe=0A+{=0A+=20unsigned=20long=20_unused[2];=0A+=20struct=20=
siginfo=20*pinfo;=0A+=20void=20*puc;=0A+=20struct=20siginfo=20info;=0A+=20=
struct=20ucontext=20uc;=0A+};=0A+=0A=20/*=0A=20=20*=20Do=20a=20signal=20=
return;=20undo=20the=20signal=20stack.=0A=20=20*/=0A@@=20-259,6=20=
+269,91=20@@=0A=20=09do_exit(SIGSEGV);=0A=20}=09=0A=20=0A+=0A+/*=0A+=20*=20=
=20When=20we=20have=20rt=20signals=20to=20deliver,=20we=20set=20up=20on=20=
the=0A+=20*=20=20user=20stack,=20going=20down=20from=20the=20original=20=
stack=20pointer:=0A+=20*=20=20=20=20a=20sigregs=20struct=0A+=20*=20=20=20=
=20one=20rt_sigframe=20struct=20(siginfo=20+=20ucontext)=0A+=20*=20=20=20=
=20a=20gap=20of=20__SIGNAL_FRAMESIZE=20bytes=0A+=20*=0A+=20*=20=20Each=20=
of=20these=20things=20must=20be=20a=20multiple=20of=2016=20bytes=20in=20=
size.=0A+=20*=0A+=20*/=0A+asmlinkage=20int=20sys_rt_sigreturn(struct=20=
pt_regs=20*regs)=0A+{=0A+=20struct=20rt_sigframe=20*rt_sf;=0A+=20struct=20=
sigcontext_struct=20sigctx;=0A+=20struct=20sigregs=20*sr;=0A+=20int=20=
ret;=0A+=20elf_gregset_t=20saved_regs;=20=20/*=20an=20array=20of=20=
ELF_NGREG=20unsigned=20longs=20*/=0A+=20sigset_t=20set;=0A+=20stack_t=20=
st;=0A+=20unsigned=20long=20prevsp;=0A+=0A+=20rt_sf=20=3D=20(struct=20=
rt_sigframe=20*)(regs->gpr[1]=20+=20__SIGNAL_FRAMESIZE);=0A+=20if=20=
(copy_from_user(&sigctx,=20&rt_sf->uc.uc_mcontext,=20sizeof(sigctx))=0A+=20=
=20=20=20=20||=20copy_from_user(&set,=20&rt_sf->uc.uc_sigmask,=20=
sizeof(set))=0A+=20=20=20=20=20||=20copy_from_user(&st,=20=
&rt_sf->uc.uc_stack,=20sizeof(st)))=0A+=20=20goto=20badframe;=0A+=20=
sigdelsetmask(&set,=20~_BLOCKABLE);=0A+=20=
spin_lock_irq(&current->sigmask_lock);=0A+=20current->blocked=20=3D=20=
set;=0A+=20recalc_sigpending(current);=0A+=20=
spin_unlock_irq(&current->sigmask_lock);=0A+=0A+=20rt_sf++;=20=20=20/*=20=
Look=20at=20next=20rt_sigframe=20*/=0A+=20if=20(rt_sf=20=3D=3D=20(struct=20=
rt_sigframe=20*)(sigctx.regs))=20{=0A+=20=20/*=20Last=20stacked=20signal=20=
-=20restore=20registers=20-=0A+=20=20=20*=20sigctx=20is=20initialized=20=
to=20point=20to=20the=0A+=20=20=20*=20preamble=20frame=20(where=20=
registers=20are=20stored)=0A+=20=20=20*=20see=20handle_signal()=0A+=20=20=
=20*/=0A+=20=20sr=20=3D=20(struct=20sigregs=20*)=20sigctx.regs;=0A+=20=20=
if=20(regs->msr=20&=20MSR_FP=20)=0A+=20=20=20giveup_fpu(current);=0A+=20=20=
if=20(copy_from_user(saved_regs,=20&sr->gp_regs,=0A+=20=20=20=20=20=20=20=
sizeof(sr->gp_regs)))=0A+=20=20=20goto=20badframe;=0A+=20=20=
saved_regs[PT_MSR]=20=3D=20(regs->msr=20&=20~MSR_USERCHANGE)=0A+=20=20=20=
|=20(saved_regs[PT_MSR]=20&=20MSR_USERCHANGE);=0A+=20=20memcpy(regs,=20=
saved_regs,=20GP_REGS_SIZE);=0A+=20=20if=20=
(copy_from_user(current->tss.fpr,=20&sr->fp_regs,=0A+=20=20=20=20=20=20=20=
sizeof(sr->fp_regs)))=0A+=20=20=20goto=20badframe;=0A+=20=20/*=20This=20=
function=20sets=20back=20the=20stack=20flags=20into=0A+=20=20=20=20=20=
the=20current=20task=20structure.=20=20*/=0A+=20=20sys_sigaltstack(&st,=20=
NULL);=0A+=0A+=20=20ret=20=3D=20regs->result;=0A+=20}=20else=20{=0A+=20=20=
/*=20More=20signals=20to=20go=20*/=0A+=20=20/*=20Set=20up=20registers=20=
for=20next=20signal=20handler=20*/=0A+=20=20regs->gpr[1]=20=3D=20=
(unsigned=20long)rt_sf=20-=20__SIGNAL_FRAMESIZE;=0A+=20=20if=20=
(copy_from_user(&sigctx,=20&rt_sf->uc.uc_mcontext,=20sizeof(sigctx)))=0A=
+=20=20=20goto=20badframe;=0A+=20=20sr=20=3D=20(struct=20sigregs=20*)=20=
sigctx.regs;=0A+=20=20regs->gpr[3]=20=3D=20ret=20=3D=20sigctx.signal;=0A=
+=20=20/*=20Get=20the=20siginfo=20=20=20*/=0A+=20=20=
get_user(regs->gpr[4],=20(unsigned=20long=20*)&rt_sf->pinfo);=0A+=20=20=
/*=20Get=20the=20ucontext=20*/=0A+=20=20get_user(regs->gpr[5],=20=
(unsigned=20long=20*)&rt_sf->puc);=0A+=20=20regs->gpr[6]=20=3D=20=
(unsigned=20long)=20rt_sf;=0A+=0A+=20=20regs->link=20=3D=20(unsigned=20=
long)=20&sr->tramp;=0A+=20=20regs->nip=20=3D=20sigctx.handler;=0A+=20=20=
if=20(get_user(prevsp,=20&sr->gp_regs[PT_R1])=0A+=20=20=20=20=20=20||=20=
put_user(prevsp,=20(unsigned=20long=20*)=20regs->gpr[1]))=0A+=20=20=20=
goto=20badframe;=0A+=20}=0A+=20return=20ret;=0A+=0A+badframe:=0A+=20=
lock_kernel();=0A+=20do_exit(SIGSEGV);=0A+}=0A+=0A+=0A=20/*=0A=20=20*=20=
Set=20up=20a=20signal=20frame.=0A=20=20*/=0A@@=20-305,6=20+400,57=20@@=0A=
=20=09do_exit(SIGSEGV);=0A=20}=0A=20=0A+=0A+static=20void=0A=
+setup_rt_frame(struct=20pt_regs=20*regs,=20struct=20sigregs=20*frame,=0A=
+=20=20=20=20=20=20=20=20signed=20long=20newsp)=0A+{=0A+=20struct=20=
rt_sigframe=20*rt_sf=20=3D=20(struct=20rt_sigframe=20*)=20newsp;=0A+=0A+=20=
/*=20Set=20up=20preamble=20frame=20*/=0A+=20if=20=
(verify_area(VERIFY_WRITE,=20frame,=20sizeof(*frame)))=0A+=20=20goto=20=
badframe;=0A+=20if=20(regs->msr=20&=20MSR_FP)=0A+=20=20=
giveup_fpu(current);=0A+=20if=20(__copy_to_user(&frame->gp_regs,=20regs,=20=
GP_REGS_SIZE)=0A+=20=20=20=20=20||=20__copy_to_user(&frame->fp_regs,=20=
current->tss.fpr,=0A+=20=20=20=20=20=20=20=20=20ELF_NFPREG=20*=20=
sizeof(double))=0A+=20/*=20Set=20up=20to=20return=20from=20user=20space.=0A=
+=20=20=20=20It=20calls=20the=20sc=20exception=20at=20offset=200x9999=0A=
+=20=20=20=20for=20sys_rt_sigreturn().=0A+=20*/=0A+=20=20=20=20=20||=20=
__put_user(0x38006666UL,=20&frame->tramp[0])=20/*=20li=20r0,0x6666=20*/=0A=
+=20=20=20=20=20||=20__put_user(0x44000002UL,=20&frame->tramp[1]))=20/*=20=
sc=20*/=0A+=20=20goto=20badframe;=0A+=20flush_icache_range((unsigned=20=
long)=20&frame->tramp[0],=0A+=20=20=20=20=20=20(unsigned=20long)=20=
&frame->tramp[2]);=0A+=0A+=20/*=20Retrieve=20rt_sigframe=20from=20stack=20=
and=0A+=20=20=20=20set=20up=20registers=20for=20signal=20handler=0A+=20=
*/=0A+=20newsp=20-=3D=20__SIGNAL_FRAMESIZE;=0A+=20if=20=
(put_user(regs->gpr[1],=20(unsigned=20long=20*)newsp)=0A+=20=20=20=20=20=
||=20get_user(regs->nip,=20&rt_sf->uc.uc_mcontext.handler)=0A+=20=20=20=20=
=20||=20get_user(regs->gpr[3],=20&rt_sf->uc.uc_mcontext.signal)=0A+=20=20=
=20=20=20||=20get_user(regs->gpr[4],=20(unsigned=20long=20=
*)&rt_sf->pinfo)=0A+=20=20=20=20=20||=20get_user(regs->gpr[5],=20=
(unsigned=20long=20*)&rt_sf->puc))=0A+=20=20goto=20badframe;=0A+=0A+=20=
regs->gpr[1]=20=3D=20newsp;=0A+=20regs->gpr[6]=20=3D=20(unsigned=20long)=20=
rt_sf;=0A+=20regs->link=20=3D=20(unsigned=20long)=20frame->tramp;=0A+=0A=
+=20return;=0A+=0A+badframe:=0A+#if=20DEBUG_SIG=0A+=20printk("badframe=20=
in=20setup_rt_frame,=20regs=3D%p=20frame=3D%p=20newsp=3D%lx\n",=0A+=20=20=
=20=20=20=20=20=20regs,=20frame,=20newsp);=0A+#endif=0A+=20=
lock_kernel();=0A+=20do_exit(SIGSEGV);=0A+}=0A+=0A=20/*=0A=20=20*=20OK,=20=
we're=20invoking=20a=20handler=0A=20=20*/=0A@@=20-314,6=20+460,7=20@@=0A=20=
=09=20=20=20=20=20=20unsigned=20long=20*newspp,=20unsigned=20long=20=
frame)=0A=20{=0A=20=09struct=20sigcontext_struct=20*sc;=0A+=20struct=20=
rt_sigframe=20*rt_sf;=0A=20=0A=20=09if=20(regs->trap=20=3D=3D=200x0C00=20=
/*=20System=20Call!=20*/=0A=20=09=20=20=20=20&&=20((int)regs->result=20=
=3D=3D=20-ERESTARTNOHAND=20||=0A@@=20-321,20=20+468,47=20@@=0A=20=09=09=20=
!(ka->sa.sa_flags=20&=20SA_RESTART))))=0A=20=09=09regs->result=20=3D=20=
-EINTR;=0A=20=0A-=09/*=20Put=20another=20sigcontext=20on=20the=20stack=20=
*/=0A-=09*newspp=20-=3D=20sizeof(*sc);=0A-=09sc=20=3D=20(struct=20=
sigcontext_struct=20*)=20*newspp;=0A-=09if=20(verify_area(VERIFY_WRITE,=20=
sc,=20sizeof(*sc)))=0A-=09=09goto=20badframe;=0A+=20/*=20Set=20up=20=
Signal=20Frame=20*/=0A+=20if=20(ka->sa.sa_flags=20&=20SA_SIGINFO)=20{=0A=
+=20=20/*=20Put=20a=20Real=20Time=20Context=20onto=20stack=20*/=0A+=20=20=
*newspp=20-=3D=20sizeof(*rt_sf);=0A+=20=20rt_sf=20=3D=20(struct=20=
rt_sigframe=20*)=20*newspp;=0A+=20=20if=20(verify_area(VERIFY_WRITE,=20=
rt_sf,=20sizeof(*rt_sf)))=0A+=20=20=20goto=20badframe;=0A+=0A+=20=20if=20=
(__put_user((unsigned=20long)=20ka->sa.sa_handler,=20=
&rt_sf->uc.uc_mcontext.handler)=0A+=20=20=20=20=20=20||=20=
__put_user(&rt_sf->info,=20&rt_sf->pinfo)=0A+=20=20=20=20=20=20||=20=
__put_user(&rt_sf->uc,=20&rt_sf->puc)=0A+=20=20=20=20=20=20/*=20Put=20=
the=20siginfo=20*/=0A+=20=20=20=20=20=20||=20=
__copy_to_user(&rt_sf->info,=20info,=20sizeof(*info))=0A+=20=20=20=20=20=20=
/*=20Create=20the=20ucontext=20*/=0A+=20=20=20=20=20=20||=20=
__put_user(0,=20&rt_sf->uc.uc_flags)=0A+=20=20=20=20=20=20||=20=
__put_user(0,=20&rt_sf->uc.uc_link)=0A+=20=20=20=20=20=20||=20=
__put_user(current->sas_ss_sp,=20&rt_sf->uc.uc_stack.ss_sp)=0A+=20=20=20=20=
=20=20||=20__put_user(sas_ss_flags(regs->gpr[1]),=0A+=20=20=20=20=20=20=
&rt_sf->uc.uc_stack.ss_flags)=0A+=20=20=20=20=20=20||=20=
__put_user(current->sas_ss_size,=20&rt_sf->uc.uc_stack.ss_size)=0A+=20=20=
=20=20=20=20||=20__copy_to_user(&rt_sf->uc.uc_sigmask,=20oldset,=20=
sizeof(*oldset))=0A+=20=20=20=20=20=20/*=20mcontext.regs=20points=20to=20=
preamble=20register=20frame=20*/=0A+=20=20=20=20=20=20||=20=
__put_user((struct=20pt_regs=20*)frame,=20&rt_sf->uc.uc_mcontext.regs)=0A=
+=20=20=20=20=20=20||=20__put_user(sig,=20=
&rt_sf->uc.uc_mcontext.signal))=0A+=20=20=20goto=20badframe;=0A+=20}=20=
else=20{=0A+=20=20/*=20Put=20another=20sigcontext=20on=20the=20stack=20=
*/=0A+=20=20*newspp=20-=3D=20sizeof(*sc);=0A+=20=20sc=20=3D=20(struct=20=
sigcontext_struct=20*)=20*newspp;=0A+=20=20if=20=
(verify_area(VERIFY_WRITE,=20sc,=20sizeof(*sc)))=0A+=20=20=20goto=20=
badframe;=0A=20=0A-=09if=20(__put_user((unsigned=20long)=20=
ka->sa.sa_handler,=20&sc->handler)=0A-=09=20=20=20=20||=20=
__put_user(oldset->sig[0],=20&sc->oldmask)=0A+=20=20if=20=
(__put_user((unsigned=20long)=20ka->sa.sa_handler,=20&sc->handler)=0A+=20=
=20=20=20=20=20||=20__put_user(oldset->sig[0],=20&sc->oldmask)=0A=20#if=20=
_NSIG_WORDS=20>=201=0A-=09=20=20=20=20||=20__put_user(oldset->sig[1],=20=
&sc->_unused[3])=0A+=20=20=20=20=20=20||=20__put_user(oldset->sig[1],=20=
&sc->_unused[3])=0A=20#endif=0A-=09=20=20=20=20||=20__put_user((struct=20=
pt_regs=20*)frame,=20&sc->regs)=0A-=09=20=20=20=20||=20__put_user(sig,=20=
&sc->signal))=0A-=09=09goto=20badframe;=0A+=20=20=20=20=20=20||=20=
__put_user((struct=20pt_regs=20*)frame,=20&sc->regs)=0A+=20=20=20=20=20=20=
||=20__put_user(sig,=20&sc->signal))=0A+=20=20=20goto=20badframe;=0A+=20=
}=0A=20=0A=20=09if=20(ka->sa.sa_flags=20&=20SA_ONESHOT)=0A=20=09=09=
ka->sa.sa_handler=20=3D=20SIG_DFL;=0A@@=20-494,7=20+668,10=20@@=0A=20=09=
if=20(newsp=20=3D=3D=20frame)=0A=20=09=09return=200;=09=09/*=20no=20=
signals=20delivered=20*/=0A=20=0A-=09setup_frame(regs,=20(struct=20=
sigregs=20*)=20frame,=20newsp);=0A+=20if=20(ka->sa.sa_flags=20&=20=
SA_SIGINFO)=0A+=20=20setup_rt_frame(regs,=20(struct=20sigregs=20*)=20=
frame,=20newsp);=0A+=20else=0A+=20=20setup_frame(regs,=20(struct=20=
sigregs=20*)=20frame,=20newsp);=0A=20=09return=201;=0A=20=0A=20}=0A---=20=
include/asm-ppc/ucontext.h.prev=09Wed=20Apr=2026=2010:39:24=202000=0A+++=20=
include/asm-ppc/ucontext.h=09Wed=20Apr=2026=2010:39:36=202000=0A@@=20=
-7,6=20+7,7=20@@=0A=20=09unsigned=20long=09=20=20uc_flags;=0A=20=09=
struct=20ucontext=20=20*uc_link;=0A=20=09stack_t=09=09=20=20uc_stack;=0A=
+=20struct=20sigcontext_struct=20uc_mcontext;=0A=20=09sigset_t=09=20=20=
uc_sigmask;=09/*=20mask=20last=20for=20extensibility=20*/=0A=20};=0A=20=0A=

--Apple-Mail-1413288812-1
content-transfer-encoding: quoted-printable
content-type: text/plain;
	charset=us-ascii




On Thursday, January 25, 2001, at 01:10 PM, Kevin B. Hendricks wrote:

> =20
> Hi,=20
> =20
> Here is what I get from running it on my system (ppc linux with 2.2.15 =
kernel with some mods=20
> and glibc-2.1.3).=20
> =20
> But no segfault.=20
> =20
> Kevin=20
> =20
> =20
> [kbhend@localhost ~]$ gcc -O2 -ojunk junk.c=20
> [kbhend@localhost ~]$ ./junk=20
> SIGUSR1 =3D 10=20
> scp =3D 7fffe9a4=20
> scp->signal =3D 0=20
> [kbhend@localhost ~]$=20
> =20
> =20
> =20
> =20
> On Thursday, January 25, 2001, at 10:09 AM, jekacur@ca.ibm.com wrote:=20=

> =20
> > #include <stdio.h>=20
> > #include <signal.h>=20
> >=20
> > /* Function Prototypes */=20
> > void install_sigusr1_handler(void);=20
> > void sigusr_handler(int , siginfo_t *, struct sigcontext * scp);=20
> >=20
> > int main(void)=20
> > {=20
> >         install_sigusr1_handler();=20
> >         printf("SIGUSR1 =3D %d\n", SIGUSR1);=20
> >         raise(SIGUSR1);=20
> >         exit(0);=20
> > }=20
> >=20
> > void install_sigusr1_handler(void)=20
> > {=20
> >         struct sigaction newAct;=20
> >=20
> >         if (sigemptyset(&newAct.sa_mask) !=3D 0) {=20
> >                 fprintf(stderr, "Warning, sigemptyset failed.\n");=20=

> >         }=20
> >=20
> >         newAct.sa_flags =3D 0;=20
> >         newAct.sa_flags |=3D SA_SIGINFO | SA_RESTART;=20
> >=20
> >         newAct.sa_sigaction =3D (void=20
> > (*)(int,siginfo_t*,void*))sigusr_handler;=20
> >=20
> >         if (sigaction(SIGUSR1, &newAct, NULL) !=3D 0) {=20
> >                 fprintf(stderr, "Couldn't install SIGUSR1 =
handler.\n");=20
> >                 fprintf(stderr, "Exiting.\n");=20
> >                 exit(1);=20
> >         }=20
> > }=20
> >=20
> > void sigusr_handler(int signo, siginfo_t *siginfp, struct sigcontext =
* scp)=20
> > {=20
> >         printf("scp =3D %08x\n", scp);=20
> >         printf("scp->signal =3D %d\n", scp->signal);=20
> > }=20
> >=20
> >=20
> =20
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/=20=

> =20
> =20

--Apple-Mail-1413288812-1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
