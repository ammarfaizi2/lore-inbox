Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWIMBv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWIMBv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWIMBv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:51:29 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16494 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751488AbWIMBv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:51:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b0fW6B8mml+KlUwK7jm+oABRPTK7g8fK4UbMHY5KqFJdEdL2QQtxIXQA9aXwSLKlLYThyJi3ByvM/RLvAK7yRVEQO1RpWrarDAqhXr55QD+AuPP7O1g9GsEhkKIkj+AaoI0t0IzjSGXEM0EtFsyOJhcIHastEfJ8K75FYCAWZCE=
Message-ID: <450763E4.6010602@gmail.com>
Date: Wed, 13 Sep 2006 10:50:28 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <4505694D.5020304@garzik.org> <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org> <45067312.7020900@aitel.hist.no>
In-Reply-To: <45067312.7020900@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> How about a simple and harmless test?
> When an IDE disk is accessed for the first time, perhaps when
> the partition table is read - issue a 256-sector read and see
> what happens.  If it works - fine.  If not, tag the thing as
> supporting max 255 sectors.
> 
> No wrecking of file systems, and full performance for
> the vast majority.

Before implementing anything like that, we need a test case.  We don't 
know how a faulty drive reacts on such cases.  If it actively aborts the 
command, we can reduce the limit to 255 sectors after upper layer issues 
such command, no need to do it earlier.  If it times out, we can't do it 
during boot and it will suck later too.  If it silently corrupts data 
(highly unlikely), we need to detect the condition during boot.

I don't think it matters all that much anyway.  IDE has been running w/ 
256 sectors for a loooong time and someone who seeks performance from 
LBA28 only drive has bigger problems (also I don't think 255 would be 
noticeably slower than 256).

-- 
tejun
