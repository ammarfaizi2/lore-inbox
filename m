Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291502AbSBMKSC>; Wed, 13 Feb 2002 05:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291508AbSBMKRo>; Wed, 13 Feb 2002 05:17:44 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:32214 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S291502AbSBMKR0>; Wed, 13 Feb 2002 05:17:26 -0500
Message-ID: <3C6A3C26.4050908@drugphish.ch>
Date: Wed, 13 Feb 2002 11:12:54 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Improved ksymoops output
In-Reply-To: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I like the idea very much. As I have to maintain a kernel tree for 
various customers too, I think this could be a nice addition for the bug 
reports (seldom luckily) I sometimes get.

> gen_func2file.map
> =================

[snipped rest of the bash script]

This can be improved a little bit:

----------------------------------------------------------------
#!/bin/sh
# Meant to be run in top lever kernel source dir
# after kernel has been built
#
# Makes list of the form:
# symbol1 object_file_pathname1
# symbol2 object_file_pathname2
# symbol3 object_file_pathname3

 > func2file.map

find -name '*.c' | while read a; do
     #nm: get symbols from .o
     #grep: discard non-text symbols
     #awk: remove './', add .o pathname
     #cut: remove address and symbol type letter
     b=${a%.*}
     test -e "${b}.o" && {
         nm "${b}.o" \
         | grep '\( T \)\|\( t \)' \
         | awk "BEGIN { N=\" ${a:2}\" } { print \$0,N }" \
         | cut -b12- \
         >> func2file.map
     }
done
----------------------------------------------------------------

This script compared to yours does (it's nitpicking):
o run faster (5%) ;)
o should never have problems when one day there will be a lot of *.c
   files. In your approach LIST could someday not hold all entries
   anymore.
o simplifies the bash 'regexp' to snip away the '.c' and print the rest

I'm propably going to rewrite the python script in bash too, since I 
don't run python on my distro (and I do not intend to use 2.5.x anytime 
soon).

Best regards,
Roberto Nibali, ratz

