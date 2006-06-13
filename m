Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752316AbWFMF0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbWFMF0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbWFMF0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:26:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1675 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752315AbWFMF0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rk0FDw5MuXID2EyjZXu0zGSYAIwn60VdPaoMcnYsvgU79/phMtWY4TIntKPIgWXD4RxwWIz8DwIzdwGCjci/0BMo/BCkgWzKhSKHmi386pDCEnJIXZMb2AlbBrKivS3Tq14eSkkn91fLLU7v95BBFkCs/QfGfizeeBiR0kqHhfs=
Message-ID: <787b0d920606122226h1febfb45pd8ec1a6b7a8a59ed@mail.gmail.com>
Date: Tue, 13 Jun 2006 01:26:29 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, emmanuel.fleury@labri.fr, torvalds@osdl.org,
       s0348365@sms.ed.ac.uk, jengelh@linux01.gwdg.de,
       76306.1226@compuserve.com, akpm@osdl.org
Subject: Re: [patch] i386: use C code for current_thread_info()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert writes:

> Using C code for current_thread_info() lets the compiler optimize it.
> With gcc 4.0.2, kernel is smaller:

The often-forgotten __attribute__((const)) might do the job.
The function is indeed const as far as gcc can see, except
perhaps near the schedular code that switches stacks.

This applies to many similar functions, like the ones used
to get current. It should work for the C code too.
