Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265452AbRFVPxC>; Fri, 22 Jun 2001 11:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265453AbRFVPww>; Fri, 22 Jun 2001 11:52:52 -0400
Received: from sncgw.nai.com ([161.69.248.229]:55983 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265452AbRFVPwn>;
	Fri, 22 Jun 2001 11:52:43 -0400
Message-ID: <XFMail.20010622085500.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <ouplmml6jjf.fsf@pigdrop.muc.suse.de>
Date: Fri, 22 Jun 2001 08:55:00 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: About I/O callbacks ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22-Jun-2001 Andi Kleen wrote:
> Davide Libenzi <davidel@xmailserver.org> writes:
> 
>> I was just thinking to implement I/O callbacks inside the kernel and test
>> which
>> kind of performance could result compared to a select()/poll()
>> implementation.
>> I prefer IO callbacks against async-io coz in this way is more direct to
>> implement an I/O driven state machine + coroutines.
>> This is a first draft :
> 
> They already exist since several years in Linux. 
> 
> It is called queued SIGIO; when you set a realtime signal
> using F_SETSIG for a fd and enable async IO. The callback is a signal
> handler or alternatively an event processing loop using sigwaitinfo*(). 
> The necessary information like which fd got an event is passed in the 
> siginfo_t. 

I know about rt signals and SIGIO :) but I can't see how You can queue signals :

current->sig->action[..]

The action field is an array so if more than one I/O notification is fired
before the SIGIO is delivered, You'll deliver only the last one.
Am I missing something ?




- Davide

