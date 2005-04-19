Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVDSFUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDSFUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDSFUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:20:31 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:62659 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261225AbVDSFUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:20:19 -0400
Message-ID: <426494FD.6020307@lab.ntt.co.jp>
Date: Tue, 19 Apr 2005 14:19:57 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org>
In-Reply-To: <20050419042720.GA15123@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I may mistake the point,
Chris Wedgwood wrote:

>>For me, is seems very dangerous to estimate the primary copy is not
>>broken through status takeover..
>>    
>>
>
>that would also be a problem for live patching too, if you have bad
>state, you have bad state --- live patching doesn't change that
>  
>
What I want to say is takeover may makes memory unstable, because there
are extra operations to reserve current (unstable) status to memory.
Live patching never force target process to reserve status to memory. Is
this make sense?

>>Some process use critical resources such as fixed network listen
>>port can not speed up so.
>>    
>>
>
>hand the fd off to another process
>  
>
I think the point is how long does it takes to hand the fd off to
another process.(means how long time the network port is unavailable??)

>>More importantly, the only process who prepare to use this mechanism
>>only allows to use quick process takeover.
>>    
>>
>
>no, i can mmap state or similar, hand fd's off and switch to another
>process in a context switch... hot patching i bet is going to be
>slower
>
>how about you show up some code that needs this?
>  
>
>>This cause software development difficult.
>>    
>>
>
>i honestly doubt in most cases you can hand live patch faster and more
>easily than having the application sensibly written and passing it off
>
>please, prove me wrong, show us some code
>  
>
Please see and try http://pannus.sourceforge.net
There includes commands and some samples.
On live patching, you never need to use shared memory, just prepare
fixed code, and just compile it as shared ibject, that's all. pretty
easy and fast to replace the functions.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


