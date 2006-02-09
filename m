Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWBIVKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWBIVKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWBIVKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:10:47 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:62192 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750794AbWBIVKr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:10:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NbzUyR+08ppNQyta+bX91BTUo1HsxujQrjly3yBnw8+aX/HNtAAkrRi2Yyl/w0DUkXRva+XVGQklMLxry5x4gmoCXNwelbe9ffZlUNhFtATn+eAUAGpfPasJdNbQa2ndMxXspBa2WZryqR2h1znUCiWiDToXcnzk2WT+mfMFuwk=
Message-ID: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
Date: Thu, 9 Feb 2006 15:10:45 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: RSS Limit implementation issue
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working to implement enforcing RSS limits of a process. I am
planning to make a check for rss limit when setting up pte. If the
limit is crossed I see couple of  different ways of handling .

1. Kill the process . In this case there is no swapping problem.

2. Dont kill the process but dont allocate the memory & do yield as we
do for init process. Modify the scheduler not to chose the process
which has already allocated rss upto its limit. When rss usage
fallsbelow its limit then the scheduler may chose it again to run.
Here there is a scenario when no page of the process has been freed or
swapped out because there were enough free pages? Then we need a way
to reschedule the process by forcefully freeing some pages or need to
kill the process.

I am looking forward for your comments & pros/cons of both approach &
any other alternatives you might come up with.

Thanks
Ram Gupta
