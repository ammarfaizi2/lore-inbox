Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269451AbUJFU1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbUJFU1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUJFU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:27:06 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3302 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269474AbUJFUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:20:10 -0400
Message-ID: <4164530F.7020605@nortelnetworks.com>
Date: Wed, 06 Oct 2004 14:18:23 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: hzhong@cisco.com, aebr@win.tue.nl, joris@eljakim.nl,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>	<41644D86.4010500@nortelnetworks.com> <20041006130615.4f65a920.davem@davemloft.net>
In-Reply-To: <20041006130615.4f65a920.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 06 Oct 2004 13:54:46 -0600
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> 
> 
>>Would it be so bad to do the checksum before marking the socket readable? 
> 
> 
> Yes, because if we do that we have to make two passes over the
> data instead of one.  It does make a big difference.

Hmm...no easy solution then.

In any case, the current behaviour is not compliant with the POSIX text that 
Andries posted.  Perhaps this should be documented somewhere?

Alternately, how about having the recvmsg() call return a zero, and (if 
appropriate) the length of the name set to zero?  This appears to comply with 
the man page for recvmsg().

Chris
