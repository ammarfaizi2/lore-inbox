Return-Path: <linux-kernel-owner+w=401wt.eu-S1752803AbWLREHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbWLREHL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 23:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbWLREHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 23:07:10 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:1777 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbWLREHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 23:07:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sIOwGEC4KIec2a4MVvl4MQguQ3Pt9sK9TktBTM3oIH3NstROqmB7uRQmWtsrQ/Xlj2o8qiRc7frmA4086UMwKG5wp9L8WQIwOpDArIY+nuui7/C3ChtV7/Sch1FfwNZBHgAyd4Jm0s4dOpMXX0vKDnYZft7gs59kVKBXld2vcoQ=
Message-ID: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
Date: Mon, 18 Dec 2006 09:52:08 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Linux disk performance.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
      I was working in one application that requires heavy disk
writes, I noticed some inconsistencies in the write timing.
We are using raw reads to bypass filesystem overhead.

Firstly i tried open("/dev/hda",O_RDWR) i.e without O_DIRECT option.
I saw that after some writes 1 write took too much time.

the results are for writing 128KB data in MIPS 400mhz
sequence channel time (in microseconds)
0              1          1675
0              2           1625
0              3          1836
...
0               16       3398
0               63	1678
1               0         1702
1               1          1845
.....
3                46      17875              // large value
...
4               13      17142              ///
...
4              44      18711            /// large value

Is this behaviour ok?
I beleive this is due to deep request queue.

But when i used O_DIRECT. I got a little higher write times but it
also had such time bumps but at smaller rate.
-----------------------------------------
0              0       	3184
0	       1  	3165
0	       2	3126
...
0             52       10613                // large value
0             60        19004               //  large value

results similar with O_DIRECT|O_SYNC


Can we achieve smooth write times in Linux?

I am using 2.6.10 the results are moreover same (i dont mean
numerically same but i am getting thiming difference) in both P4 3 GHZ
512MB ram and MIPS. Disk is working in UDMA 5.

-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
