Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUL1SSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUL1SSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbUL1SSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:18:05 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:6081 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261158AbUL1SSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:18:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=LhWbmREao/G3k64vPsMzicf65okSN11ocoAIKzYich6hZvE5RaVL2iYoU+n5JzLEN4TGrCDiVJDYuWr/YNSpiO88f5qKZp9ZNaOvQHOs6In/ewZ3uXqWgb2+8WA9VIOibRlatjBbN78vXXv9kUHiDNFgYgeUo4eMc5P7CJaadzQ=
Message-ID: <d4cc500a04122810186b7457eb@mail.gmail.com>
Date: Tue, 28 Dec 2004 20:18:03 +0200
From: Garik E <kiragon@gmail.com>
Reply-To: Garik E <kiragon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: stale POSIX flock
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a strange bug:
POSIX lock is left in system after process termination.
After some debugging I found that filp->f_count entry at the end of
sys_fctl64 function is 1(???) and subsequent call to fput releases
file sturcture, but leaves POSIX lock.
I've added check for FL_POSIX flag to locks_remove_flock and the problem stoped.
This bug happens very often on my environment, but user mode setup is
a multi-process/multi-threaded application, so I have no clue how to
reduce it to a simple testing program.

I work with enterprise linux 3, IBM xSeries345, Pentium4 3000 x2,  2GB RAM
