Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310900AbSCHPFl>; Fri, 8 Mar 2002 10:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310890AbSCHPFV>; Fri, 8 Mar 2002 10:05:21 -0500
Received: from new-coyote.egenera.com ([208.51.147.230]:39609 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S310900AbSCHPFM>; Fri, 8 Mar 2002 10:05:12 -0500
Message-ID: <3C88D2A3.60201@egenera.com>
Date: Fri, 08 Mar 2002 10:02:59 -0500
From: "Patrick O'Rourke" <porourke@egenera.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
Cc: Marcelo Tosati <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix for get_pid hang
In-Reply-To: <200203072045.PAA08386@egenera.com> 	<1015539061.16836.10.camel@plars.austin.ibm.com> <1015539925.16835.22.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> Ok, this time with the patch for real. :)

While I agree with your patch, I still think something should be
done in fork_init() to restrict the initial value of max_threads.

We should not rely on the amount of memory alone.

For example, after a fresh reboot on an i386 system with 12gb
of ram we get:

	[joeuser@simpsons-lisa joeuser]$ id
	uid=500(joeuser) gid=500(joeuser) groups=500(joeuser)
	[joeuser@simpsons-lisa joeuser]$ ulimit -a
	core file size (blocks)     1000000
	data seg size (kbytes)      unlimited
	file size (blocks)          unlimited
	max locked memory (kbytes)  unlimited
	max memory size (kbytes)    unlimited
	open files                  1024
	pipe size (512 bytes)       8
	stack size (kbytes)         8192
	cpu time (seconds)          unlimited
	max user processes          49152
	virtual memory (kbytes)     unlimited
	[joeuser@simpsons-lisa joeuser]$

I believe it is wrong for max user processes to start off above PID_MAX.

Pat

-- 
Patrick O'Rourke
porourke@egenera.com

