Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUHKUqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUHKUqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHKUqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:46:32 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:20700 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S268196AbUHKUqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:46:31 -0400
Message-ID: <411A8646.1030205@colorfullife.com>
Date: Wed, 11 Aug 2004 22:49:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nick Palmer" <nick@sluggardy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: select implementation not POSIX compliant?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:

>Furthermore, a call to close and then select in the same thread
>blocks while the other thread is still in select, which has a very large
>surprise factor, since the code would work were it not for the other
>select.
>
>  
>
Could you post the test case for this behavior: I assume your test app 
is buggy: a select call that is executed after close returned must 
return EBADF, everything else would be a bug.

Regarding your main point: The return result from select/poll is 
undefined in Linux if you close a descriptor while another thread polls 
or selects it.
This is consistent with the behavior of other Unices - for example HP UX 
kills the process if you replace a descriptor that is being polled with 
dup2.

--
    Manfred
