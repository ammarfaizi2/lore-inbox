Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSHTSEF>; Tue, 20 Aug 2002 14:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHTSEF>; Tue, 20 Aug 2002 14:04:05 -0400
Received: from mail.netikka.fi ([62.148.192.132]:20437 "EHLO mail.netikka.fi")
	by vger.kernel.org with ESMTP id <S316204AbSHTSEF>;
	Tue, 20 Aug 2002 14:04:05 -0400
Message-ID: <000b01c24870$d8419970$d20a5f0a@deldaran>
From: "Lahti Oy" <rlahti@netikka.fi>
To: <linux-kernel@vger.kernel.org>
Subject: schedule_timeout()
Date: Tue, 20 Aug 2002 20:41:41 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does schedule_timeout() take a signed long as an argument and then check
for possible negative values? Wouldn't it be better to just take an unsigned
long as argument, thus eliminating all dumb checks in the code?

Also, couldn't MAX_SCHEDULE_TIMEOUT be defined zero to make checking for it
faster (actually I did find five calls to schedule_timeout() using zero
timeout, but couldn't they just use plain schedule() instead?)?

Another issue I found concerns setting current task state to TASK_RUNNING
after calling schedule_timeout(). This seems to be done in many parts of the
kernel, though Kernel-API documentations found from kernelnewbies.org seem
to claim that task state is guaranteed to be TASK_RUNNING after
schedule_timeout() returns. Is the documentation faulty or does the kernel
have obsoleted code?

