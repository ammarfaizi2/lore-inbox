Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTELNuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTELNuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:50:35 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:39135 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261953AbTELNue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:50:34 -0400
Message-ID: <3EBFA998.7010401@nortelnetworks.com>
Date: Mon, 12 May 2003 10:03:04 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anyone ever implemented a reparent(pid) syscall?
References: <3EBBF965.4060001@nortelnetworks.com> <20030510063936.D13069@almesberger.net> <3EBF1398.9090704@nortelnetworks.com> <20030512043343.A1861@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> You'd still have a PID reuse race. Of course, you could also
> cover this by checking the process' start time ...

Good point.  It is unlikely this will happen in our scenario (very long-lived 
processes), but we should certainly cover that case.

> But just designing the parent to be simple enough to be reliable
> and/or generic enough that it doesn't even need to be upgraded
> still looks like a more promising approach to me.

That would be the simple solution.  However, it doesn't cover the case of a 
cosmic ray causing a segfault, or the OOM killer coming along, or root 
accidentally doing a kill -9 on the wrong pid, or other similar issues.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

