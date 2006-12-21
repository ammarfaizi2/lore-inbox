Return-Path: <linux-kernel-owner+w=401wt.eu-S1423044AbWLUTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423044AbWLUTVk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423048AbWLUTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:21:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:54700 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423044AbWLUTVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:21:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U9onQ3X/RY7rGEDm1Tj+GVnqhHuscFvbFnJTXtK2m8QYFHw2vdQHScMfPl2yKpPQLbLcLZSb2XKi1Z0sPrR0gLydbyJye9gr53eXmhF/3gXYh5QOGKjqxhTQGnQEb6pUt7EWa7mqpr5toCBe1gGkJUQQAkN4PDztH2vce19r2Fk=
Message-ID: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
Date: Thu, 21 Dec 2006 21:21:38 +0200
From: "saeed bishara" <saeed.bishara@gmail.com>
To: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: using splice/vmsplice to improve file receive performance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to use the splice/vmsplice system calls to improve the
samba server write throughput, but before touching the smbd, I started
to improve the ttcp tool since it simple and has the same flow. I'm
expecting to avoid the "copy_from_user" path when using those
syscalls.
so far, I couldn't make any improvement, actually the throughput get
worst. the new receive flow looks like this (code also attached):
1. read tcp packet (64 pages) to page aligned buffer.
2. vmsplice the buffer to pipe with SPLICE_F_MOVE.
3. splice the pipe to the file, also with SPLICE_F_MOVE.

the strace shows that the splice takes a lot of time. also when
profiling the kernel, I found that the memcpy() called to often !!
