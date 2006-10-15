Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWJOTYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWJOTYq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWJOTYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:24:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:41704 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422814AbWJOTYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:24:44 -0400
Message-ID: <45328AF9.7060807@vandrovec.name>
Date: Sun, 15 Oct 2006 21:24:41 +0200
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, Petr Vandrovec <petr@vandrovec.name>
Subject: Re: Bad core files with 2.6.19-rc2
References: <microsoft-free.87mz7yjnm2.fsf@youngs.au.com> <20061015184217.GZ30596@stusta.de>
In-Reply-To: <20061015184217.GZ30596@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2006 19:24:44.0886 (UTC) FILETIME=[921AD760:01C6F08F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Oct 15, 2006 at 12:53:41PM +1000, Steve Youngs wrote:
> 
> 
>>gdb doesn't like any core dump file generated while running
>>2.6.19-rc2.  If I `kill -SIGSEGV $some_app_pid' and then...
>>
>>  gdb some_app core
>>
>>I get...
>>
>>  warning: Couldn't find general-purpose registers in core file.
>>  #0  0x00000000 in ?? ()
>>
>>But if I gdb attach to a running process and then kill -SIGSEGV
>>the process, it produces a normal trace without problem.
> 
> 
> It seems this issue should be fixed in Linus' tree now.
> 
> Can you confirm it's fixed?

It should be fixed now (i.e. 26 minutes ago).  Before my first fix core 
dump contained only some phdrs and notes, nothing else.  After first fix 
core dump contained everything, but pieces after notes were shifted down 
by couple of bytes.  After second fix I believe that cores are written 
out correctly - readelf still says that there is some zeroed note, but 
it seems to me like feature - older core files have this as well:

$ readelf -a core
...
Notes at offset 0x00035608 with length 0x00000018:
   Owner         Data size       Description
   Linux         0x00000004      Unknown note type: (0x00000000)

						Petr Vandrovec
