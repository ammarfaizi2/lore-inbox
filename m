Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRCSNUY>; Mon, 19 Mar 2001 08:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRCSNUP>; Mon, 19 Mar 2001 08:20:15 -0500
Received: from mx3.port.ru ([194.67.23.37]:8714 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S131476AbRCSNT7>;
	Mon, 19 Mar 2001 08:19:59 -0500
From: "Parity Error" <bootup@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: switch_to()/doesnt %esp get replaced with %ebp on ret
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 144.16.67.146 via proxy [202.141.1.20]
Reply-To: "Parity Error" <bootup@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14ezYx-000J2L-00@f6.mail.ru>
Date: Mon, 19 Mar 2001 16:19:09 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in schedule(), switch_to() macro changes esp to
the new process's stack. But, on exit frm schedule,
how come it does not get overwritten with  ebp-24,
as the dissasembled code shows. The code was compiled
without the -fomit-frame-pointer.

        pushl 508(%ecx)
        jmp __switch_to
1:      popl %ebp
        popl %edi
        popl %esi

        jmp .L1180

.L1180: 
	leal -24(%ebp),%esp
        popl %ebx
        popl %esi
        popl %edi
        movl %ebp,%esp
        popl %ebp
        ret



