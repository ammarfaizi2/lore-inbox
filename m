Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWEOS7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWEOS7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEOS7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:59:42 -0400
Received: from web51912.mail.yahoo.com ([206.190.48.75]:61887 "HELO
	web51912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932439AbWEOS7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:59:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DYrdvNKd0etplf2XH+W455qCiwiFm7sr+W6a3romd6b1C+RimKGaqRJZ2aHguz58m+EeHAglILbk4SXlKY9Ngq0rjff1b9/ldkf0GNu8qFpOEVIQUdBCLexkaTn8t0r1rSjjqqrDmWG8+lui13OzNG2ZPC2uJkszJvzrzAQ/gNk=  ;
Message-ID: <20060515185940.16459.qmail@web51912.mail.yahoo.com>
Date: Mon, 15 May 2006 11:59:40 -0700 (PDT)
From: wang dengyi <dy_wang@yahoo.com>
Subject: umount error: device is busy after nfs + lock
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I ran ltp test case:tlocklfs, I met a old problem
with the kernel:2.6.9. I can not umount a file system
after nfs and lock using it. Here is the steps.
 1) mount /dev/sda3 /xyz
 2) export /xyz
 3) restart nfs
 4) mount 127.0.0.1:/xyz /mnt/nfs_xyz
 5) run the special lock test program: "tlocklfs -t 7
/mnt/nfs_xyz
 6) umount /mnt/nfs_xyz
 7) stop nfs
 8) umount /xyz
Then I got the error: "umount /xyz: device is busy".
And the error displays twice. 

If I run the different lock test case for the step 5,
the umount works fine. It only failed on the test case
7 from tlocklfs. 

There are 2 processes in this special test case.
First, the parent process "setlk" for a file from nfs
file system. Then the child process "setlkw". At the
end, the parent and the child process unlock the file.


With some debug line in the code, I found the file
system's "mnt_count" is 3 instead of 2 before
umounting it. I traced back the problem and I'm lost
in linux/net/sunrpc/sched.c. Could anyone give me some
hint? Thank you very much.

Best regard

Dengyi Wang
  

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam
protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
