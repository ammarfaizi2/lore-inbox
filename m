Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbREVM5q>; Tue, 22 May 2001 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbREVM5g>; Tue, 22 May 2001 08:57:36 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:44521 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261517AbREVM5Z>; Tue, 22 May 2001 08:57:25 -0400
Message-ID: <3B0A611F.B0A554AA@uow.edu.au>
Date: Tue, 22 May 2001 22:52:47 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carlos Laviola <claviola@ajato.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird bug in kernel (invalid operand?)
In-Reply-To: <20010521171108.2fe854ab.claviola@ajato.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Laviola wrote:
> 
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c48fb709>]
> EFLAGS: 00010282
> eax: 00000019   ebx: 00000000   ecx: c1272000   edx: c3f7bc20
> esi: 00206c60   edi: c3ca5240   ebp: c0695aa0   esp: c1273e68
> ds: 0018   es: 0018   ss: 0018
> Process snarf (pid: 324, stackpage=c1273000)
> Stack: c48fe965 c48fea27 00000045 000001f0 00000200 00040d8c c1273ec0 c012cf56
>        c3ca5240 00206c60 c0695aa0 00000001 000001f0 c1273f64 00040d8c 000002e5
>        c0605000 c0695aa0 00000200 00206c60 00000000 c0695aa0 0000004b 0000004b
> Call Trace: [<c48fe965>] [<c48fea27>] [<c012cf56>] [<c012d553>] [<c48fb6ac>] [<c48fcf1c>] [<c48fb6ac>]
>        [<c012179a>] [<c48fb7d2>] [<c48fb7b0>] [<c012ac5a>] [<c0106a63>]
> 
> Code: 0f 0b 83 c4 0c b8 fb ff ff ff eb 6d 8b 87 8c 00 00 00 0f b7
> Segmentation fault
> 
> This seems to be a bug in the kernel, maybe because the file is too big,
> and VFAT partitions don't like that.

It used to be that fatfs would hit the second BUG() in fat_get_block()
when a file reaches two gig.  But I can't make that happen in testing,
because the s_maxbytes stuff restricts it to 2gig-1.  What you *should*
have seen was `wget' locking up because of a different bug :)

Are you sure you got this with 2.4.4?  If so, please run the
output through

	ksymoops -m System.map < oops-text
