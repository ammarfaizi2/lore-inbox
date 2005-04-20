Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVDTHg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDTHg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVDTHg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:36:58 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:28386 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261257AbVDTHgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:36:54 -0400
Message-ID: <4266062B.9060400@lab.ntt.co.jp>
Date: Wed, 20 Apr 2005 16:35:07 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org>
In-Reply-To: <20050420054352.GA7329@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think basic assumption between us and you is not match..
Our assumption, the live patching is not for debug, but for the real 
operation method to fix very very important process which can not stop.
Live patchin fix the important process's bug without disrupting process.

Chris Wedgwood wrote:
> On Wed, Apr 20, 2005 at 01:18:23PM +0900, Takashi Ikebe wrote:
> 
> 
>>Well, Live patching is just a patch, so I think the developer of
>>patch should know the original source code well.
> 
> In which case they could fix the application.
> 
Yes, so they provide us the patch module, and we want to apply the patch 
as live patching.
> 
>>Well, as you said some application can do that, but some application
>>can not continue service with your suggestion.
> 
> Such as?
> 
>>please think about the process which use connection type
>>communication such as TCP(it's only example) between users and
>>server. During status copy, all the session between users and server
>>are disconnected...
> 
> 
> They don't have to be. 

???
To takeover the application status, connection type 
communications(SOCK_STREAM) are need to be disconnected by close().
Same network port is not allowed to bind by multiple processes....

How can you do that??
Users don't want to disconnect,(and also we don't want to disconnect) 
but server process need to it to takeover the status.

>>can not save the exiting service at all.
>  
> Yes they can.
> 
>>It's one example, but similar problems may occurs whenever processed
>>use the resources which are mainly controlled by kernel.
> 
> What resources?  We can migrate memory and file descriptors?  What is
> missing?

For example,
current process's resouces of rlimit.
you nerver set current rusage to new process.
especialy, ru_utime and ru_stime is very important to critical applications.
I don't know much about resources, but there may be more....(I hope not..)

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
