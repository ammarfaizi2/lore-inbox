Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTLFOhK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265174AbTLFOhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:37:09 -0500
Received: from intranet.dnseurope.co.uk ([62.204.35.1]:140 "EHLO
	intranet.dnseurope.co.uk") by vger.kernel.org with ESMTP
	id S265172AbTLFOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:37:06 -0500
Message-ID: <3FD1E93B.2020509@webkreator.com>
Date: Sat, 06 Dec 2003 14:35:39 +0000
From: Ivan Ristic <ivanr@webkreator.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help with an idea for user impersionalisation kernel module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I am looking for someone willing to spend some time helping
me determine whether an idea for a kernel module I have is valid
(since I don't have the necessary kernel & i386 knowledge to
determine that for myself). If you don't think the topic is of
interest to the other list recipients please reply to my private
address (BTW, I am not subscribed to the list so if you are responding
please include me in the list of recipients). Here is the idea:

I would like to develop a kernel module that would allow a process
to become a different user and then safely go back to be the original
user again. This would be very useful in a virtual hosting environments.
I believe that in the long run each user will have a complete virtual
server so shared virtual hosting security won't be an issue as such,
but this idea still seems interesting to play with in the short run.
The idea is not mine but of Scott Deming (he is doing a similar thing
on FreeBSD, see http://makefile.com/dp/node/view/1).

Becoming a different user is not a problem, I know that. However,
going back is another matter. Untrusted code could initiate the
transition to the original user and continue to run with its
privileges. I have an idea on how to prevent this:

1. A new system call will be introduced.

2. A first call to it would change the uid into something else,
    remember the user space address from which the call was made,
    and return control to an entry point in the user space where
    the code to be executed as a different user resides.

3. The second call by the same process would revert back
    to the original user but return to the address in the user space
    from which the first system call was made. This would ensure that
    only trusted code is executed by the original user.

What bothers me is this: can the untrusted user modify the process
code so that when the control is returned back something else is
executed (eg the code inserted by the attacker)?

-- 
ModSecurity (http://www.modsecurity.org)
[ Open source IDS for Web applications ]


