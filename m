Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTJUSns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJUSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:43:48 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:34694 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S263214AbTJUSnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:43:45 -0400
Message-ID: <34364.192.168.9.10.1066761821.squirrel@ncircle.nullnet.fi>
In-Reply-To: <200310202325.05384.bzolnier@elka.pw.edu.pl>
References: <001901c39734$8a2c2bb0$0514a8c0@HUSH>
    <31727.1066684060@www30.gmx.net>
    <200310202325.05384.bzolnier@elka.pw.edu.pl>
Date: Tue, 21 Oct 2003 21:43:41 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "Svetoslav Slavtchev" <svetljo@gmx.de>,
       "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bartlomiej,

> multicount affects PIO transfers performance only...

This makes sense as I was finally able to run some tests
and hdparm -m doesn't seem to affect anything.

However, do the following errors tell you anything new ?
(They were seen while copying almost 40GB of files from
one RAID1-mirror (hpt374) to second RAID1-mirror(

>
> On Monday 20 of October 2003 23:07, Svetoslav Slavtchev wrote:
>> > BTW, isn't m0 supposed to reduce perfomance?
>>
>> hm here it also doesn't seem to change much,
>> may be it's ignored if UDMA is used
>>
>> mem is 1024Mb
>>
>> [root@svetljo kernel]#  hdparm -m0 /dev/hde
>>
>> /dev/hde:
>>  setting multcount to 0
>>  multcount    =  0 (off)
>>
>> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
>> 20000+0 records in
>> 20000+0 records out
>> 0.09user 29.38system 5:44.49elapsed 8%CPU (0avgtext+0avgdata
>> 0maxresident)k
>> 0inputs+0outputs (149major+40minor)pagefaults 0swaps
>> [root@svetljo 1]#  hdparm -m8 /dev/hde
>>
>> /dev/hde:
>>  setting multcount to 8
>>  multcount    =  8 (on)
>> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
>> 20000+0 records in
>> 20000+0 records out
>> 0.10user 28.99system 5:50.44elapsed 8%CPU (0avgtext+0avgdata
>> 0maxresident)k
>> 0inputs+0outputs (150major+41minor)pagefaults 0swaps
>>
>> root@svetljo 1]#  hdparm -m16 /dev/hde
>>
>> /dev/hde:
>>  setting multcount to 16
>>  multcount    = 16 (on)
>> [root@svetljo 1]# time dd if=/dev/zero of=10Gb.zeros count=20000 bs=512k
>> 20000+0 records in
>> 20000+0 records out
>> 0.09user 28.83system 5:53.57elapsed 8%CPU (0avgtext+0avgdata
>> 0maxresident)k
>> 0inputs+0outputs (165major+40minor)pagefaults 0swaps
>> [root@svetljo 1]#
>>
>> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
>> > bs=65536
>> > 20000+0 records in
>> > 20000+0 records out
>> >
>> > real    0m33.763s
>> > user    0m0.200s
>> > sys     0m10.920s
>> > [root@fulanito wd1200jb]# hdparm -m4 /dev/hdk
>> >
>> > /dev/hdk:
>> >  setting multcount to 4
>> >  multcount    =  4 (on)
>> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
>> > bs=65536
>> > 20000+0 records in
>> > 20000+0 records out
>> >
>> > real    0m30.321s
>> > user    0m0.150s
>> > sys     0m10.630s
>> > [root@fulanito wd1200jb]# hdparm -m0 /dev/hdk
>> >
>> > /dev/hdk:
>> >  setting multcount to 0
>> >  multcount    =  0 (off)
>> > [root@fulanito wd1200jb]# time dd if=/dev/zero of=filling count=20000
>> > bs=65536
>> > 20000+0 records in
>> > 20000+0 records out
>> >
>> > real    0m30.749s
>> > user    0m0.130s
>> > sys     0m10.900s
>> > [root@fulanito wd1200jb]#
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Tomi.Orava@ncircle.nullnet.fi
