Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWGXAKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWGXAKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 20:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWGXAKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 20:10:52 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:23813 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1751318AbWGXAKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 20:10:51 -0400
Date: Mon, 24 Jul 2006 02:10:46 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Michael Buesch <mb@bu3sch.de>
cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
In-Reply-To: <200607232024.43237.mb@bu3sch.de>
Message-ID: <Pine.BSO.4.63.0607240116020.10018@rudy.mif.pg.gda.pl>
References: <44C099D2.5030300@s5r6.in-berlin.de> <20060723112005.GA6815@martell.zuzino.mipt.ru>
 <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl> <200607232024.43237.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-128216222-1153699846=:10018"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-128216222-1153699846=:10018
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 23 Jul 2006, Michael Buesch wrote:
[..]
> Yeah, please stop it.
> Did you actually _look_ at what indent does to code sometimes?
> It sometimes (often?) renders perfectly readable code into a
> huge blob of crap.

Do you remember file names ?
I'm just review diff after using indent with Lindent args and only in few
places I saw something badly looking:
- badly formated __asm__ () content
- in case some functions with very long function names worser looling
   function header,
- struct with filled field using multicolumt (why not use single col ?)

IMO curent issue isn't "indent produces (generaly) bad output" but "in 
some very limited (compare to all amout of code) cases it produces 
something looking bad".
In all other/most of cases (probably ~99%) Lindetd can be used 
.. but for NOW GENERALY IT IS NOT NOT USED.

> Face reality. The linux kernel is following the general codingstyle
> very well already. I don't think there is need to improve the current
> codebase for non-existent codingstyle issues. And we already review
> new code for codingstyle issues, so the codebase remains clean.

Sorry but it is not true. There is no single coding style. Now in probably 
compareble amout of points is used constructions like:

1) top of the function:

static inline void *
find_pa(unsigned long *vptb, void *ptr)

or

static inline void *find_pa(unsigned long *vptb, void *ptr)

(Lindent produces second variant)

2) type conversion:

        return (void *) result;
or
        return (void*)result;
or
        return (void *)result;

(Lindent produces last)

3) using tab or not (Lindent produces code with tabs)

4) sometimes functions argumeta are formated in sigle colum but sometimes
    not:

                 printk("%s   Module Type: 0x%x - Unit ID 0x%x - "
                        "Condition 0x%x\n",
                        err_print_prefix,
                        env->module_type,
                        env->unit_id,
                        env->condition);
or
                 printk("%s   Module Type: 0x%x - Unit ID 0x%x - "
                        "Condition 0x%x\n",
                        env->module_type, env->unit_id, env->condition);

5) remove trailing spaces or not (indent removes trailing spaces)

and probably much, much more small details like this.

> Look at other projects with horrible codingstyle problems
> and suggest solutions to their _real_ issues. *cough*kde*cough*

Sorry but in this case it is simple chicken and egg problem. First you 
must define "coding style" details and after this you 
can start work on tool for indenting all source code.

Now I know why Linux code NEVER was autoformated using some tool. Cause is
VERY simple: because THERE IS NO complet coding style definition for 
Linux tree.

Current Documentation/CodingStyle contains only *very* limited neccessary 
for finish this details.
There is not general rule like "if it produces correctly looking output 
use Lindet" so current Linux coding style is "free style" .. nothing more.

Add general advice "try use Lindent" will allow start discuss on some 
never defined coding style details. Probaly it will als show some bad 
coded fregmets (for exxample when somen uses very long identifiers for 
variables or function names and it will badly look on 80 colums).
Withouty this any time when "coding style" will back it can produce next 
flame theread.

kloczek
PS. In case coding style Linus is right "Documentations/specyfications is 
close to useless" because usability of Documentation/CodingStyle is realy 
cloase to useless but .. in *this* case ducumetation isn't guilty.
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-128216222-1153699846=:10018--
