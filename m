Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWEZHBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWEZHBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWEZHBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:01:37 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:64925 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751300AbWEZHBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:01:36 -0400
Message-ID: <4476A717.7000009@aitel.hist.no>
Date: Fri, 26 May 2006 08:58:31 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: Matheus Izvekov <mizvekov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com>	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>	 <44747432.1090906@ums.usu.ru> <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com> <4474891D.9010205@ums.usu.ru>
In-Reply-To: <4474891D.9010205@ums.usu.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Matheus Izvekov wrote:
>> On 5/24/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
>>> Jon Smirl wrote:
>>> > You can't change the mode, instead you have to track it and use the
>>> > one that is already set.
>>>
>>> OK, this doesn't change my other point: use in-kernel text output 
>>> facility for
>>> panics only.
>>>
>>
>> It would be a good idea to allow oopses to be shown too. For example,
>> your main disk controller driver may oops, and then you have no way to
>> tell what happened, because if you try to run dmesg it may deadlock,
>> and obviously the oops message wont be logged either.
>> So a BSOD which allows you to hit enter to continue after an oops is
>> not a bad idea.
>
> Now suppose this.
>
> The kernel has to save the video memory contents somewhereto restore 
> it after pressing Enter. This may swap something out. Whoops, swap is 
> on that failed disk.
No.  The kernel _tries_ to allocate memory for saving the screen, but
using routines that allocates memory immediately without waiting
for swapout.  (i.e. just use the free memory pools, and possibly discarding
non-dirty pages.) 

If this allocation fails, which it may do, just overwrite graphichs memory
anyway and loose the display contents.  The machine is in trouble anyway.


Helge Hafting
