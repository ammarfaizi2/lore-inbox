Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbREWCkV>; Tue, 22 May 2001 22:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbREWCkL>; Tue, 22 May 2001 22:40:11 -0400
Received: from mail.ajato.com.br ([200.212.26.130]:7413 "HELO
	mail.ajato.com.br") by vger.kernel.org with SMTP id <S262955AbREWCkC>;
	Tue, 22 May 2001 22:40:02 -0400
Date: Tue, 22 May 2001 23:39:47 -0300
From: Carlos Laviola <claviola@ajato.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Weird bug in kernel (invalid operand?)
Message-Id: <20010522233947.4426a82d.claviola@ajato.com.br>
In-Reply-To: <3B0A611F.B0A554AA@uow.edu.au>
In-Reply-To: <20010521171108.2fe854ab.claviola@ajato.com.br>
	<3B0A611F.B0A554AA@uow.edu.au>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001 22:52:47 +1000, Andrew Morton <andrewm@uow.edu.au> wrote:

> Carlos Laviola wrote:
> > 
> > invalid operand: 0000
[ ... oops here ... ]
> > Segmentation fault
> > 
> > This seems to be a bug in the kernel, maybe because the file is too big,
> > and VFAT partitions don't like that.
> 
> It used to be that fatfs would hit the second BUG() in fat_get_block()
> when a file reaches two gig.  But I can't make that happen in testing,
> because the s_maxbytes stuff restricts it to 2gig-1.  What you *should*
> have seen was `wget' locking up because of a different bug :)
> 
> Are you sure you got this with 2.4.4?  If so, please run the
> output through
> 
> 	ksymoops -m System.map < oops-text

Well, in fact, I was using 2.4.5-pre1 when I had this problem. However, since
it doesn't seem like anything within the VFAT subsystem has changed from 2.4.4
to 2.4.5-pre1, 2.4.4 is probably buggy too. The relevant output from ksymoops
is below.

>>EIP; c48fb709 <[fat]fat_get_block+5d/dc>   <=====
Code;  c48fb709 <[fat]fat_get_block+5d/dc>
00000000 <_EIP>:
Code;  c48fb709 <[fat]fat_get_block+5d/dc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c48fb70b <[fat]fat_get_block+5f/dc>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c48fb70e <[fat]fat_get_block+62/dc>
   5:   b8 fb ff ff ff            mov    $0xfffffffb,%eax
Code;  c48fb713 <[fat]fat_get_block+67/dc>
   a:   eb 6d                     jmp    79 <_EIP+0x79> c48fb782 <[fat]fat_get_block+d6/dc>
Code;  c48fb715 <[fat]fat_get_block+69/dc>
   c:   8b 87 8c 00 00 00         mov    0x8c(%edi),%eax
Code;  c48fb71b <[fat]fat_get_block+6f/dc>
  12:   0f b7 00                  movzwl (%eax),%eax

Thanks,
Carlos.

-- 
 _ _  _| _  _  | _   . _ | _  carlos.debian.net   Debian-BR Project
(_(_|| |(_)_)  |(_|\/|(_)|(_| uin#: 981913 (icq)  debian-br.sf.net

Linux: the choice of a GNU generation - Registered Linux User #103594
Shah, shah!  Ayatollah you so!
