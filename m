Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSHOWdk>; Thu, 15 Aug 2002 18:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSHOWdk>; Thu, 15 Aug 2002 18:33:40 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:42678 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S317589AbSHOWdk>;
	Thu, 15 Aug 2002 18:33:40 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200208152236.CAA27992@sex.inr.ac.ru>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
To: jmorris@intercode.com.au (James Morris)
Date: Fri, 16 Aug 2002 02:36:44 +0400 (MSD)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org,
       willy@debian.org
In-Reply-To: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au> from "James Morris" at Aug 16, 2 03:16:57 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Comments welcome.

I do not know what forced you to use BKL.

But I daresay this is deadlock:

+       lock_kernel();
+       error = f_setown(filp, current->pid);
+       unlock_kernel();
        if (error) {
                write_unlock(&dn_lock);
                return error;

Use of BKL when another spin lock is grabbed... It will deadlock
each time when some dcahe op is made under BKL.

Alexey
