Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbRBOK5J>; Thu, 15 Feb 2001 05:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129577AbRBOK47>; Thu, 15 Feb 2001 05:56:59 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:48145 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S129480AbRBOK4p>; Thu, 15 Feb 2001 05:56:45 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF683961@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'Neil Brown'" <neilb@cse.unsw.edu.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andrew Morton'" <andrewm@uow.edu.au>
Subject: RE: NFSD die with 2.4.1 (resend with ksymoops)
Date: Thu, 15 Feb 2001 11:56:32 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0973D.F6945601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0973D.F6945601
Content-Type: text/plain;
	charset="iso-8859-1"


Here I am again! NFSD died at 11h23, ~12 hours after the last reboot, a
record :-)
I'll try to best answer your questions.

> This trace seems to make sense, except that nfssvc_encode_diropres
> doesn't seem to make any subroutine calls at offset 100 as seems to be
> implied. 
> 
> Could you run
> 
>  echo disassemble nfssvc_encode_diropres | gdb -batch -x 
> /dev/stdin vmlinux

It's in the attached file.
In fact, the Oops was with a new compiled kernel with NFSD in modules... So
the GDB stuff would not work...
So attached is the output of GDB recompiled with NFSD in the kernel. Is it
sufficient for you? It's not the one that was running but just recompiled.
If not, I'll send you a new Oops + GDB output of a RUNNING kernel with NFSD
in the kernel.

> giving it the vmlinux that was running when this oops was 
> produced? and
> also tell me exactly what patches you have ontop of 2.4.1 and where to
> find them.

I have only ACL patched. You can find them at acl.bestbits.at.
I have tried without them, with exactly the same behaviour.

Thanks
-jec


------_=_NextPart_000_01C0973D.F6945601
Content-Type: text/plain;
	name="out.gdb.nfsd.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="out.gdb.nfsd.txt"

