Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277011AbRJHRGM>; Mon, 8 Oct 2001 13:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277010AbRJHRGC>; Mon, 8 Oct 2001 13:06:02 -0400
Received: from foobar.isg.de ([62.96.243.63]:12998 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S277006AbRJHRFy>;
	Mon, 8 Oct 2001 13:05:54 -0400
Message-ID: <3BC1DD17.EACD968@isg.de>
Date: Mon, 08 Oct 2001 19:06:31 +0200
From: lkv@isg.de
Organization: Innovative Software AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: German, de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Linux <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <E15qdVw-00016L-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Hmmm... would you say the "siglongjmp" method is better than the "self-pipe"
> > method for a select on both file descriptors and signals too?
> 
> siglongjmp doesnt have to make any syscalls so intuitively I'd say it
> ought to be more efficient

Are you sure? Doesn't sigsetjmp() call sigprocmask in order to obtain
the current signal mask?

In the glibc I read:

int
__sigjmp_save (sigjmp_buf env, int savemask)
{
  env[0].__mask_was_saved = (savemask &&
                             __sigprocmask (SIG_BLOCK, (sigset_t *) NULL,
                                            &env[0].__saved_mask) == 0);

  return 0;
}


*sigh* things could be so easy if there was a working pselect()...


Regards,

Lutz vieweg


--
 Dipl. Phys. Lutz Vieweg | email: lkv@isg.de
 Innovative Software AG  | Phone/Fax: +49-69-505030 -120/-505
 Feuerbachstrasse 26-32  | http://www.isg.de/people/lkv/
 60325 Frankfurt am Main | ^^^ PGP key available here ^^^
