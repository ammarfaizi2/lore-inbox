Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRCANqm>; Thu, 1 Mar 2001 08:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRCANqc>; Thu, 1 Mar 2001 08:46:32 -0500
Received: from [212.115.175.146] ([212.115.175.146]:10484 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129593AbRCANqR>; Thu, 1 Mar 2001 08:46:17 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F4A@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: root@chaos.analogic.com, Ivan Stepnikov <iv@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel is unstable
Date: Thu, 1 Mar 2001 14:55:01 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> memory area has to be accessed. In some memory management systems,
> the allocated area has to be actually written (demand zero paging).
> If you execute from a user account, not root, with ulimits enabled,
> you should be able to do:
>         char *p;
> 	for(;;)
>      {
>             if((p = (char *) malloc(WHATEVER)) == NULL)
>             {
>                  puts("Out of memory");
>                  exit(1);
>             }
>             *p = (char) 0x01;    /* Write to memory */
>         }
>       ... without hanging the system.

Allow me to nitpick :o)
int loop;
for(loop=0;loop<WHATEVER; loop+=PAGESIZE)
	p[loop] = 0x01;

Because: as far as I remember only the pages that are touched are
allocated, not the whole memory-block.

But, indead, that's nitpicking. Sorry for that :o)
