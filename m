Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbRGADNG>; Sat, 30 Jun 2001 23:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbRGADMp>; Sat, 30 Jun 2001 23:12:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:36114 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264954AbRGADMo>;
	Sat, 30 Jun 2001 23:12:44 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.5ac19] reproduceable Kernel crashes 
In-Reply-To: Your message of "Sat, 30 Jun 2001 16:47:21 +0200."
             <01063015302700.00954@athlon> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Jul 2001 13:12:38 +1000
Message-ID: <6927.993957158@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001 16:47:21 +0200, 
Andreas Hartmann <andihartmann@freenet.de> wrote:
>Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says 
>e08b11e0, /lib/modules/2.4.5-ac19/kernel/net/unix/unix.o says e08b0e40.  
>Ignoring /lib/modules/2.4.5-ac19/kernel/net/unix/unix.o entry
>Trace; e0a4c45d <[unix].bss.end+19ae76/382a79>
>Trace; e0a4c535 <[unix].bss.end+19af4e/382a79>

The mismatch and the weird entries in the trace imply that you ran
ksymoops with a different set of modules from the failing system.  This
is a common problem when decoding an oops after a reboot, the current
set of modules does not match the set at the time of failure so
ksymoops gets bad data.

The easiest fix is to follow the procedure in 'man insmod', section
KSYMOOPS ASSISTANCE.  Create directory /var/log/ksymoops, reproduce the
problem then decode the oops giving ksymoops the relevant ksyms.<date>
and modules.<date> files.  That way you guarantee that you are decoding
the oops using the correct set of symbols.  When you have a clean
decode, mail it to linux-kernel.

