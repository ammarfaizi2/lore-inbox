Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUDTIPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUDTIPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDTIPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:15:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55047 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262311AbUDTIPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:15:05 -0400
Message-ID: <4084DC4E.3000903@aitel.hist.no>
Date: Tue, 20 Apr 2004 10:16:14 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Fabiano Ramos <fabramos@bol.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: task switching at Page Faults
References: <1082399579.1146.15.camel@slack.domain.invalid>
In-Reply-To: <1082399579.1146.15.camel@slack.domain.invalid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabiano Ramos wrote:
> Hi all.
> 
> 	I am in doubt about the linux kernel behaviour is this situation:
> supose a have the process A, with the highest realtime
> priority and SCHED_FIFO policy. The process then issues a syscall,
> say read():
> 
> 	1) Can I be sure that there will be no process switch during the
> syscall processing, even if the system call causes a page fault?

A page fault means your realtime process must wait, because the
data it wants isn't available yet. (Data have to be fetched
from disk/device which takes lots of time.)

There is nothing wrong with handing the cpu to some other
lower priority process unser such circumstances, because your realtime
process are stuck and can't use it anyway.

The realtime process wil grab the cpu as soon as it gets ready to run anyway,
I believe the scheduler looks for this sort of thing when the pagefault
eventually completes.

Helge Hafting

