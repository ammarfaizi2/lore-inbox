Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTFKF2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 01:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTFKF2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 01:28:13 -0400
Received: from zok.SGI.COM ([204.94.215.101]:37530 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264146AbTFKF2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 01:28:12 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "jairam nair" <jairamnair@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem while Crosscompiling Ksymoops 
In-reply-to: Your message of "10 Jun 2003 10:32:40 GMT."
             <20030610103240.3422.qmail@webmail26.rediffmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jun 2003 15:41:29 +1000
Message-ID: <12589.1055310089@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jun 2003 10:32:40 -0000, 
"jairam nair" <jairamnair@rediffmail.com> wrote:
>  Hi,
>    I am trying to cross compile ksymoops-2.4.9 for Strong ARM. 
>But i
>am getting a segmentation Fault. The error messages is as below.
>arm-linux-gcc io.o ksyms.o ksymoops.o map.o misc.o object.o 
>oops.o
>re.o symbol.o -Dlinux -Wall -Wno-conversion -Waggregate-return
>-Wstrict-prototypes -Wmissing-prototypes
>-DINSTALL_PREFIX="\"/skiff/local\"" -DCROSS="\"arm-linux-\""
>-DDEF_KSYMS=\"/proc/ksyms\" -DDEF_LSMOD=\"/proc/modules\"
>-DDEF_OBJECTS=\"/lib/modules/*r/\"
>-DDEF_MAP=\"/usr/src/linux/System.map\" -DDEF_ARCH=\"arm\"
>-I/skiff/local/include -L/skiff/local/lib -arm-linux-ld,-Bstatic 
>-lbfd
>-liberty -arm-linux-ld,-Bdynamic -o ksymoops
>collect2: ld terminated with signal 11 [Segmentation fault], 
>core dumped

The command line for the final link is wrong.  It should contain

 -Wl,-Bstatic -lbfd -liberty -Wl,-Bdynamic -o ksymoops

You replaced '-Wl' with '-arm-linux-ld', ld did not understand that and
got a segmentation fault trying to handle the unknown parameter.
Correct your command line, and log a problem against binutils that it
cannot cope with unexpected options.

>    Can anybody tell me what should be given for DEF_MAP, since in 
>the
>target machine there is no System.map file.

Without a system map, you are not going to get much of a decode.  But
if that is what you want, add 'DEFMAP=' to the make command line.

