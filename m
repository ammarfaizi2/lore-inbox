Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262030AbRENHq2>; Mon, 14 May 2001 03:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbRENHqS>; Mon, 14 May 2001 03:46:18 -0400
Received: from mx.demos.su ([194.87.0.32]:29351 "EHLO demos.su")
	by vger.kernel.org with ESMTP id <S262030AbRENHqI>;
	Mon, 14 May 2001 03:46:08 -0400
Message-ID: <3AFFC427.7FC1F5E@cyberplat.ru>
Date: Mon, 14 May 2001 15:40:23 +0400
From: Oleg Makarenko <omakarenko@cyberplat.ru>
Organization: Cyberplat.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19-0.17.4 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, jgarzik@mandrakesoft.com
Subject: Re: netif_wake_queue wrong was: [PATCH] NFS Server performance and 
 8139too
In-Reply-To: <3AFE3870.3BB1B69@cyberplat.ru> <20010513125329.B10250@gruyere.muc.suse.de>
Content-Type: multipart/mixed;
 boundary="------------54C154790606E9505D44F52A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------54C154790606E9505D44F52A
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> 
> On Sun, May 13, 2001 at 11:32:00AM +0400, Oleg Makarenko wrote:
> > Beware that I am not a kernel hacker so the patch can be completely
> > wrong. But I hope it still can provide some useful information to
> > somebody  who really knows what is going on here :)
> 
> The problem is that the netif_wake_queue() 2.4 compatibility macro that
> was recently added to 2.2 was wrong. It should do a mark_bh(). 8139too
> uses the 2.4 macros, and therefore the netbh was always scheduled for too
> late and performance was bad.
> 
> This patch should fix all drivers that use the new framework.
> 

Unfortunately it doesn't. 8139too (and every other driver in 2.2.19 
source tree) uses its own version of netif_wake_queue(). So your patch
doesn't solve the problem with 8139too.

Here is another patch for 8139too that places mark_bh() into the 
netif_wake_queue() macro definition in 8139too.c. 

Or with you patch for kcomp.h is it now better to completely remove 
the macro redefinition from 8139too.c?

My first patch is more of reverse type as it places mark_bh() 
(that was lost) right after the netif_wake_queue() and 
calls mark_bh() more often than it wakes the queue in a manner 
of the older (working) 8139too version.

oleg
--------------54C154790606E9505D44F52A
Content-Type: application/octet-stream;
 name="linux-2.2.19-8139too.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-2.2.19-8139too.patch"

LS0tIGxpbnV4LTIuMi4yMHByZTIvZHJpdmVycy9uZXQvODEzOXRvby5jCU1vbiBNYXkgMTQg
MTE6MTY6MzAgMjAwMQorKysgbGludXgtbW9sZS9kcml2ZXJzL25ldC84MTM5dG9vLmMJTW9u
IE1heSAxNCAxMToxNzoyMiAyMDAxCkBAIC0xODcsNyArMTg3LDcgQEAKICNlbmRpZgogCiAj
ZGVmaW5lIGRldl9rZnJlZV9za2JfaXJxKGEpCWRldl9rZnJlZV9za2IoYSkKLSNkZWZpbmUg
bmV0aWZfd2FrZV9xdWV1ZShkZXYpCWNsZWFyX2JpdCgwLCAmZGV2LT50YnVzeSkKKyNkZWZp
bmUgbmV0aWZfd2FrZV9xdWV1ZShkZXYpCWRvIHsgY2xlYXJfYml0KDAsICZkZXYtPnRidXN5
KSA7IG1hcmtfYmgoTkVUX0JIKTsgfSB3aGlsZSgwKQogI2RlZmluZSBuZXRpZl9zdG9wX3F1
ZXVlKGRldikJc2V0X2JpdCgwLCAmZGV2LT50YnVzeSkKIAogc3RhdGljIGlubGluZSB2b2lk
IG5ldGlmX3N0YXJ0X3F1ZXVlKHN0cnVjdCBkZXZpY2UgKmRldikK
--------------54C154790606E9505D44F52A--


