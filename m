Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHSSAB>; Sun, 19 Aug 2001 14:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbRHSR7v>; Sun, 19 Aug 2001 13:59:51 -0400
Received: from UNASSIGNED.SKYNETWEB.COM ([64.23.55.10]:17463 "HELO
	mx.webmailstation.com") by vger.kernel.org with SMTP
	id <S268598AbRHSR7n> convert rfc822-to-8bit; Sun, 19 Aug 2001 13:59:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft
To: linux-kernel@vger.kernel.org
Subject: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
Date: Mon, 20 Aug 2001 01:01:18 +0700
X-Mailer: KMail [version 1.3.5]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010819150344.AFC87204DB@mx.webmailstation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see quite strange behavior of subj.

socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 40
fcntl(40, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(40, F_SETFL, O_RDWR|O_NONBLOCK)   = 0
setsockopt(40, SOL_SOCKET, SO_LINGER, [1], 8) = 0
connect(40, {sin_family=AF_INET, sin_port=htons(2030), 
sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 EINPROGRESS (Operation now in 
progress)
select(41, NULL, [40], NULL, {180, 0})  = 1 (out [40], left {180, 0})
getsockopt(40, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {175, 550000})
ioctl(4, FIONREAD, [0])                 = 0
select(41, [40], NULL, NULL, {180, 0})  = 1 (in [40], left {180, 0})
recv(4, 0x806aa28, 1, 0x4000)           = -1 EAGAIN (Resource temporarily 
unavailable)

As far as you can see select say that socket is writable after connect. This 
mean that connection is completed... But later before read we do select on 
read, and get OK. But recv fails with EAGAIN. This situation is repeated 
constantly. The program stucks in the loop trying to connect, but fails.

Any ideas what can this be?

Maybe comment from Alan, as RH employee?

As a side comment. Server is highly loaded. The program usually works well, 
but if it happend once, it will repeat forever...

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
