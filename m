Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWEXQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWEXQZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEXQZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:25:53 -0400
Received: from relay4.usu.ru ([194.226.235.39]:58334 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932365AbWEXQZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:25:52 -0400
Message-ID: <4474891D.9010205@ums.usu.ru>
Date: Wed, 24 May 2006 22:26:05 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com>	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <200605230048.14708.dhazelton@enter.net>	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>	 <44747432.1090906@ums.usu.ru> <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
In-Reply-To: <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.32; VDF: 6.34.1.139; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matheus Izvekov wrote:
> On 5/24/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
>> Jon Smirl wrote:
>> > You can't change the mode, instead you have to track it and use the
>> > one that is already set.
>>
>> OK, this doesn't change my other point: use in-kernel text output 
>> facility for
>> panics only.
>>
> 
> It would be a good idea to allow oopses to be shown too. For example,
> your main disk controller driver may oops, and then you have no way to
> tell what happened, because if you try to run dmesg it may deadlock,
> and obviously the oops message wont be logged either.
> So a BSOD which allows you to hit enter to continue after an oops is
> not a bad idea.

Now suppose this.

The kernel has to save the video memory contents somewhereto restore it after 
pressing Enter. This may swap something out. Whoops, swap is on that failed disk.

Or: lock the memory in advance, to avoid the use of swap. But this is not better 
than doing the same thing from a userspace application that shows a pop-up 
ballon with the contents of this oops. And it won't be affected by a disk 
failure, because it has everything already in memory.

-- 
Alexander E. Patrakov
