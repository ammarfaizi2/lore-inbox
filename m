Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWAIALO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWAIALO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965364AbWAIALO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:11:14 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:61108 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S965158AbWAIALN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:11:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 8 Jan 2006 16:11:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] POLLHUP tinkering ...
In-Reply-To: <20060108.160802.103497642.davem@davemloft.net>
Message-ID: <Pine.LNX.4.63.0601081610130.6925@localhost.localdomain>
References: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
 <20060108.160802.103497642.davem@davemloft.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, David S. Miller wrote:

> From: Davide Libenzi <davidel@xmailserver.org>
> Date: Sun, 8 Jan 2006 16:02:10 -0800 (PST)
>
>> But if and hangup happened with some data (data + FIN), they won't
>> receive any more events for the Linux poll subsystem (and epoll,
>> when using the event triggered interface), so they are forced to
>> issue an extra read() after the loop to detect the EOF
>> condition. Besides from the extra read() overhead, the code does not
>> come exactly pretty.
>
> The extra last read is always necessary, it's an error synchronization
> barrier.  Did you know that?
>
> If a partial read or write hits an error, the successful amount of
> bytes read or written before the error occurred is returned.  Then any
> subsequent read or write will report the error immediately.

Sorry for the missing info, but I was clearly talking about O_NONBLOCK 
here.



- Davide


