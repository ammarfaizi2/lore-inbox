Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132198AbRAQEbW>; Tue, 16 Jan 2001 23:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131108AbRAQEbN>; Tue, 16 Jan 2001 23:31:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:4872 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130199AbRAQEbJ>; Tue, 16 Jan 2001 23:31:09 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: junio@siamese.dhis.twinsun.com
Date: Wed, 17 Jan 2001 14:21:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14949.4047.622440.985949@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 2.4.1-pre7 raid5syncd oops
In-Reply-To: message from junio@siamese.dhis.twinsun.com on  January 16
In-Reply-To: <7vzogr47qb.fsf@siamese.dhis.twinsun.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  January 16, junio@siamese.dhis.twinsun.com wrote:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000003
> c01ccf91
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c01ccf91>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010086
> eax: ffffffff   ebx: c1490400   ecx: cfdeb000   edx: cfeed13c
> esi: cfdeb000   edi: 00001e29   ebp: 00000013   esp: cfba7e80
> ds: 0018   es: 0018   ss: 0018
> Process raid5syncd (pid: 9, stackpage=cfba7000)
> Stack: c01ccfe0 cfdeb000 c1490400 00000000 c01cd430 c1490400 c1490400 0003c53c 
>        00001e29 00000013 00000000 00000000 cfba6000 00001000 00000000 00000000 
>        00000000 c1490400 c01cf2a8 c1490400 00078a78 00000000 00000000 cfba6000 
> Call Trace: [<c01ccfe0>] [<c01cd430>] [<c01cf2a8>] [<c01d708b>] [<c01cf40f>] [<c01d63cd>] [<c01074b8>] 
> Code: 89 50 04 8b 51 04 8b 01 89 02 c7 41 04 00 00 00 00 c3 8d b6 
> 
> >>EIP; c01ccf91 <remove_hash+11/30>   <=====
> Trace; c01ccfe0 <get_free_stripe+30/50>
....

This is really odd.
It looks like sh->hash_next == -1.
But, sh->hash_next is only ever set from
   ->hash_next for some other sh, by the line
		*sh->hash_pprev = sh->hash_next;
in remove_hash, or to an entry from the stripe_hashtbl array.
and stripe_hashtbl[] is only ever set to the address of a stripe_head,
or to the value of a sh->hash_next, or to zero at initialisation.

Or in short "this cannot happen" :-)

Is there any chance of a memory error?

Has this happened more than once?

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
