Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTAXLXH>; Fri, 24 Jan 2003 06:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTAXLXG>; Fri, 24 Jan 2003 06:23:06 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:54676 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S267536AbTAXLXF> convert rfc822-to-8bit;
	Fri, 24 Jan 2003 06:23:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: Keith Owens <kaos@ocs.com.au>
Subject: [PATCH available] Re: printk() without KERN_ prefixes? (in 2.5.59)
Date: Fri, 24 Jan 2003 12:32:28 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <12940.1043141000@ocs3.intra.ocs.com.au>
In-Reply-To: <12940.1043141000@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301241232.28151.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Should they be fixed to KERN_INFO or some such? I'm willing to contribute
> > a patch (which will be done by script, of course). Or am I missing
> > something and they shall stay as they are?
>
> Do not blindly add KERN_*.  Some prints are done with multiple calls to
> printk(), only the first call should have KERN_*, otherwise you get
> lines like this, with embedded '<n>' strings.

Well, I wrote a perl-script (available on request) which searches for missing 
KERN_ values.
It does this by reading filenames from STDIN, reading the files, extracting 
every function from there and checking if after \n is a KERN_-value (assuming 
that every function starts from a fresh line). If there is one missing, 
KERN_DEBUG is inserted.

my simple script was unable to do some files in the arch/ia64 tree and some 
others because using #if with mis-aligned { and }. example from 
sound/isa/opti9xx/opti92x-ad1848.c
	#ifdef __ISAPNP__
	        if (isapnp && (hw = snd_card_opti9xx_isapnp(chip)) > 0) {
	 ...
	        } else {
	#endif  /* __ISAPNP__ */
	...
	#ifdef __ISAPNP__
	        }
	#endif  /* __ISAPNP__ */
and it just doesn't check such constructs.

Furthermore it destroys some files (don't know why atm), but these are 
manually excluded from the patch, which is 3933078 bytes (bzipped2 699170).

This patch has NOT all occurances fixed!

from diffstat:
  1908 files changed, 13568 insertions(+), 13567 deletions(-)

So I think it not really useful to just post this patch to the list.


I think I'll cut it at subdirectory levels in pieces (ie arch/ia64, arch/i386, 
drivers/net, drivers/scsi ...).
I should have them available some time monday for the interested.


Comments?



Regards,

Phil