Dump of assembler code for function nfssvc_encode_diropres:=0A=
0xc0173710 <nfssvc_encode_diropres>:	sub    $0x8,%esp=0A=
0xc0173713 <nfssvc_encode_diropres+3>:	push   %ebp=0A=
0xc0173714 <nfssvc_encode_diropres+4>:	push   %edi=0A=
0xc0173715 <nfssvc_encode_diropres+5>:	push   %esi=0A=
0xc0173716 <nfssvc_encode_diropres+6>:	push   %ebx=0A=
0xc0173717 <nfssvc_encode_diropres+7>:	mov    $0x8,%ecx=0A=
0xc017371c <nfssvc_encode_diropres+12>:	mov    0x20(%esp,1),%ebx=0A=
0xc0173720 <nfssvc_encode_diropres+16>:	mov    0x24(%esp,1),%eax=0A=
0xc0173724 <nfssvc_encode_diropres+20>:	lea    0x4(%eax),%esi=0A=
0xc0173727 <nfssvc_encode_diropres+23>:	mov    %ebx,%edi=0A=
0xc0173729 <nfssvc_encode_diropres+25>:	repz movsl =
%ds:(%esi),%es:(%edi)=0A=
0xc017372b <nfssvc_encode_diropres+27>:	add    $0x20,%ebx=0A=
0xc017372e <nfssvc_encode_diropres+30>:	mov    %ebx,%ebp=0A=
0xc0173730 <nfssvc_encode_diropres+32>:	test   %ebp,%ebp=0A=
0xc0173732 <nfssvc_encode_diropres+34>:	je     0xc01738bb =
<nfssvc_encode_diropres+427>=0A=
0xc0173738 <nfssvc_encode_diropres+40>:	mov    0x44(%eax),%eax=0A=
0xc017373b <nfssvc_encode_diropres+43>:	mov    0x8(%eax),%eax=0A=
0xc017373e <nfssvc_encode_diropres+46>:	mov    %eax,0x10(%esp,1)=0A=
0xc0173742 <nfssvc_encode_diropres+50>:	mov    0x10(%esp,1),%ecx=0A=
0xc0173746 <nfssvc_encode_diropres+54>:	movzwl 0x2a(%eax),%eax=0A=
0xc017374a <nfssvc_encode_diropres+58>:	mov    %ax,0x16(%esp,1)=0A=
0xc017374f <nfssvc_encode_diropres+63>:	mov    0x8c(%ecx),%eax=0A=
0xc0173755 <nfssvc_encode_diropres+69>:	test   %eax,%eax=0A=
0xc0173757 <nfssvc_encode_diropres+71>:	je     0xc017379f =
<nfssvc_encode_diropres+143>=0A=
0xc0173759 <nfssvc_encode_diropres+73>:	testb  $0x4,0x24(%eax)=0A=
0xc017375d <nfssvc_encode_diropres+77>:	je     0xc017379f =
<nfssvc_encode_diropres+143>=0A=
0xc017375f <nfssvc_encode_diropres+79>:	mov    0x84(%ecx),%eax=0A=
0xc0173765 <nfssvc_encode_diropres+85>:	test   %eax,%eax=0A=
0xc0173767 <nfssvc_encode_diropres+87>:	je     0xc017379f =
<nfssvc_encode_diropres+143>=0A=
0xc0173769 <nfssvc_encode_diropres+89>:	push   $0x8000=0A=
0xc017376e <nfssvc_encode_diropres+94>:	push   %ecx=0A=
0xc017376f <nfssvc_encode_diropres+95>:	mov    0x48(%eax),%eax=0A=
0xc0173772 <nfssvc_encode_diropres+98>:	call   *%eax=0A=
0xc0173774 <nfssvc_encode_diropres+100>:	mov    %eax,%ebx=0A=
0xc0173776 <nfssvc_encode_diropres+102>:	add    $0x8,%esp=0A=
0xc0173779 <nfssvc_encode_diropres+105>:	cmp    $0xfffffc18,%ebx=0A=
0xc017377f <nfssvc_encode_diropres+111>:	ja     0xc01737a6 =
<nfssvc_encode_diropres+150>=0A=
0xc0173781 <nfssvc_encode_diropres+113>:	test   %ebx,%ebx=0A=
0xc0173783 <nfssvc_encode_diropres+115>:	je     0xc017379f =
<nfssvc_encode_diropres+143>=0A=
0xc0173785 <nfssvc_encode_diropres+117>:	lea    0x16(%esp,1),%eax=0A=
0xc0173789 <nfssvc_encode_diropres+121>:	push   %eax=0A=
0xc017378a <nfssvc_encode_diropres+122>:	push   %ebx=0A=
0xc017378b <nfssvc_encode_diropres+123>:	call   0xc01498e4 =
<posix_acl_masq_nfs_v2_mode>=0A=
0xc0173790 <nfssvc_encode_diropres+128>:	mov    %eax,%esi=0A=
0xc0173792 <nfssvc_encode_diropres+130>:	push   %ebx=0A=
0xc0173793 <nfssvc_encode_diropres+131>:	call   0xc0149474 =
<posix_acl_release>=0A=
0xc0173798 <nfssvc_encode_diropres+136>:	add    $0xc,%esp=0A=
0xc017379b <nfssvc_encode_diropres+139>:	test   %esi,%esi=0A=
0xc017379d <nfssvc_encode_diropres+141>:	jne    0xc01737a6 =
<nfssvc_encode_diropres+150>=0A=
0xc017379f <nfssvc_encode_diropres+143>:	cmpl   $0x0,0x10(%esp,1)=0A=
0xc01737a4 <nfssvc_encode_diropres+148>:	jne    0xc01737b0 =
<nfssvc_encode_diropres+160>=0A=
0xc01737a6 <nfssvc_encode_diropres+150>:	xor    %edx,%edx=0A=
0xc01737a8 <nfssvc_encode_diropres+152>:	jmp    0xc01738bb =
<nfssvc_encode_diropres+427>=0A=
0xc01737ad <nfssvc_encode_diropres+157>:	lea    0x0(%esi),%esi=0A=
0xc01737b0 <nfssvc_encode_diropres+160>:	mov    0x10(%esp,1),%edi=0A=
0xc01737b4 <nfssvc_encode_diropres+164>:	movzwl 0x2a(%edi),%eax=0A=
0xc01737b8 <nfssvc_encode_diropres+168>:	shr    $0xc,%ax=0A=
0xc01737bc <nfssvc_encode_diropres+172>:	and    $0xffff,%eax=0A=
0xc01737c1 <nfssvc_encode_diropres+177>:	lea    0x14(%ebp),%esi=0A=
0xc01737c4 <nfssvc_encode_diropres+180>:	mov    =
0xc02de3f8(,%eax,4),%eax=0A=
0xc01737cb <nfssvc_encode_diropres+187>:	bswap  %eax=0A=
0xc01737cd <nfssvc_encode_diropres+189>:	mov    %eax,0x0(%ebp)=0A=
0xc01737d0 <nfssvc_encode_diropres+192>:	movzwl 0x16(%esp,1),%eax=0A=
0xc01737d5 <nfssvc_encode_diropres+197>:	bswap  %eax=0A=
0xc01737d7 <nfssvc_encode_diropres+199>:	mov    %eax,0x4(%ebp)=0A=
0xc01737da <nfssvc_encode_diropres+202>:	movzwl 0x2c(%edi),%eax=0A=
0xc01737de <nfssvc_encode_diropres+206>:	bswap  %eax=0A=
0xc01737e0 <nfssvc_encode_diropres+208>:	mov    %eax,0x8(%ebp)=0A=
0xc01737e3 <nfssvc_encode_diropres+211>:	mov    0x30(%edi),%ecx=0A=
0xc01737e6 <nfssvc_encode_diropres+214>:	bswap  %ecx=0A=
0xc01737e8 <nfssvc_encode_diropres+216>:	mov    %ecx,0xc(%ebp)=0A=
0xc01737eb <nfssvc_encode_diropres+219>:	mov    0x34(%edi),%ecx=0A=
0xc01737ee <nfssvc_encode_diropres+222>:	bswap  %ecx=0A=
0xc01737f0 <nfssvc_encode_diropres+224>:	mov    %ecx,0x10(%ebp)=0A=
0xc01737f3 <nfssvc_encode_diropres+227>:	movzwl 0x2a(%edi),%eax=0A=
0xc01737f7 <nfssvc_encode_diropres+231>:	and    $0xfffff000,%eax=0A=
0xc01737fc <nfssvc_encode_diropres+236>:	cmp    $0xa000,%ax=0A=
0xc0173800 <nfssvc_encode_diropres+240>:	jne    0xc0173820 =
<nfssvc_encode_diropres+272>=0A=
0xc0173802 <nfssvc_encode_diropres+242>:	mov    0x40(%edi),%eax=0A=
0xc0173805 <nfssvc_encode_diropres+245>:	test   %eax,%eax=0A=
0xc0173807 <nfssvc_encode_diropres+247>:	jg     0xc0173814 =
<nfssvc_encode_diropres+260>=0A=
0xc0173809 <nfssvc_encode_diropres+249>:	jne    0xc0173820 =
<nfssvc_encode_diropres+272>=0A=
0xc017380b <nfssvc_encode_diropres+251>:	cmpl   $0x400,0x3c(%edi)=0A=
0xc0173812 <nfssvc_encode_diropres+258>:	jbe    0xc0173820 =
<nfssvc_encode_diropres+272>=0A=
0xc0173814 <nfssvc_encode_diropres+260>:	lea    0x18(%ebp),%esi=0A=
0xc0173817 <nfssvc_encode_diropres+263>:	movl   $0x40000,0x14(%ebp)=0A=
0xc017381e <nfssvc_encode_diropres+270>:	jmp    0xc0173830 =
<nfssvc_encode_diropres+288>=0A=
0xc0173820 <nfssvc_encode_diropres+272>:	mov    %esi,%eax=0A=
0xc0173822 <nfssvc_encode_diropres+274>:	mov    0x10(%esp,1),%edi=0A=
0xc0173826 <nfssvc_encode_diropres+278>:	add    $0x4,%esi=0A=
0xc0173829 <nfssvc_encode_diropres+281>:	mov    0x3c(%edi),%ecx=0A=
0xc017382c <nfssvc_encode_diropres+284>:	bswap  %ecx=0A=
0xc017382e <nfssvc_encode_diropres+286>:	mov    %ecx,(%eax)=0A=
0xc0173830 <nfssvc_encode_diropres+288>:	mov    %esi,%eax=0A=
0xc0173832 <nfssvc_encode_diropres+290>:	add    $0x4,%esi=0A=
0xc0173835 <nfssvc_encode_diropres+293>:	mov    0x10(%esp,1),%edi=0A=
0xc0173839 <nfssvc_encode_diropres+297>:	mov    %esi,%edx=0A=
0xc017383b <nfssvc_encode_diropres+299>:	add    $0x4,%esi=0A=
0xc017383e <nfssvc_encode_diropres+302>:	mov    0x50(%edi),%ecx=0A=
0xc0173841 <nfssvc_encode_diropres+305>:	bswap  %ecx=0A=
0xc0173843 <nfssvc_encode_diropres+307>:	mov    %ecx,(%eax)=0A=
0xc0173845 <nfssvc_encode_diropres+309>:	movzwl 0x38(%edi),%eax=0A=
0xc0173849 <nfssvc_encode_diropres+313>:	bswap  %eax=0A=
0xc017384b <nfssvc_encode_diropres+315>:	mov    %eax,(%edx)=0A=
0xc017384d <nfssvc_encode_diropres+317>:	mov    %esi,%eax=0A=
0xc017384f <nfssvc_encode_diropres+319>:	add    $0x4,%esi=0A=
0xc0173852 <nfssvc_encode_diropres+322>:	mov    0x54(%edi),%ecx=0A=
0xc0173855 <nfssvc_encode_diropres+325>:	bswap  %ecx=0A=
0xc0173857 <nfssvc_encode_diropres+327>:	mov    %ecx,(%eax)=0A=
0xc0173859 <nfssvc_encode_diropres+329>:	mov    %esi,%edx=0A=
0xc017385b <nfssvc_encode_diropres+331>:	add    $0x4,%esi=0A=
0xc017385e <nfssvc_encode_diropres+334>:	movzwl 0x28(%edi),%eax=0A=
0xc0173862 <nfssvc_encode_diropres+338>:	bswap  %eax=0A=
0xc0173864 <nfssvc_encode_diropres+340>:	mov    %eax,(%edx)=0A=
0xc0173866 <nfssvc_encode_diropres+342>:	mov    %esi,%eax=0A=
0xc0173868 <nfssvc_encode_diropres+344>:	add    $0x4,%esi=0A=
0xc017386b <nfssvc_encode_diropres+347>:	mov    0x20(%edi),%ecx=0A=
0xc017386e <nfssvc_encode_diropres+350>:	bswap  %ecx=0A=
0xc0173870 <nfssvc_encode_diropres+352>:	mov    %ecx,(%eax)=0A=
0xc0173872 <nfssvc_encode_diropres+354>:	mov    %esi,%eax=0A=
0xc0173874 <nfssvc_encode_diropres+356>:	add    $0x4,%esi=0A=
0xc0173877 <nfssvc_encode_diropres+359>:	mov    0x44(%edi),%ecx=0A=
0xc017387a <nfssvc_encode_diropres+362>:	bswap  %ecx=0A=
0xc017387c <nfssvc_encode_diropres+364>:	mov    %ecx,(%eax)=0A=
0xc017387e <nfssvc_encode_diropres+366>:	movl   $0x0,(%esi)=0A=
0xc0173884 <nfssvc_encode_diropres+372>:	add    $0x4,%esi=0A=
0xc0173887 <nfssvc_encode_diropres+375>:	mov    %esi,%ebx=0A=
0xc0173889 <nfssvc_encode_diropres+377>:	add    $0x4,%esi=0A=
0xc017388c <nfssvc_encode_diropres+380>:	push   %edi=0A=
0xc017388d <nfssvc_encode_diropres+381>:	call   0xc0140a2c =
<lease_get_mtime>=0A=
0xc0173892 <nfssvc_encode_diropres+386>:	add    $0x4,%esp=0A=
0xc0173895 <nfssvc_encode_diropres+389>:	bswap  %eax=0A=
0xc0173897 <nfssvc_encode_diropres+391>:	mov    %eax,(%ebx)=0A=
0xc0173899 <nfssvc_encode_diropres+393>:	movl   $0x0,(%esi)=0A=
0xc017389f <nfssvc_encode_diropres+399>:	add    $0x4,%esi=0A=
0xc01738a2 <nfssvc_encode_diropres+402>:	mov    %esi,%eax=0A=
0xc01738a4 <nfssvc_encode_diropres+404>:	add    $0x4,%esi=0A=
0xc01738a7 <nfssvc_encode_diropres+407>:	mov    0x4c(%edi),%ecx=0A=
0xc01738aa <nfssvc_encode_diropres+410>:	bswap  %ecx=0A=
0xc01738ac <nfssvc_encode_diropres+412>:	mov    %ecx,(%eax)=0A=
0xc01738ae <nfssvc_encode_diropres+414>:	movl   $0x0,(%esi)=0A=
0xc01738b4 <nfssvc_encode_diropres+420>:	lea    0x4(%esi),%edx=0A=
0xc01738b7 <nfssvc_encode_diropres+423>:	test   %edx,%edx=0A=
0xc01738b9 <nfssvc_encode_diropres+425>:	jne    0xc01738c0 =
<nfssvc_encode_diropres+432>=0A=
0xc01738bb <nfssvc_encode_diropres+427>:	xor    %eax,%eax=0A=
0xc01738bd <nfssvc_encode_diropres+429>:	jmp    0xc017390e =
<nfssvc_encode_diropres+510>=0A=
0xc01738bf <nfssvc_encode_diropres+431>:	nop    =0A=
0xc01738c0 <nfssvc_encode_diropres+432>:	mov    0x1c(%esp,1),%edi=0A=
0xc01738c4 <nfssvc_encode_diropres+436>:	mov    %edx,%eax=0A=
0xc01738c6 <nfssvc_encode_diropres+438>:	mov    0x13c(%edi),%ebx=0A=
0xc01738cc <nfssvc_encode_diropres+444>:	sub    %ebx,%eax=0A=
0xc01738ce <nfssvc_encode_diropres+446>:	sar    $0x2,%eax=0A=
0xc01738d1 <nfssvc_encode_diropres+449>:	mov    %eax,0x148(%edi)=0A=
0xc01738d7 <nfssvc_encode_diropres+455>:	testb  $0x1,0xc0367d21=0A=
0xc01738de <nfssvc_encode_diropres+462>:	je     0xc01738f6 =
<nfssvc_encode_diropres+486>=0A=
0xc01738e0 <nfssvc_encode_diropres+464>:	mov    0x140(%edi),%eax=0A=
0xc01738e6 <nfssvc_encode_diropres+470>:	push   %eax=0A=
0xc01738e7 <nfssvc_encode_diropres+471>:	push   %ebx=0A=
0xc01738e8 <nfssvc_encode_diropres+472>:	push   %edx=0A=
0xc01738e9 <nfssvc_encode_diropres+473>:	push   $0xc02874a0=0A=
0xc01738ee <nfssvc_encode_diropres+478>:	call   0xc011567c <printk>=0A=
0xc01738f3 <nfssvc_encode_diropres+483>:	add    $0x10,%esp=0A=
0xc01738f6 <nfssvc_encode_diropres+486>:	mov    0x1c(%esp,1),%ecx=0A=
0xc01738fa <nfssvc_encode_diropres+490>:	mov    0x140(%ecx),%eax=0A=
0xc0173900 <nfssvc_encode_diropres+496>:	cmp    %eax,0x148(%ecx)=0A=
0xc0173906 <nfssvc_encode_diropres+502>:	setle  %al=0A=
0xc0173909 <nfssvc_encode_diropres+505>:	and    $0xff,%eax=0A=
0xc017390e <nfssvc_encode_diropres+510>:	pop    %ebx=0A=
0xc017390f <nfssvc_encode_diropres+511>:	pop    %esi=0A=
0xc0173910 <nfssvc_encode_diropres+512>:	pop    %edi=0A=
0xc0173911 <nfssvc_encode_diropres+513>:	pop    %ebp=0A=
0xc0173912 <nfssvc_encode_diropres+514>:	pop    %ecx=0A=
0xc0173913 <nfssvc_encode_diropres+515>:	pop    %edx=0A=
0xc0173914 <nfssvc_encode_diropres+516>:	ret    =0A=
0xc0173915 <nfssvc_encode_diropres+517>:	lea    0x0(%esi),%esi=0A=
End of assembler dump.=0A=

------_=_NextPart_000_01C0973D.F6945601--
