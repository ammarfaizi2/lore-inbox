Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbTFCJlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbTFCJlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:41:04 -0400
Received: from camus.xss.co.at ([194.152.162.19]:51981 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264852AbTFCJlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:41:01 -0400
Message-ID: <3EDC7052.9060109@xss.co.at>
Date: Tue, 03 Jun 2003 11:54:26 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at> <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Alan Cox wrote:
> On Llu, 2003-06-02 at 20:40, Andreas Haumer wrote:
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Hi!
>>
>>(I've already reported this previously as post scriptum
>>to a different bugreport, so it might have slipped through
>>unnoticed...)
>
>
> Does this occur if you boot with "notsc" or if you run a non ACPI kernel
> ?
>
I did some more tests on this machine, with the following
results:

1.) Kernel 2.4.21-rc6-ac1 (ACPI compiled as module)
    a) no special kernel commandline option
       -> System doesn't boot, fusion MPT driver doesn't find
          the hardware listed on the PCI bus (problem already
          reported in a previous mail)

    b) boot with "acpi=off"
       -> System does boot, fusion MTP driver finds the controller
       -> time runs 2.5 times too fast

    c) boot with "acpi=off notsc"
       -> same as 1b)

2.) Kernel 2.4.21-rc4 (ACPI compiled as module)
    a) no special kernel commandline option
       -> System does boot, fusion MTP driver finds the controller
       -> time runs 2.5 times too fast

    b) boot with "acpi=off"
       -> Same as 2a)

    c) boot with "acpi=off notsc"
       -> Same as 2a)

3.) Kernel 2.4.21-rc2-ac2 (ACPI compiled as module)
    a) no special kernel commandline option
       -> System doesn't boot, fusion MPT driver doesn't find
          the hardware listed on the PCI bus

    b) boot with "acpi=off"
       -> System does boot, fusion MTP driver finds the controller
       -> time runs 2.5 times too fast

    c) boot with "acpi=off notsc"
       -> same as 3b)


4.) Kernel 2.4.21-rc6-ac1 (without ACPI)
    a) no special kernel commandline option
       -> System does boot, fusion MTP driver finds the controller
       -> time runs 2.5 times too fast

    b) boot with "notsc"
       -> Same as 4a)

5.) Kernel 2.4.21-rc4 (ACPI compiled as module)
    floppy-minisystem, booting into initrd only
    modules loaded: unix.o. ext2.o, floppy.o
    -> time runs 2.5 times too fast


Time "acceleration" always seems to be by a factor of exactly 2.5
Proof:
root@setup:~ {502} $ ntpdate ntp.xss.co.at; sleep 300; ntpdate ntp.xss.co.at
 3 Jun 11:31:52 ntpdate[1185]: step time server 194.152.162.17 offset -895.898772 sec
 3 Jun 11:33:52 ntpdate[1187]: step time server 194.152.162.17 offset -180.088187 sec

(I first sync the system clock with our NTP timeserver, then sleep
300 seconds, and then again sync against our NTP server)

Sleeping 300 "system seconds" takes 120 "wall clock seconds" and
brings the system clock ahead of 180 seconds, which gives a speed
up factor of 2.5. Does this number ring any bell?

Additional info: I'm booting with LILO and have set LILO timeout
to 10 seconds. This works fine: "LILO time" is the same as wall
clock time. So this speed up must be triggered somewhere inside
the kernel, it seems...

Any idea someone?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3HBPxJmyeGcXPhERAplBAKCYqTbno0EnP9WqKwtzXyUjBCUosgCfT7qw
vfPbba5yqYD0qUI9BDJBD40=
=i+JF
-----END PGP SIGNATURE-----

