Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131754AbQLHMsu>; Fri, 8 Dec 2000 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132080AbQLHMsj>; Fri, 8 Dec 2000 07:48:39 -0500
Received: from public.ndh.net ([195.94.90.21]:44433 "EHLO public.ndh.com")
	by vger.kernel.org with ESMTP id <S131754AbQLHMsc>;
	Fri, 8 Dec 2000 07:48:32 -0500
Date: Fri, 8 Dec 2000 10:46:02 +0100
From: Alexander Riesen <ariesen@public.ndh.com>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: PROBLEM: SO_DETACH_FILTER has no parameters, but is checked to have some
Message-ID: <20001208104602.A27159@traian.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
SO_DETACH_FILTER does not accept any parameter, but code in sock.c check for it.

Problem description:
Trying to remove attached filter i got EINVAL (and the filter was left
attached).
The code setsockopt(fd, SOL_SOCKET, SO_DETACH_FILTER, 0, 0) is correct,
but does work.
Looking in sock.c i have found that SO_DETACH_FILTER is set after checking
parameters of an option. It is not correct in this particular case
(it should be handled like SO_DONTLINGER).
Search for: SO_DETACH_FILTER in sock.c
The problem persists up to 2.4.0-test10.

Workaround:
  int dummy;
  setsockopt(fd, SOL_SOCKET, SO_DETACH_FILTER, &dummy, sizeof(int));

Keywords: networking filter setsockopt SO_DETACH_FILTER

scripts/ver_linux:
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux ws018 2.2.17 #6 Thu Nov 16 12:30:28 CET 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         3c59x nls_koi8-r ntfs smbfs vfat fat nls_iso8859-2 nls_iso8859-1 nls_cp866 binfmt_misc autofs nfs lockd sunrpc nbd

Sincerely yours,
Alexander Riesen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
