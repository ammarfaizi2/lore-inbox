Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWAIEz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWAIEz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWAIEzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:55:55 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:6325 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751274AbWAIEzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:55:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 8 Jan 2006 20:55:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: David Schwartz <davids@webmaster.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH/RFC] POLLHUP tinkering ...
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEOJJDAB.davids@webmaster.com>
Message-ID: <Pine.LNX.4.63.0601082051530.27877@localhost.localdomain>
References: <MDEHLPKNGKAHNMBLJOLKGEOJJDAB.davids@webmaster.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, David Schwartz wrote:

>
>> From: Davide Libenzi <davidel@xmailserver.org>
>> Date: Sun, 8 Jan 2006 16:02:10 -0800 (PST)
>
>>> But if and hangup happened with some data (data + FIN), they won't
>>> receive any more events for the Linux poll subsystem (and epoll,
>>> when using the event triggered interface), so they are forced to
>>> issue an extra read() after the loop to detect the EOF
>>> condition. Besides from the extra read() overhead, the code does not
>>> come exactly pretty.
>
>> The extra last read is always necessary, it's an error synchronization
>> barrier.  Did you know that?
>
> 	If there is an error, an error event must be returned. An edge-triggered
> interface must report every event that occurs with an indication of that
> type.

Yes, that's the case.



>> If a partial read or write hits an error, the successful amount of
>> bytes read or written before the error occurred is returned.  Then any
>> subsequent read or write will report the error immediately.
>
> 	If the connection closes and the edge-triggered interface does not give a
> HUP indication, then it is broken.

Same as above. I think DaveM was thinking at the classical poll/select 
usage scenario, where the wait queue head stays in the device's wait queue 
only during the poll/select system call. With epoll, they're resident and 
always collection events through wakeups (callbacks in the epoll case) 
done by the device on its poll wait queue.



- Davide


