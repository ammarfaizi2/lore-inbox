Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAPCD5>; Mon, 15 Jan 2001 21:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbRAPCDr>; Mon, 15 Jan 2001 21:03:47 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:22042 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129436AbRAPCDe>;
	Mon, 15 Jan 2001 21:03:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable 
In-Reply-To: Your message of "Mon, 15 Jan 2001 20:09:14 -0200."
             <Pine.LNX.4.21.0101152003520.834-100000@freak.distro.conectiva> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 13:03:02 +1100
Message-ID: <28164.979610582@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001 20:09:14 -0200 (BRST), 
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>On Tue, 16 Jan 2001, Rainer Mager wrote:
>>>EIP; f889e044 <END_OF_CODE+385bfe34/????>   <=====
>Trace; f889d966 <END_OF_CODE+385bf756/????>
>
>It seems the oops is happening in a module's function.
>
>You have to make ksymoops parse the oops output against a System.map which
>has all modules symbols. Load each module by hand with the insmod -m
>option ("insmod -m module.o") and _append_ the outputs to System.map.

No need, just create directory /var/log/ksymoops.  insmod and rmmod
will automatically save the list of modules and the symbol table on
every module load or unload, neatly timestamped.  When you get an oops,
find the entries just before the oops and point ksymoops at those.

ksymoops -m /lib/modules/2.4.0/System.map \
	 -k /var/log/ksymoops/20010116093850.ksyms \
	 -l /var/log/ksymoops/20010116093850.modules < oops.txt

man insmod, section KSYMOOPS ASSISTANCE.  Much easier than trying to
reproduce the environment by hand.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
