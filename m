Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSLQUC5>; Tue, 17 Dec 2002 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLQUC5>; Tue, 17 Dec 2002 15:02:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267036AbSLQUC4>; Tue, 17 Dec 2002 15:02:56 -0500
Message-ID: <3DFF84BE.6010009@transmeta.com>
Date: Tue, 17 Dec 2002 12:10:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com> <3DFF7E7D.1080900@transmeta.com> <20021217200749.GB32122@mea-ext.zmailer.org>
In-Reply-To: <20021217200749.GB32122@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> (cutting down To:/Cc:)
> 
> On Tue, Dec 17, 2002 at 11:43:57AM -0800, H. Peter Anvin wrote:
> 
>>Linus Torvalds wrote:
>>
>>>The thing is, gettimeofday() isn't _that_ special. It's just not worth a
>>>vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?
>>>Just because we can?
>>
>>getpid() could be implemented in userspace, but not via vsyscalls
>>(instead it could be passed in the ELF data area at process start.)
> 
> 
>   After fork() or clone()  ?
>   If we had only spawn(), and some separate way to start threads...
> 

fork() and clone() would have to return the self-pid as an auxilliary
return value.  This, of course, is getting rather fuggly.

Anything that cares caches getpid() anyway.

	-hpa


