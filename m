Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUKSRk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUKSRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKSRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:40:29 -0500
Received: from imap.gmx.net ([213.165.64.20]:30626 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261504AbUKSRkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:40:20 -0500
X-Authenticated: #1892127
In-Reply-To: <20041117195236.475d0922.akpm@osdl.org>
References: <CA837452-38E4-11D9-8FA5-0003931E0B62@gmx.li> <20041117195236.475d0922.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76E0E3D3-3A52-11D9-B5E1-0003931E0B62@gmx.li>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: Re: HFS+ Bug which causes coreutils "make test" to fail
Date: Fri, 19 Nov 2004 18:43:04 +0100
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18.11.2004, at 04:52, Andrew Morton wrote:

> Martin Schaffner <schaffner@gmx.li> wrote:
>>
>> I'm installing my system using an HFS+ partition as root.
>> When I installed the GNU coreutils, I noticed that some test fail, 
>> even
>> though they succeed on other fs such as ext2.
>> I've tracked down one failure to the following:
>>
>> mkdir a; chmod 1777 a; touch a/b; su otheruser -c "rm -rf a"
>>
>> gives differing results. On ext2:
>>
>> rm: cannot remove 'a': Permission denied
>>
>> On HFS+:
>>
>> rm: reading directory 'a/b': Not a directory
>> rm: cannot remove directory 'a': Directory not empty
>>
>>
>> The other failure related to the fact that all pipe files are suffixed
>> by "|", and all links by "@" when doing "ls -1F" on HFS+
>>
>
> What is the kernel version?

Sorry for forgetting to write this; it was linux-2.6.8.1.

Today, I retested with linux-2.6.10-rc2, and found  out that both 
failures happen with this version, too.

Here's part of the log from the second failure:
make[3]: Entering directory `/native/coreutils-5.2.1/tests/ls'
make  check-TESTS
make[3]: Entering directory `/native/coreutils-5.2.1/tests/ls'
PASS: inode
PASS: dangle
out2 exp2 differ: char 21, line 3
3c3
< fifo
---
 > fifo|
5,7c5,7
< slink-dangle
< slink-dir
< slink-reg
---
 > slink-dangle@
 > slink-dir@
 > slink-reg@
FAIL: file-type
PASS: recursive
PASS: dired
...
1 of 12 tests failed

