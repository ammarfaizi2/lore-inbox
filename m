Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281152AbRKTQEp>; Tue, 20 Nov 2001 11:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281150AbRKTQEf>; Tue, 20 Nov 2001 11:04:35 -0500
Received: from hermes.toad.net ([162.33.130.251]:20185 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S281147AbRKTQEU>;
	Tue, 20 Nov 2001 11:04:20 -0500
Subject: Re: x bit for dirs: misfeature?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 20 Nov 2001 11:05:04 -0500
Message-Id: <1006272306.9039.18.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive me if I overlooked the message that
already said this, but ...

James Sutherland wrote that "There are valid uses for
X only directories (i.e. users are not allowed to list 
the contents, only to access them directly by name).
R-only directories make little sense".  Then there
followed a long discussion about the utility of "--x"
directories.  (I agree that they aren't a very good
idea, since an explorable directory can be "listed" by
trial and error on the filenames within it.)

However, a decent reason for having separate r and x
is that "r--" directories _do_ make sense.  When a
directory is "r--", its contents can be _listed_ but the
directory cannot be browsed.  Observe:     // Thomas Hood


jdthood@thanatos:~/tmp$ ls -l
total 8
drwxr-xr-x    2 jdthood  jdthood      4096 Nov 20 10:59 ./
drwx------   89 jdthood  jdthood      4096 Nov 20 10:55 ../
jdthood@thanatos:~/tmp$ mkdir --mode=777 test
jdthood@thanatos:~/tmp$ ls -l
total 12
drwxr-xr-x    3 jdthood  jdthood      4096 Nov 20 10:59 ./
drwx------   89 jdthood  jdthood      4096 Nov 20 10:55 ../
drwxrwxrwx    2 jdthood  jdthood      4096 Nov 20 10:59 test/
jdthood@thanatos:~/tmp$ touch test/1
jdthood@thanatos:~/tmp$ touch test/2
jdthood@thanatos:~/tmp$ ls -l . test
.:
total 12
drwxr-xr-x    3 jdthood  jdthood      4096 Nov 20 10:59 ./
drwx------   89 jdthood  jdthood      4096 Nov 20 10:55 ../
drwxrwxrwx    2 jdthood  jdthood      4096 Nov 20 10:59 test/

test:
total 8
drwxrwxrwx    2 jdthood  jdthood      4096 Nov 20 10:59 ./
drwxr-xr-x    3 jdthood  jdthood      4096 Nov 20 10:59 ../
-rw-r--r--    1 jdthood  jdthood         0 Nov 20 10:59 1
-rw-r--r--    1 jdthood  jdthood         0 Nov 20 10:59 2
jdthood@thanatos:~/tmp$ chmod ugo-x test
jdthood@thanatos:~/tmp$ ls -l . test
.:
total 12
drwxr-xr-x    3 jdthood  jdthood      4096 Nov 20 10:59 ./
drwx------   89 jdthood  jdthood      4096 Nov 20 10:55 ../
drw-rw-rw-    2 jdthood  jdthood      4096 Nov 20 10:59 test/

ls: test/.: Permission denied
ls: test/..: Permission denied
ls: test/1: Permission denied
ls: test/2: Permission denied
test:
total 0
jdthood@thanatos:~/tmp$ chmod ugo-r test
jdthood@thanatos:~/tmp$ ls -l . test
.:
total 12
drwxr-xr-x    3 jdthood  jdthood      4096 Nov 20 10:59 ./
drwx------   89 jdthood  jdthood      4096 Nov 20 10:55 ../
d-w--w--w-    2 jdthood  jdthood      4096 Nov 20 10:59 test/

ls: test: Permission denied


