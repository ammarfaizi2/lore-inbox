Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUFFE76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUFFE76 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 00:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUFFE76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 00:59:58 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:33182 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S262438AbUFFE74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 00:59:56 -0400
Message-ID: <40C2B51C.9030203@codeweavers.com>
Date: Sun, 06 Jun 2004 15:09:32 +0900
From: Mike McCormack <mike@codeweavers.com>
Organization: Codeweavers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:

> Just out of interest - how many legacy apps are broken by this? I assume
> it's a non-zero number, but wouldn't mind to be happily surprised.

Wine depends upon being able to execute code on the heap, and there are 
probably Windows EXEs that depend upon being able to execute code on the 
stack.

Fedore Code 1's exec-shield patch broke Wine badly, as there was no way 
for an application to turn it off from user space, and Wine depended 
upon certain areas of virtual memory being free.

We developed a hack to work around this problem by creating a staticly 
linked binary to reserve memory then load ld-linux.so.2 and a 
dynamically executable into memory manually and run start them.

So, just to confirm, an executable will be able to be built so that it 
can request an executable stack and heap using PT_GNU_STACK or something 
like that, right?

thanks,

Mike

