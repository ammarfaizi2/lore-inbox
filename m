Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130307AbQKTTsM>; Mon, 20 Nov 2000 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbQKTTsD>; Mon, 20 Nov 2000 14:48:03 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:17418 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S130307AbQKTTrq>; Mon, 20 Nov 2000 14:47:46 -0500
Date: Mon, 20 Nov 2000 19:17:57 GMT
Message-Id: <200011201917.TAA52799@tepid.osl.fast.no>
Subject: Re: [Linux-IrDA]IrDA broken on pre-5/6 and stock 2.4.0-test11
X-Mailer: Pygmy (v0.4.4)
In-Reply-To: %s: <Pine.LNX.4.30.0011201653050.6790-100000@core>
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: linux-irda@PASTA.cs.uit.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I also get this kernel panic with the latest kernel (test11-pre5/6) 
but I didn't get  it with any earlier kernels. I don't think this has anything to do
with Linux-IrDA but maybe I'm wrong.

-- Dag

On Mon, 20 Nov 2000 16:57:30 +0400 (GMT-4), you wrote:
> Guys,
> 
> can someone confirm the following. I can reliably get my
> kernel to panic if i kill irattach. I use SIR mode on my
> laptop. Looks like lack of NULL checking in the kernel
> code, but someone please try it out.  Don't worry the
> panic is not fatal - i.e. it won't crash your machine or
> at least it doesn't mine..
> 
> So just a
> 	kill <PID of irattach>
> will kernel core. Look in your 'dmesg' output.
> 
> Thanx
> Mitch
> 
> Here is my traceback
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
> c011578c
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c011578c>]
> EFLAGS: 00210246
> eax: c2124a64   ebx: c1414000   ecx: c35c01e0   edx: 00000000
> esi: 00000006   edi: 00000000   ebp: c3fcb3a0   esp: c1415fb8
> ds: 0018   es: 0018   ss: 0018
> Process irattach (pid: 5497, stackpage=c1415000)
> Stack: 00000100 c357bdc0 c357bdf0 c3498000 c35c01e0 c3fcb3a0 c3f9ca40 c3f9ca40
>        c3f9ca40 c3f9ca40 c0115a80 c025c620 c357be80 c357be6c c0108914 c357bdf0
>        00000078 c357be80
> Call Trace: [<c0115a80>] [<c0108914>]
> Code: 8b 4f 08 39 ca 7d 22 8b 47 14 83 3c 90 00 74 14 89 f0 89 d3
> Warning: trailing garbage ignored on Code: line
>   Text: 'Code: 8b 4f 08 39 ca 7d 22 8b 47 14 83 3c 90 00 74 14 89 f0 89 d3 '
>   Garbage: ' '
> 
> >>EIP: c011578c <exec_usermodehelper+29c/368>
> Trace: c0115a80 <exec_helper+14/18>
> Trace: c0108914 <kernel_thread+28/38>
> Code:  c011578c <exec_usermodehelper+29c/368>  00000000 <_EIP>: <===
> Code:  c011578c <exec_usermodehelper+29c/368>     0:    8b 4f 08               mov    0x8(%edi),%ecx <===
> Code:  c011578f <exec_usermodehelper+29f/368>     3:    39 ca                  cmp    %ecx,%edx
> Code:  c0115791 <exec_usermodehelper+2a1/368>     5:    7d 22                  jge     c01157b5 <exec_usermodehelper+2c5/368>
> Code:  c0115793 <exec_usermodehelper+2a3/368>     7:    8b 47 14               mov    0x14(%edi),%eax
> Code:  c0115796 <exec_usermodehelper+2a6/368>     a:    83 3c 90 00            cmpl   $0x0,(%eax,%edx,4)
> Code:  c011579a <exec_usermodehelper+2aa/368>     e:    74 14                  je      c01157b0 <exec_usermodehelper+2c0/368>
> Code:  c011579c <exec_usermodehelper+2ac/368>    10:    89 f0                  mov    %esi,%eax
> Code:  c011579e <exec_usermodehelper+2ae/368>    12:    89 d3                  mov    %edx,%ebx
> 
> _______________________________________________
> Linux-IrDA mailing list  -  Linux-IrDA@pasta.cs.UiT.No
> http://www.pasta.cs.UiT.No/mailman/listinfo/linux-irda
> 
> 
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
