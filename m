Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSJCQdd>; Thu, 3 Oct 2002 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbSJCQdd>; Thu, 3 Oct 2002 12:33:33 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:30641 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261463AbSJCQdb>;
	Thu, 3 Oct 2002 12:33:31 -0400
Message-ID: <3D9C72A4.1090504@colorfullife.com>
Date: Thu, 03 Oct 2002 18:39:00 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Cedric Roux <Cedric.Roux@lip6.fr>, linux-kernel@vger.kernel.org
Subject: Re:  ipc - msg : memory usage too big ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it is seen as a problem, a solution might be to add
> the memory overhead usage into the queue size, or add a
> variable that counts the real memory used, and limits it
> to a reasonable amount.
> 

The limit in the number of messages was added a few years ago, older 
linux kernels [2.0, early 2.2] contain no limit at all :-(

The implementation was choosen to avoid breaking apps that relied on the 
old behaviour: by default send x-byte messages, but if the queue is 
full, send a 0-byte, msgtype > 0 message that notifies a supervisor 
process that the queue is full.

SUS permits a global system imposed limit on the number of messages, but 
IMHO 9 MB is not excessive [actually, 16*9MB, once for each queue] - 
root can reduce the limit further, if users abuse it.

--
	Manfred

