Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263930AbRFMBED>; Tue, 12 Jun 2001 21:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263957AbRFMBDx>; Tue, 12 Jun 2001 21:03:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44955 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263930AbRFMBDh>;
	Tue, 12 Jun 2001 21:03:37 -0400
Message-ID: <3B26BBDB.1EF70F79@mandrakesoft.com>
Date: Tue, 12 Jun 2001 21:03:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor "cleanup" patches for 2.4.5-ac kernels
In-Reply-To: <20010612183832.A29923@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> --- linux-2.4.5ac/drivers/pci/quirks.c~ Tue Jun 12 16:31:12 2001
> +++ linux-2.4.5ac/drivers/pci/quirks.c  Tue Jun 12 17:13:18 2001
> @@ -18,6 +18,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/delay.h>
> +#include <linux/sched.h>
> 
>  #undef DEBUG
> 
> There is no problem if SMP is not configured.

no the better place for this is include/asm-i386/delay.h.  Otherwise you
wind up solving the same problem over and over again in each similar
driver.

I --just-- went through on Alpha, and included linux/sched.h in
include/asm-alpha/delay.h.  Not an hour ago :)  Then Andrea suggested to
simply un-inline udelay, which solved the compile problem in an even
better way.  (we cannot un-inline udelay on x86 I think)


> --- 2.4.5-ac11/include/linux/binfmts.h  Mon Jun  4 14:19:00 2001
> +++ linux/include/linux/binfmts.h       Mon Jun  4 20:24:50 2001
> @@ -32,6 +32,9 @@ struct linux_binprm{
>         unsigned long loader, exec;
>  };
> 
> +/* Forward declaration */
> +struct mm_struct;
> +

I added this one to the MDK kernel compile.  I think it is an 'ac'
thing, I don't get these warnings on vanilla 2.4.[56]-pre.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
