Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSIABZr>; Sat, 31 Aug 2002 21:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIABZq>; Sat, 31 Aug 2002 21:25:46 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:20959 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S318075AbSIABZq>; Sat, 31 Aug 2002 21:25:46 -0400
Message-ID: <3D716D23.1000101@oracle.com>
Date: Sun, 01 Sep 2002 03:28:03 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: drivers/atm/firestream.c doesn't compile in 2.5.33
References: <Pine.NEB.4.44.0209010227250.147-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   gcc -Wp,-MD,./.firestream.o.d -D__KERNEL__
> -I/home/bunk/linux/kernel-2.5/linux-2.5.33-full/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=k6 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=firestream
> -c -o firestream.o firestream.c
> firestream.c: In function `fs_open':
> firestream.c:870: called object is not a function
> firestream.c:870: parse error before string constant
> firestream.c:1097: called object is not a function
> firestream.c:1097: parse error before string constant
> firestream.c: In function `fs_close':
> firestream.c:1109: called object is not a function
> firestream.c:1109: parse error before string constant
> firestream.c:1159: called object is not a function
> firestream.c:1159: parse error before string constant

Same symptom as the cpia.c (and IrDA, too). Just change

#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter " 
__FUNCTION__ "\n")
#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  " 
__FUNCTION__ "\n")

to

#define func_enter() fs_dprintk (FS_DEBUG_FLOW, "fs: enter %s\n", 
__FUNCTION__)
#define func_exit()  fs_dprintk (FS_DEBUG_FLOW, "fs: exit  %s\n", 
__FUNCTION__)

(the 2.4.20-pre5 firestream.c has the fixed version already)

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

