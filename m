Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAaP1b>; Wed, 31 Jan 2001 10:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAaP1V>; Wed, 31 Jan 2001 10:27:21 -0500
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:28874 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129774AbRAaP1L>;
	Wed, 31 Jan 2001 10:27:11 -0500
Date: Wed, 31 Jan 2001 15:26:54 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
Message-ID: <20010131152653.C13345@sable.ox.ac.uk>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 30, 2001 at 01:33:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> 
> At the usual place:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-1.diff.gz

Hmm, disappointing results here; maybe I've missed something.

Setup is a Pentium II 350MHz (tusk) connected to a Pentium III
733MHz (heffalump) (both 512MB RAM) with SX fibre, each with a
3Com 3C985 NIC. Kernels compared are 2.4.1 and 2.4.1+zc
(the 2.4.1-1 diff above) using acenic driver with MTU set to 9000.
Sysctls set are
    # Raise socket buffer limits
    net.core.rmem_max = 262144
    net.core.wmem_max = 262144
    # Increase TCP write memory
    net.ipv4.tcp_wmem = 100000 100000 100000
on both sides.

Comparison tests done were
    gensink4: 10485760 (10MB) buffer size, 262144 (256K) socket buffer
    ftp: server does sendfile() from a 300MB file in page cache,
         client does read from socket/write to /dev/null in 4K chunks.

                       2.4.1                    2.4.1+zc
                     KByte/s tusk%CPU heff%CPU  KByte/s tusk%CPU heff%CPU
gensink4
  tusk->heffalump    94000   58-100   93        54000   98-102   11-45
  heffalump->tusk    72000   86-100   46-59     70000   71-93    53-71

                      2.4.1                     2.4.1+zc         
                      KByte/s                   KByte/s
ftp heffalump->tusk   86000                     62000


I was impressed with the raw 2.4.1 figures and hoped to be even more
impressed with the 2.4.1+zc numbers. Is there something I'm missing or
can change or do to help to improve matters or track down potential
problems?

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
