Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWJIIZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWJIIZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWJIIZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:25:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932394AbWJIIZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:25:44 -0400
Message-ID: <4529C5B5.4040804@redhat.com>
Date: Mon, 09 Oct 2006 11:44:53 +0800
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia-Pacific
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@dunaweb.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: How to determine whether a file was opened O_DIRECT?
References: <3557.213.163.11.81.1156838596.squirrel@www.dunaweb.hu> <44F400EA.5020506@aitel.hist.no>
In-Reply-To: <44F400EA.5020506@aitel.hist.no>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Böszörményi Zoltán wrote:
>> Hi,
>>
>> I would like to run some diagnostics on a database
>> process and I would like to know what flags it used
>> for opening its files. Is there any way to get this info?
>>
>> Thanks in advance,
>> Zoltán Böszörményi
>>   
> 1. Look at the source code for the database - if you have it.
> 2. Run your database under strace, then search the voluminous
>    output for "open" calls and look at the flags.
> 3. Patch your kernel to "printk" information whenever
>    someone opens with O_DIRECT.

$ stap -x PID -e 'probe syscall.open { if (target() == pid()) log(argstr) }' \
| grep O_DIRECT
"/net", O_RDONLY|O_DIRECTORY|O_LARGEFILE|O_NONBLOCK
"/net", O_RDONLY|O_DIRECTORY|O_LARGEFILE|O_NONBLOCK
...

http://www.sourceware.org/systemtap

Eugene
-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823

