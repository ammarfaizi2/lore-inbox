Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265548AbRFVWN4>; Fri, 22 Jun 2001 18:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265547AbRFVWNq>; Fri, 22 Jun 2001 18:13:46 -0400
Received: from sncgw.nai.com ([161.69.248.229]:55756 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265541AbRFVWNj>;
	Fri, 22 Jun 2001 18:13:39 -0400
Message-ID: <XFMail.20010622151650.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E15DYwE-00023t-00@pmenage-dt.ensim.com>
Date: Fri, 22 Jun 2001 15:16:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Paul Menage <pmenage@ensim.com>
Subject: Re: signal dequeue ...
Cc: linux-kernel@vger.kernel.org, george anzinger <george@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22-Jun-2001 Paul Menage wrote:
> In article <0C01A29FBAE24448A792F5C68F5EA47D120354@nasdaq.ms.ensim.com>,
> you write:
>>
>>Right, but the remaining signals are still pending.  In your method, the
>>kernel doesn't know which were and which were not actually delivered.
>>
> 
> You could add an SA_MULTIPLE flag to the sigaction() sa_flags, which
> permit the kernel to stack multiple signals up in this way for apps
> that guarantee not to misbehave. In do_signal()/handle_signal(), only
> allow a signal to be stacked on another signal if its handler has
> SA_MULTIPLE set. So non-stackable signals will always be the last
> signal frame of the stack to be entered, and it won't matter if they
> longjmp() out.
> 
> Would the performance improvement from this be worthwhile? I imagine if
> you're handling a lot of SIGIO signals, the ability to batch up several
> signals in a single user/kernel crossing might be of noticeable benefit.

This could be a good idea but before moving a single hair I want to measure the
maximum ( and average ) queue length for rt signals.
In case this will be constantly > 1 to have a multiple signal dispatch will
save a lot of kernel-mode / user-mode switches.
Otherwise this will be files under NAI ( Not An Issue ) :)





- Davide

