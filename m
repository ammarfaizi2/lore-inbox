Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBOJp7>; Sat, 15 Feb 2003 04:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTBOJp6>; Sat, 15 Feb 2003 04:45:58 -0500
Received: from imap.gmx.net ([213.165.64.20]:29733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264730AbTBOJp5>;
	Sat, 15 Feb 2003 04:45:57 -0500
Message-Id: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 15 Feb 2003 11:00:28 +0100
To: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] CFQ scheduler, #2
In-Reply-To: <20030214141919.GK879@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_17036437==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_17036437==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 03:19 PM 2/14/2003 +0100, Jens Axboe wrote:
>Hi,

Greetings

>The version posted the other day did fair queueing of requests between
>processes, but it did not help to provide fair request allocation. This
>version does that too, results are rather remarkable. In addition, the
>following changes were made:
>
>- Fix lost request problem with rbtree aliasing. The default io
>   scheduler in 2.5.60 has the same bug, a fix has been sent separetely
>   to Linus that addresses this.
>
>- Add front merging.
>
>- Missing queue_lock grab in get_request_wait() before checking request
>   list count. Again, a generic kernel bug. A patch will be sent to Linus
>   to address that as well.

I gave this a burn, and under hefty load it seems to provide a bit of 
anti-thrash benefit.

i(dang, wish I had pine/vi for winders box)log data attached

         -Mike
--=====================_17036437==_
Content-Type: text/plain; name="xx.txt";
 x-mac-type="42494E41"; x-mac-creator="74747874"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="xx.txt"

Mi41LjYxdmlyZ2luIG1ha2UgYnpJbWFnZSByZWZlcmVuY2UgcnVuCihwb29yIGJveCBpc24ndCBf
cmVkaWN1bG91c2x5XyBvdmVybG9hZGVkOykKcmVhbCAgICA4bTkuNzEwcwp1c2VyICAgIDdtMjcu
MDQ1cwpzeXMgICAgIDBtMzQuNjA1cwoKdGhyZWUgY29uc2VjdXRpdmUgbWFrZSAtajMwIGJ6SW1h
Z2UgcnVucwoKMi41LjYxY2ZxMgpyZWFsICAgIDhtNDEuODM0cyAgIDhtMzYuOTA4cyAgIDhtMzgu
MTY0cwp1c2VyICAgIDdtMzcuMjA4cyAgIDdtMzYuOTg2cyAgIDdtMzYuNDU2cwpzeXMgICAgIDBt
NDIuOTIxcyAgIDBtNDMuMzg3cyAgIDBtNDMuMzEycwoKMi41LjYxdmlyZ2luCnJlYWwgICAgOG0z
OS43MjNzICAgOG0zOS40NTZzICAgOG00Mi4xMDJzCnVzZXIgICAgN20zOS4zNDNzICAgN20zOC44
MDBzICAgN20zOC41NDJzCnN5cyAgICAgMG00My40MTdzICAgMG00My4zMjJzICAgMG00My41MDJz
CgovcHJvYy92bXN0YXQgICAgMi41LjYxY2ZxMiAgIDIuNS42MXZpcmdpbgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpucl9kaXJ0eSAgICAgICAgICAgICAgICAyMCAg
ICAgICAgICAgICAxMwpucl93cml0ZWJhY2sgICAgICAgICAgICAgMCAgICAgICAgICAgICAgMApu
cl9wYWdlY2FjaGUgICAgICAgICAgNzMwOCAgICAgICAgICAgNzU5Mwpucl9wYWdlX3RhYmxlX3Bh
Z2VzICAgICA4NSAgICAgICAgICAgICA4NQpucl9yZXZlcnNlX21hcHMgICAgICAgMzIyOSAgICAg
ICAgICAgMzE5OApucl9tYXBwZWQgICAgICAgICAgICAgIDU5OSAgICAgICAgICAgIDU5OQpucl9z
bGFiICAgICAgICAgICAgICAgMTIwMyAgICAgICAgICAgMTE4NApwZ3BnaW4gICAgICAgICAgICAg
MTc2NzQzMiAgICAgICAgMTkxMTYxNApwZ3Bnb3V0ICAgICAgICAgICAgMTYwNjc0MyAgICAgICAg
MTc0NjQ5Nwpwc3dwaW4gICAgICAgICAgICAgIDMxMTI5NyAgICAgICAgIDMzODQzNgpwc3dwb3V0
ICAgICAgICAgICAgIDM3MTE2MSAgICAgICAgIDQwNjY3NQpwZ2FsbG9jICAgICAgICAgICAgMzAz
Nzk2MSAgICAgICAgMzA3MDgxMQpwZ2ZyZWUgICAgICAgICAgICAgMzA2MDgyNSAgICAgICAgMzA5
MzQyMApwZ2FjdGl2YXRlICAgICAgICAgIDE0MjMyOSAgICAgICAgIDEzNTYxNgpwZ2RlYWN0aXZh
dGUgICAgICAgIDUxNDY3MiAgICAgICAgIDUwNzAyNgpwZ2ZhdWx0ICAgICAgICAgICAgNDg5Njg3
NyAgICAgICAgNDkyODUzMApwZ21hamZhdWx0ICAgICAgICAgICA3NDM0MiAgICAgICAgICA4NDQ3
NgpwZ3NjYW4gICAgICAgICAgICAgMjc1MTk1MyAgICAgICAgNTMyODI2MCAgPD09ID8gaG1tCnBn
cmVmaWxsICAgICAgICAgICAxODIxNTYxICAgICAgICAxOTcyNzE1CnBnc3RlYWwgICAgICAgICAg
ICAgNTI4MDE0ICAgICAgICAgNTc1MzAxCnBnaW5vZGVzdGVhbCAgICAgICAgICAgICAwICAgICAg
ICAgICAgICAwCmtzd2FwZF9zdGVhbCAgICAgICAgMzgwMjgyICAgICAgICAgNTIyMTI2Cmtzd2Fw
ZF9pbm9kZXN0ZWFsICAgICA3MDEwICAgICAgICAgICA3MTMyCnBhZ2VvdXRydW4gICAgICAgICAg
ICAxMTA3ICAgICAgICAgICAxOTU2CmFsbG9jc3RhbGwgICAgICAgICAgICAzNDcyICAgICAgICAg
ICAxMjM4CnBncm90YXRlZCAgICAgICAgICAgMzU4MjQzICAgICAgICAgNDEzNDUwCg==
--=====================_17036437==_--

