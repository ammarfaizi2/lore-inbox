Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSEFDAZ>; Sun, 5 May 2002 23:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314081AbSEFDAZ>; Sun, 5 May 2002 23:00:25 -0400
Received: from [211.150.129.83] ([211.150.129.83]:51846 "EHLO discovery")
	by vger.kernel.org with ESMTP id <S314080AbSEFDAX>;
	Sun, 5 May 2002 23:00:23 -0400
Date: Mon, 6 May 2002 10:50:25 +0800
From: hugang <gang_hu@soul.com.cn>
To: Jeff Dike <jdike@karaya.com>
Cc: glonnon@ridgerun.com, pavel@suse.cz, seasons@fornax.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software to UML.
Message-Id: <20020506105025.217b96e6.gang_hu@soul.com.cn>
In-Reply-To: <200205060022.TAA03703@ccure.karaya.com>
Organization: soul
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__6_May_2002_10:50:25_+0800_081e0730"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__6_May_2002_10:50:25_+0800_081e0730
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 May 2002 19:22:39 -0500
Jeff Dike <jdike@karaya.com> wrote:

> gang_hu@soul.com.cn said:
> > Ther problem in bread.
> 
> No, the problem is in not understanding UML.
> 
> UML's state is somewhat more complicated than the state of a native kernel.
> 
> You also need to recreate 
> 	the host processes
> 	the ptrace relationships between the tracing thread and the other 
> processes
> 	open file descriptors
> 	and maybe a few other things that aren't coming to mind
> 
> 				Jeff

Now , I found the Problem. Fix that have two way 
--1 after the register disk , We not close it.
--2 at prepare_request , We check the dev->count, it not open , must open it first.

The 1.diff is use the 1 way.
the 2.diff is use the 2 way.

Which is the best?
  
-- 
thanks with regards!
hugang.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************


--Multipart_Mon__6_May_2002_10:50:25_+0800_081e0730
Content-Type: text/plain;
 name="2.diff"
Content-Disposition: attachment;
 filename="2.diff"
Content-Transfer-Encoding: base64

LS0tIHViZC5jfglNb24gTWF5ICA2IDEwOjQyOjU2IDIwMDIKKysrIHViZC5jLjIJTW9uIE1heSAg
NiAxMDo0NjowNiAyMDAyCkBAIC03MjAsNyArNzIwLDIyIEBACiAJCWVuZF9yZXF1ZXN0KDApOwog
CQlyZXR1cm4oMSk7CiAJfQotCisJaWYoIWRldi0+Y291bnQpIHsKKwkJaWYgKGRldi0+ZmlsZSkg
eworCQkJaWYodWJkX29wZW5fZGV2KGRldikgPCAwKXsKKwkJCQlwcmludGsoS0VSTl9FUlIgInVu
YWJsZSB0byBvcGVuICVzIGZvciB2YWxpZGF0aW9uXG4iLAorCQkJCSAgICAgICBkZXYtPmZpbGUp
OworCQkJCXJldHVybiAxOworCQkJfQorCQl9IGVsc2UgIHJldHVybiAxOworCQkKKwkJLyogaGF2
ZSB0byByZWNvbXB1dGUgc2l6ZXMgc2luY2Ugd2Ugb3BlbmVkIGl0ICovCisJCWVyciA9IHViZF9m
aWxlX3NpemUoZGV2LCAmZGV2LT5zaXplKTsKKwkJaWYoZXJyKSB7CisJCQl1YmRfY2xvc2UoZGV2
KTsKKwkJCXJldHVybiAxOworCQl9CisJfQogICAgICAgICByZXEtPnNlY3RvciArPSB1YmRfcGFy
dFttaW5vcl0uc3RhcnRfc2VjdDsKICAgICAgICAgYmxvY2sgPSByZXEtPnNlY3RvcjsKICAgICAg
ICAgbnNlY3QgPSByZXEtPmN1cnJlbnRfbnJfc2VjdG9yczsK

--Multipart_Mon__6_May_2002_10:50:25_+0800_081e0730
Content-Type: text/plain;
 name="1.diff"
Content-Disposition: attachment;
 filename="1.diff"
