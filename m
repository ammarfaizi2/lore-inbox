Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUFLIok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUFLIok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 04:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUFLIok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 04:44:40 -0400
Received: from [202.125.86.130] ([202.125.86.130]:19087 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264686AbUFLIoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 04:44:30 -0400
Content-class: urn:content-classes:message
Subject: RE: Problem in module loading automatically at boot time
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C45059.8CA46026"
Date: Sat, 12 Jun 2004 14:15:00 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <1118873EE1755348B4812EA29C55A9722AF3B7@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Problem in module loading automatically at boot time
Thread-Index: AcRP1ZAnMoGb2mqjQWe1IEkOaz+GQAAgr8eg
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>,
       "Subramanyam B" <subramanyamb@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C45059.8CA46026
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Johnson,

I tried with depmod -e option. It showed that printk is unresolved
symbol. Is it current? Is it(printk) not a kernel symbol? If so, give me
a suggestion.

Note: I included the <linux/kernel.h> and <linux/module.h> also. Please
see the attachments.

Thanks and regards,

Srinivas G

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com]=20
Sent: Friday, June 11, 2004 10:29 PM
To: Srinivas G.
Cc: linux-kernel@vger.kernel.org; Surendra I.; Subramanyam B
Subject: Re: Problem in module loading automatically at boot time

On Fri, 11 Jun 2004, Srinivas G. wrote:

>
> Hi,
>
> I have written a small driver program called hello.c.
>
>
************************************************************************
> ***************
> #include <linux/module.h>
>
> MODULE_LICENSE("GPL");
>
> int init_module(void)
> {
>   printk("<1>" "Hello world\n");
>   return 0;
> }
>
> void cleanup_module(void)
> {
>   printk("<1>good bye\n");
> }
>
>
************************************************************************
> ****************
>
> I compiled the above program with cc -DMODULE -D__KERNEL__
> -I/usr/src/linux2.4/include -O2 -c hello.c
>
> I am using Red Hat Linux 7.3 with kernel version of 2.4.18-3.
> It works fine when I load it with insmod from root prompt.
>
> Now, I want to make it load automatically at boot time.
> For that I have used the following steps.
>
> ---> I copied the hello.o file in the
> /lib/modules/2.4.18-3/kernel/drivers/block
>
> ---> I run the depmod command. It included the above path in
> /lib/modules/2.4.18-3/modules.dep file.
>
> ---> I added "alias hello1 hello" entry into /etc/modules.conf file.
>
> When I reboot the machine after the above changes, my driver is not
> loaded and an error message is printed as follows.
>
> ---> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-3/kernel/drivers/block/hello.o
>
>
> Could anyone suggest me, if I am missing anything here?
>
> Srinivas G
>

Maybe `depmod -e ...` would tell you what symbols are missing??

Then, after you observe that, try including <linux/kernel.h>,
and <linux/module.h>, like you are supposed to do.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



------_=_NextPart_001_01C45059.8CA46026
Content-Type: application/octet-stream;
	name="hello.c"
Content-Transfer-Encoding: base64
Content-Description: hello.c
Content-Disposition: attachment;
	filename="hello.c"

LyoKICogU2ltcGxlIGhlbGxvLmMgcHJvZ3JhbQogKi8KCi8qIGtlcm5lbCBoZWFkZXIgZmlsZXMg
Ki8KI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4gICAgICAgLyogZm9yIGV4cGxpY2l0IGluaXQgJiBl
eGl0IG1hcmNvIGRlZmluaXRpb25zICovCiNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4gICAgIC8q
IGZvciBwcmludGsgKi8KI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPiAgICAgLyogZm9yIGV2ZXJ5
dGhpbmcgLi4uICovCQoKTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwpNT0RVTEVfQVVUSE9SKCJTUklO
SVZBUyBHIik7CgovKgogKiBNb2R1bGUgZW50cnkgcG9pbnQKICovIApzdGF0aWMgaW50IApfX2lu
aXQgaGVsbG9faW5pdCh2b2lkKQp7CglwcmludGsoIkhlbGxvLCBXZWxjb21lIHRvIERldmljZSBE
cml2ZXIgV29ybGQhXG4iKTsKCXJldHVybiAwOwp9CgovKgogKiBNb2R1bGUgZXhpdCBwb2ludAog
Ki8Kc3RhdGljIHZvaWQKX19leGl0IGhlbGxvX2V4aXQodm9pZCkKewoJcHJpbnRrKCJHb29kIEJ5
ZSB0byBEZXZpY2UgRHJpdmVyIFdvcmxkIVxuIik7Cn0KCi8qIG1hY3JvcyB0byBkZWZpbmUgaW5p
dCBhbmQgZXhpdCBtb2R1bGVzICovCm1vZHVsZV9pbml0KGhlbGxvX2luaXQpOwptb2R1bGVfZXhp
dChoZWxsb19leGl0KTsKCgo=

------_=_NextPart_001_01C45059.8CA46026
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

IwojIE1ha2UgZmlsZSBmb3IgaGVsbG8uYyBmaWxlCiMKCklOQ0RJUj0vdXNyL3NyYy9saW51eC0y
LjQvaW5jbHVkZQkjIEluY2x1ZGUgcGF0aCBvbiBSZWRIYXQgNy4zCgpUQVJHRVQ9aGVsbG9kZW1v
Lm8KT0JKUz1oZWxsby5vCgpDRkxBR1M9LURNT0RVTEUgLURfX0tFUk5FTF9fIC1JJChJTkNESVIp
IC1PMiAKCiQoVEFSR0VUKTogJChPQkpTKQoJJChMRCkgLXIgLW8gJChUQVJHRVQpICQoT0JKUykK
CmNsZWFuOgoJJChSTSkgJChUQVJHRVQpICQoT0JKUykKCg==

------_=_NextPart_001_01C45059.8CA46026--
