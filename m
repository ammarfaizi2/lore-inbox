Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUJPJdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUJPJdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 05:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUJPJdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 05:33:37 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:48560 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268059AbUJPJdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 05:33:25 -0400
Subject: Best way to find where a lock is taken and not released?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097919013.4763.55.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 16 Oct 2004 19:30:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I saw a hang the other day (2.6.8.1) where all other processes except
the suspending to disk one were refrigerated and the process doing the
suspending was stuck trying to take the dcache_lock via
shrink_all_memory. Obviously some path called via shrink_all_memory had
taken the lock and not released it, then tried to retake it _or_ another
process had taken the lock and then not released it when backing out and
entering the refrigator. My question is, what's the best way to find the
path on which this occurs? Grepping, I see dcache_lock all over the
show, so if there's a more efficient method that reading the files, I'd
like to learn it. It occurs to me that I might try wrapping calls to
lock and unlock that lock in printks, but I'm wondering if there's some
better way I don't yet know.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

