Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272960AbTGaKAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272970AbTGaKAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:00:10 -0400
Received: from f6.mail.ru ([194.67.57.36]:59148 "EHLO f6.mail.ru")
	by vger.kernel.org with ESMTP id S272960AbTGaKAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:00:08 -0400
From: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: atomic_set & gcc. atomicity question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.133.213.194]
Date: Thu, 31 Jul 2003 14:00:06 +0400
Reply-To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= 
	  <kksx@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19iAEA-0006Fy-00.kksx-mail-ru@f6.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thinking about atomicity of some operations in kernel I've got the following question about atomic_XXX operations.
atomic_set and atomic_read (on i386+ and some others) are simple write to and read from memory, i.e. they are defined as:
#define atomic_set(v,i)         (((v)->counter) = (i))
#define atomic_read(v)          ((v)->counter)

If we call atomic_set() with constant 2nd argument it's ok - it's a simple write to var. But what if we do atomic_set(var, var1+var2)?
Probably, it can happen that compiler will do "var=var1; var+=var2", can't it? If so, atomic_read() can return intermediate value and write won't seem atomic at all. Who guarentees that compiler won't compile it this way? Optimization? gcc developers?

Kirill

