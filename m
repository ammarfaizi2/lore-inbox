Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUBXPGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbUBXPGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:06:45 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:64151 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262265AbUBXPGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:06:42 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: can i modify ls
From: James Lamanna <jlamanna@ugcs.caltech.edu>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Tue, 24 Feb 2004 07:04:58 -0800
Message-ID: <opr3vqukr2z4tciz@192.168.1.1>
User-Agent: Opera7.23/Win32 M2 build 3227
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 02:33:00AM +0530, Gautam Pagedar wrote:
>> i am new to this mailing list, so please bear with me if i don't follow 
>> certain rules till i get used to it. >> I am a research student and 
>> currently working on a project to tweak the working of 'ls' command 
>> depending on >> my requirement. I have observed that 'ls' show ALL THE 
>> FILES and DIRECTORIES in a particular location even >> though a user 
>> has no access rights to it. I want to hide all
>> such files for that particular user.


> It already works like you expect it to do:

> erik@zurix:/tmp/test >mkdir a b
> erik@zurix:/tmp/test >touch a/c
> erik@zurix:/tmp/test >ls -lR
> .:
> total 1
> drwxr-xr-x 2 erik users 72 Feb 24 11:49 a/ ./a:
> total 0
> -rw-r--r-- 1 erik users 0 Feb 24 11:49 c erik@zurix:/tmp/test >chmod -r a
> erik@zurix:/tmp/test >ls -lR
> .:
> total 1
> d-wx--x--x 2 erik users 72 Feb 24 11:49 a/ ls: ./a: Permission denied
> erik@zurix:/tmp/test >chmod -x a
> erik@zurix:/tmp/test >cd a
> a: Permission denied.

I think the behavior that he is looking for is the old behavior that 
Novell Netware used to exhibit - if you don't have any permissions at all, 
it wouldn't list the directory anywhere (at least in windows-type file 
browsers):

james@agard:~/s$ su
Password:
agard:/home/james/s# touch c
agard:/home/james/s# chmod 600 c
agard:/home/james/s# mkdir b
agard:/home/james/s# mkdir a
agard:/home/james/s# chmod 700 a
agard:/home/james/s# ls -alR
.:
total 16
drwxr-xr-x    4 james    james        4096 Feb 23 15:10 .
drwxr-xr-x   48 james    james        4096 Feb 23 15:09 ..
drwx------    2 root     root         4096 Feb 23 15:10 a
drwxr-xr-x    2 root     root         4096 Feb 23 15:10 b
-rw-------    1 root     root            0 Feb 23 15:09 c

./a:
total 8
drwx------    2 root     root         4096 Feb 23 15:10 .
drwxr-xr-x    4 james    james        4096 Feb 23 15:10 ..

./b:
total 8
drwxr-xr-x    2 root     root         4096 Feb 23 15:10 .
drwxr-xr-x    4 james    james        4096 Feb 23 15:10 ..
agard:/home/james/s# exit
exit


james@agard:~/s$ ls -alR
.:
total 16
drwxr-xr-x    4 james    james        4096 Feb 23 15:10 .
drwxr-xr-x   48 james    james        4096 Feb 23 15:09 ..
drwx------    2 root     root         4096 Feb 23 15:10 a
drwxr-xr-x    2 root     root         4096 Feb 23 15:10 b
-rw-------    1 root     root            0 Feb 23 15:09 c
ls: ./a: Permission denied

./b:
total 8
drwxr-xr-x    2 root     root         4096 Feb 23 15:10 .
drwxr-xr-x    4 james    james        4096 Feb 23 15:10 ..
james@agard:~/s$

So in the user directory listing above, he doesn't want the directory a or 
the file c to be displayed at all (since the user doing the ls has no 
permissions on either).
