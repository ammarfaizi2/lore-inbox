Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKSXMW>; Sun, 19 Nov 2000 18:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129308AbQKSXMM>; Sun, 19 Nov 2000 18:12:12 -0500
Received: from mx2.core.com ([208.40.40.41]:15062 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S129183AbQKSXL7>;
	Sun, 19 Nov 2000 18:11:59 -0500
Message-ID: <3A18573B.E65CA88A@megsinet.net>
Date: Sun, 19 Nov 2000 16:42:03 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: run level 1, login takes too long, 2.4.X vs. 2.2.X
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had occasion to "telinit 1" today and found that it took a long time
to login after root passwd was entered.  this doesn't happen with 2.2.X
kernels.

Is this to be expected with the 2.4 series kernels? or a bug?

Martin

strace for 2.4.0-test11-pre7

---snip---
gettimeofday({974665658, 952483}, NULL) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 3
getpid()                                = 305
bind(3, {sin_family=AF_INET, sin_port=htons(905), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
ioctl(3, FIONBIO, [1])                  = 0
sendto(3, "\31\23\233@\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111),
sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
poll([{fd=3, events=POLLIN}], 1, 5000)  = 0
ioctl(3, SIOCGIFCONF, 0xbfffb33c)       = 0
ioctl(3, SIOCGIFFLAGS, 0xbfffb344)      = 0
sendto(3, "\31\23\233@\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111),
sin_addr=inet_addr("127.0.0.1")}}, 16) = 56 
---snip---

strace for 2.2.17

---snip---
gettimeofday({974664928, 735539}, NULL) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 3
getpid()                                = 368
bind(3, {sin_family=AF_INET, sin_port=htons(968), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
ioctl(3, FIONBIO, [1])                  = 0
sendto(3, "_c\353\331\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3"..., 56, 0, {sin_family=AF_INET, sin_port=htons(111),
sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
poll([{fd=3, events=POLLIN, revents=POLLERR}], 1, 5000) = 1
recvfrom(3, 0x8056380, 400, 0, 0xbfffd66c, 0xbfffd618) = -1 ECONNREFUSED (Connection refused)
close(3)                                = 0  
---snip---
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
