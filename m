Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSFKNRI>; Tue, 11 Jun 2002 09:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSFKNRH>; Tue, 11 Jun 2002 09:17:07 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:45833 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317035AbSFKNRG>; Tue, 11 Jun 2002 09:17:06 -0400
Message-ID: <3D05F8CB.7040409@loewe-komp.de>
Date: Tue, 11 Jun 2002 15:19:07 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Vladimir Zidar <vladimir@mindnever.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
In-Reply-To: <1023380463.1751.39.camel@server1> 	<3D00706B.1070906@loewe-komp.de> <1023481074.7204.70.camel@server1> 	<3D0324B1.614BD9D4@loewe-komp.de> <1023723807.1491.56.camel@server1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Zidar wrote:
> On Sun, 2002-06-09 at 11:49, Peter Wächtler wrote:
> 
> 
>>Just for *that*?
>>Do you write programs that reveal from sigsegv with sigsetjmp(3)?
>>
> 
>  No, I do not. But killing the process sounds much like abnormal
> programm termination. Can you feel the word 'abnormal' ? It is opposite
> of normal - be it simple as error condition on file descriptor.
> 

A-prog:               B-prog:

gets write lock
write some data
                        block on read lock
write some data
crashes
                        wants an error indication to repair data magically


So a crashing A-prog is OK for you, but B should get an indication.
Could catch a signal (SIGLOST?) returning -1 with errno=LOCKBROKEN
That would be possible with futex.

That is a case for writing data to a file - what about linked lists
in memory?


