Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEVMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEVMqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUEVMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:46:35 -0400
Received: from mail.aknet.ru ([217.67.122.194]:33035 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261205AbUEVMqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:46:32 -0400
Message-ID: <40AF4B9E.5000305@aknet.ru>
Date: Sat, 22 May 2004 16:46:22 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040410
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in VM accounting code, probably exploitable
References: <40A12E83.7030209@aknet.ru> <20040520194358.GE19922@logos.cnet>
In-Reply-To: <20040520194358.GE19922@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo.

Marcelo Tosatti wrote:
>>As you can see, the program caused many
>>other processes to be killed, before it
>>died itself.
> About v2.4, can you try v2.4.26 with CONFIG_OOM_KILLER=y ? 
OK, with CONFIG_OOM_KILLER=y (2.4.26) I get this:
---
May 22 16:14:56 lin kernel: Out of Memory: Killed process 1514 
(overc_test).
May 22 16:14:56 lin kernel: Out of Memory: Killed process 1320 
(mozilla-bin).
May 22 16:14:56 lin kernel: Out of Memory: Killed process 1406 
(mozilla-bin).
May 22 16:14:56 lin kernel: Out of Memory: Killed process 1407 
(mozilla-bin).
May 22 16:14:56 lin kernel: Out of Memory: Killed process 1409 
(mozilla-bin).
---
Better than without OOM killer, although
still not perfect - for some reasons it also
decided to kill mozilla *after* killing the
test program. Strange.

> As for the overcommit, I think it has always been "broken"? (its always 
> possible to overcommit).
At least I received a couple of messages that
stated that my test program doesn't OOM the
RedHat Fedora 2.4 kernels - mprotect() fails
with ENOMEM. That resembles the correct
behaveour of the fixed 2.6 so I think at least
RedHat got rid of that problem somehow.
Hope that helps.
