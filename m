Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKQWCE>; Fri, 17 Nov 2000 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQKQWBp>; Fri, 17 Nov 2000 17:01:45 -0500
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:30729 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129208AbQKQWBi>; Fri, 17 Nov 2000 17:01:38 -0500
Date: Fri, 17 Nov 2000 22:20:56 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: Andries.Brouwer@cwi.nl
Cc: koenig@tat.physik.uni-tuebingen.de, aeb@veritas.com, emoenke@gwdg.de,
        eric@andante.org, kobras@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001117222056.A1187@turtle.tat.physik.uni-tuebingen.de>
In-Reply-To: <UTC200011172112.WAA135348.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011172112.WAA135348.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Nov 17, 2000 at 10:12:25PM +0100
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, Andries.Brouwer@cwi.nl wrote:

> > memory leak
> 
> Aha. Must be a missing kfree().
> Does this help?
> 
> --- namei.c~    Fri Nov 17 00:48:37 2000
> +++ namei.c     Fri Nov 17 21:59:49 2000
> @@ -197,6 +197,8 @@
>                         bh = NULL;
>                         break;
>                 }
> +               if (cpnt)
> +                       kfree(cpnt);
>         }
>         if (page)
>                 free_page((unsigned long) page);
> 
> Andries

this seems to make things much worse:  starting with ~90M free memory
"du" again started leaking (or maybe just using memory?) down to ~80M free
memory when the system suddently locked up completely, no console switch
was possible anymore (but Sysrq-B did reboot).



Harald
-- 
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
