Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUDTL6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDTL6d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 07:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUDTL6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 07:58:33 -0400
Received: from elin.scali.no ([62.70.89.10]:13745 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262438AbUDTL6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 07:58:30 -0400
Subject: RFC: executable archive
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1082462304.27255.76.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 13:58:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

I wanted to share and idea (and I'm sure I going to get booh'ed of the
list but...) with you all. 

One thing have annoyed me for a long time while writing perl progs, and
that it not possible to "link" it, in that programs must span multiple
files to be manageable as they grow. I'm sure we all agree that only
trivial programs can be coded in a single source file. 
The annoyment stems from the fact that a single "executable" must be
distributed as multiple files. 
A problem with perl, that Larry Wall should have though of right?

Same problem with python (i'm just learning), and a collection of .class
files for java. 
The problem is compounded that all decent scripting languages allow
compiled modules in the shaped of a shared object, which make it really
hard on the developers of the scripting engine to make single exec. 

What would solve it is have an executable archive, in where you put the
top level script, subscripts, shared objects, and any other file it may
need. 

It would be nice to have a general solution to the problem. 

My first though would be to make a stub, and put the ar file in the data
area of the process, something akind to self extracting zip files on
dos/windoze.
A couple of problems: 
a) you can't "mount" the ar file to make it visible to the process as a
part of it's file system view. ( Atleast not without intercepting a
whole lot of libc calls) 
b) unpacking it somewhere would clobber up your fs as it would not be
cleaned up after a program crash or machine crash. 

Ideally I'd like to see the files in the ar as in the cwd, but that
would make a namespace collision possible.   

The second though would be to do it in the kernel, which would go
something like this:

- let the exec() handler in the kernel recognize the exec-ar, just like
it recognizes the #! magic. 
- use the loopback mount device to mount the ar (read only) under
/proc/self/archive  
(- it would be nice to do something to the env's like adding
/proc/self/archive to PATH, LD:LIBRARY_PATH, of honor a file like
/proc/self/env to modify the envs)
- now exec the file /proc/self/archive/main


No namespace collision.
No clean up problems
AND a general solution, not tied up to perl, python, java, or anything
else, as well as supporting ANY kind of file type in the executable. 


And of course overloading the kernel with more crap :-)


ANy insights?   

Just a "bad idea" without any reasoning goes straight to /dev/trolling



TJ

-- 

Terje Eggestad
Senior Software Engineer
dir. +47 22 62 89 61
mob. +47 975 31 57
fax. +47 22 62 89 51
terje.eggestad@scali.com

Scali - www.scali.com
High Performance Clustering