Content-Transfer-Encoding: base64

LS0tIHViZC5jfglNb24gTWF5ICA2IDEwOjQyOjU2IDIwMDIKKysrIHViZC5jCU1vbiBNYXkgIDYg
MTA6NDk6MTEgMjAwMgpAQCAtODg4LDMzICs4ODgsMjYgQEAKIAkvKiBJZiBpdCBhbHJlYWR5IGhh
cyBiZWVuIG9wZW5lZCB3ZSBjYW4gY2hlY2sgdGhlIHBhcnRpdGlvbnMgCiAJICogZGlyZWN0bHkg
CiAJICovCi0JaWYoZGV2LT5jb3VudCl7Ci0JCXBhcnQtPnN0YXJ0X3NlY3QgPSAwOwotCQlyZWdp
c3Rlcl9kaXNrKCZ1YmRfZ2VuZGlzaywgTUtERVYoTUFKT1JfTlIsIG9mZnNldCksIHBjb3VudCwg
Ci0JCQkgICAgICAmdWJkX2Jsb3BzLCBwYXJ0LT5ucl9zZWN0cyk7Ci0JfSAKLQllbHNlIGlmKGRl
di0+ZmlsZSl7Ci0JCWlmKHViZF9vcGVuX2RldihkZXYpIDwgMCl7Ci0JCQlwcmludGsoS0VSTl9F
UlIgInVuYWJsZSB0byBvcGVuICVzIGZvciB2YWxpZGF0aW9uXG4iLAotCQkJICAgICAgIGRldi0+
ZmlsZSk7Ci0JCQlyZXR1cm4gMTsKLQkJfQotCisJcGFydC0+c3RhcnRfc2VjdCA9IDA7CisJaWYo
IWRldi0+Y291bnQpIHsKKwkJaWYgKGRldi0+ZmlsZSkgeworCQkJaWYodWJkX29wZW5fZGV2KGRl
dikgPCAwKXsKKwkJCQlwcmludGsoS0VSTl9FUlIgInVuYWJsZSB0byBvcGVuICVzIGZvciB2YWxp
ZGF0aW9uXG4iLAorCQkJCSAgICAgICBkZXYtPmZpbGUpOworCQkJCXJldHVybiAxOworCQkJfQor
CQl9IGVsc2UgIHJldHVybiAxOworCQkKIAkJLyogaGF2ZSB0byByZWNvbXB1dGUgc2l6ZXMgc2lu
Y2Ugd2Ugb3BlbmVkIGl0ICovCiAJCWVyciA9IHViZF9maWxlX3NpemUoZGV2LCAmZGV2LT5zaXpl
KTsKIAkJaWYoZXJyKSB7CiAJCQl1YmRfY2xvc2UoZGV2KTsKIAkJCXJldHVybiAxOwogCQl9Ci0J
CXBhcnQtPnN0YXJ0X3NlY3QgPSAwOwogCQlwYXJ0LT5ucl9zZWN0cyA9IGRldi0+c2l6ZSAvIGhh
cmRzZWN0X3NpemVzW29mZnNldF07Ci0JCXJlZ2lzdGVyX2Rpc2soJnViZF9nZW5kaXNrLCBNS0RF
VihNQUpPUl9OUiwgb2Zmc2V0KSwgcGNvdW50LCAKLQkJCSAgICAgICZ1YmRfYmxvcHMsIHBhcnQt
Pm5yX3NlY3RzKTsKLQotCQkvKiB3ZSBhcmUgZG9uZSBzbyBjbG9zZSBpdCAqLwotCQl1YmRfY2xv
c2UoZGV2KTsKLQl9IAotCWVsc2UgcmV0dXJuKDEpOworCX0KKwlyZWdpc3Rlcl9kaXNrKCZ1YmRf
Z2VuZGlzaywgTUtERVYoTUFKT1JfTlIsIG9mZnNldCksIHBjb3VudCwgCisJCSAgICAgICZ1YmRf
YmxvcHMsIHBhcnQtPm5yX3NlY3RzKTsKIAlyZXR1cm4oMCk7CiB9CiAK

--Multipart_Mon__6_May_2002_10:50:25_+0800_081e0730--
