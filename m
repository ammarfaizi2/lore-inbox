Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317748AbSFLRkB>; Wed, 12 Jun 2002 13:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317749AbSFLRj7>; Wed, 12 Jun 2002 13:39:59 -0400
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:19437 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S317748AbSFLRj6>; Wed, 12 Jun 2002 13:39:58 -0400
Date: Wed, 12 Jun 2002 10:39:49 -0700
From: Brad Heilbrun <bheilbrun@paypal.com>
To: Martin Dalecki <dalecki@evision-ventures.com>, torvalds@transmeta.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 87
Message-ID: <20020612173949.GA1539@paypal.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	torvalds@transmeta.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D05AACD.2080504@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 09:46:21AM +0200, Martin Dalecki wrote:

> -		char *buffer;
> -		int nsect = rq->current_nr_sectors;
> -		unsigned long flags;
> +			/*
> +			 * Ok, we're all setup for the interrupt re-entering us on the
> +			 * last transfer.
> +			 */
> +			ata_write(drive, buf, nsect * SECTOR_WORDS);
> +			bio_kunmap_irq(buffer, &flags);

The above is an excerpt from the diff on ide_disk.c: task_mulout_intr()

The first and last line conflict. You remove 'char *buffer' then try to
pass it to bio_kunmap_irq(). I think it should be passing 'char
*buf' instead.

BK patch below.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.457, 2002-06-12 10:25:57-07:00, bheilbrun@paypal.com
  The IDE 87 patch removed char *buffer from task_mulout_intr() then added
  a line which passes it as an argument to bio_kunmap_irq(). It should be
  passing char *buf instead. Fixed.


 ide-disk.c |    2 +-
 1 files changed, 1 insertion, 1 deletion


diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed Jun 12 10:28:07 2002
+++ b/drivers/ide/ide-disk.c	Wed Jun 12 10:28:07 2002
@@ -327,7 +327,7 @@
 			 * last transfer.
 			 */
 			ata_write(drive, buf, nsect * SECTOR_WORDS);
-			bio_kunmap_irq(buffer, &flags);
+			bio_kunmap_irq(buf, &flags);
 		} while (mcount);
 
 		rq->errors = 0;

===================================================================


This BitKeeper patch contains the following changesets:
1.457
## Wrapped with gzip_uu ##


begin 664 bkpatch2009
M'XL(`*>$!ST``[64;6_3,!#'7\>?XJ1):`.2^)+8Z8**!MN`"22FP5Y73NPV
M5O-0;*?;I'QXW$Y:T1B,QSS(T>GR]__N?O(>7%IEBJ"LE6Y*,W1D#][UUA7!
M2MRL1!-5?>M#%WWO0_%@3=STE6AB:ZJXT=UP'281(S[C7+BJAK4RM@@P2N\B
M[F:EBN#B].WEAU<7A$RG<%R+;J$^*0?3*7&]68M&VB/AZJ;O(F=$9UOEQ&;C
M\2YU3"A-_,TP3RGC(W*:Y6.%$E%DJ"1-L@G/R%T51SOW]T4X)LC8)$M&AICF
MY`0PRE@.-(DICS$!I$7""I:'-"\HA8<TX1E"2,EK^+?VCTD%GVL%9R>G,,EA
MM6V@46V_5A*J6AAX6@[SN3(P-]Z$$W8Y:X>F']Q,=\[L'X"K50="2B6]E``_
M(057M?8R*V&MLJ`="`O")YG%T*K.^1*@U/UL.72M6,VT^;)_$,&9`UOW0R.A
M5%YI\[/N%CL/H#OKE)`1O-'72D;D/3":(I+SW7A)^)L7(510\O*1IDJC-Y3%
M6JK-&TIMEU'U38<SBGRD>'B8C8>LFF=YRE*>TJ3DY8/#_*GBAI8\811'_\7X
M%N"'\Q^G^6^<$RD:52WUD5IKJ_LN7/O9#4;97Z@`D6?<*W-D>;KEG4_NXT[Q
M,=SQO^"^Q><[`,$?,<T&JMNF?X307&T?#\GY#_K_![B=I"D%)&>W2Q`$]WQX
CT)_#DWDC%O;@Q>Z0JVH_"3NTTXF<5+G`.?D*SOV$*T8%````
`
end
