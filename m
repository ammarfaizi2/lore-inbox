Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVJQBwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVJQBwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 21:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVJQBwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 21:52:25 -0400
Received: from argent.vocalabs.com ([65.107.93.22]:47339 "EHLO
	mail.vocalabs.com") by vger.kernel.org with ESMTP id S932122AbVJQBwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 21:52:24 -0400
Message-ID: <43530379.6040504@vocalabs.com>
Date: Sun, 16 Oct 2005 20:50:49 -0500
From: David Leppik <dleppik@vocalabs.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: memory leak in LIST_*, TAILQ_* man page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if this is the wrong mailing list;  I didn't find a better one.

The man page for TAILQ_REMOVE, etc. contains the following sample code:

while (head.tqh_first != NULL)
     TAILQ_REMOVE(&head, head.tqh_first, entries);

I checked /usr/include/sys/queue.h and, sure enough, TAILQ_REMOVE 
doesn't free
head.tqh_first.  Nor should it-- this isn't Objective-C, after all. :-)

It should be something like:

while (head.tqh_first != NULL) {
              np = head.tqh_first;
              TAILQ_REMOVE(&head, np, entries);
              free(np);
}


The same bug is repeated for all the data structures in this man page.


In this day and age of Java, C#, and Objective-C programmers, kids these 
days
are less likely to remember to clean up after themselves.  Therefore it was
particularly jarring to find this bug.  Ten years ago I might have 
laughed it
off.  That's probably why it's been around for so long.

David
