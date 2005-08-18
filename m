Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVHRM6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVHRM6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHRM6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:58:09 -0400
Received: from [202.125.80.34] ([202.125.80.34]:8405 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932204AbVHRM6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:58:07 -0400
Content-class: urn:content-classes:message
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A3F3.9D924E1E"
Date: Thu, 18 Aug 2005 18:21:39 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3886@mail.esn.co.in>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWjW7/M/w4dBL4AQzGFNpoOjhzCRgAjG3FQ
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A3F3.9D924E1E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

I have few updates in this issue.
I have attached the Images as well as the mount-log to this mail.
Please see the comments inline.

>If the partition starts at sector 57 and is 28743 sectors long, then
>that matches 28800 sectors total.  No problem there.
>
>If on the other hand fdisk reports 28672 sectors total then there is a
>problem somewhere.

I think, fdisk it trying to portray that n/o cylinders 448. So, it also
takes care of displaying the relevant n/o sector & NO more or NO less.

>Well then you have to implement full partition support and present a
>seperate device for each partition in /dev so that mount can access
each
>partition.

I have implemented the partition support in the driver but some HOW I am
NOT able to get the driver working with all the sockets. It is just
working with the socket 0 and NO other socket.=20
I mean I am able to mount windows & linux formatted SD card with new
driver present from socket 0.

>> There is a partition table in the CAM formatted device & it looks
like
>> there is also a partition table in the win formatted device.
>> The details of there at offset 0x1BE are below.

I have an update on this.

I found some common things between the windows formatted SD & Linux
formatted SD.
I found that both of then do NOT have the partition table.
I found that both of them have FAT12 FS in the sector 0 starting at
offset 0.
Why? I am NOT able to guess.

For Windows formatted SD there is NO partition table at all.
I went on more R&D and tried to get to format the USB-Thumb drive.
Even that did NOT have a partition table.=20
It looks like windows treats all removable media device as devices with
NO partitions.

Even on Linux formatted SD there is NO partition table present.

Please have a look at the images I am attaching to this mail.
I have attached CAM-MS, WIN-Ms & Linux-MS first 512 byte length Images.
These are the Images of first 512 bytes of sector 0.
You can find the FS there on Lin & Win Images.

I have verified this by keeping some DEBUG messages in the FAT layer &
seeing what data is being passed to this fat_boot_sector structure when
mount call is issued.
I am also attaching those LOG messages. please Have a LOOK at them too &
you will have a fair understanding.

>That one looks more like random numbers.  Maybe the partition entry
that
>it really uses is not number 1, but number 2 3 or 4, or no partition
>table at all.
I have verified it with fdisk -l -u /dev/tfa0=20
It has shown that it is the partition 0 & nothing else.

>Could you do dd if=3D/dev/sda bs=3D512 count=3D1 | xxd
Please see the Images-All-MS-512.tar.gz.

Regards,
Mukund Jampala


------_=_NextPart_001_01C5A3F3.9D924E1E
Content-Type: application/x-gzip;
	name="Images-512-xxd-type.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: Images-512-xxd-type.tar.gz
Content-Disposition: attachment;
	filename="Images-512-xxd-type.tar.gz"

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

------_=_NextPart_001_01C5A3F3.9D924E1E
Content-Type: application/x-gzip;
	name="mount-logs-all.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: mount-logs-all.tar.gz
Content-Disposition: attachment;
	filename="mount-logs-all.tar.gz"

H4sIAMCCBEMAA+2dW3PjRpKF+3X0K7BPu/sgDxJ3OmxHkCCw69i1d8LdMS+OCQXVoroVlsRekuqx
99cvKOFUJvOQ6ovVjfYMKmIuTAFVha8KCdSpTPTN6u52e3q9erU5XVxf//nZpyhxnMVlnnf/e1/8
/97/f4nTWCSWJJdn3X9nkjyL8k/SG1fuNtvFOoqerVer7WPHvevvf9Bysz/+Dz9fLm6eso1Y4rjI
siPjn6Rl+jD+cZE+zBPJkrx4FsVP2Ylj5Z98/Jv6+7Mf7r7+azt98XX0zdvLxfbs1XJ7tjn/Lvr+
9u3ql+VFdHLgmMur6+uzzd2b5ZqPezjsXUdFm/Oz8/VycRFdbaKuye3V7avoZTcHu2Mu16ubaL+C
6OSnZjqPflr+791ys42605cvt6t19G0URy/v1uvl7fbsdn0WrPLNfzfz76Krh1b/5eSbv6z+vuuG
Gt7x9xevl9H52+XL0+/O355dL2+/jXJJTr65WJ1try5vzrbrxe3mcnfGfzU//fh19Jefvv/xxfc/
/kf0vOtBFJ+c311e/hz/Gv9t18Nfw29xvxP3O3W/M/c7d78L97t0vyv3e+J+T93vmftdu99z97tx
v1t/vQTAExCPQDwD8RDEUxCPQTwH8SDEkxCPQjwL8TDE0xCPQzyPxPNIaEZ4HonnkXgeieeReB6J
55F4HonnkXgeieeReB6J55F4HonnkXoeqeeR0i3ieaSeR+p5pJ5H6nmknkfqeaSeR+p5pJ5H6nmk
nkfqeWSeR+Z5ZJ5HRj7D88g8j8zzyDyPzPPIPI/M88g8j8zzyDyPzPPIPI/c88g9j9zzyD2PnJyo
55F7HrnnkXseueeRex6555F7HrnnkXseuedReB6F51F4HoXnUXgeBT1VPI/C8yg8j8LzKDyPwvMo
PI/C8yg8j8LzKD2P0vMoPY/S8yg9j9LzKOkx63mUnkfpeZSeR+l5lJ5H6XmUnkfpeVSeR+V5VJ5H
5XlUnkfleVSeR0XvHZ5H5XlUnkfleVSeR+V5VJ5H5XlMPI+J5zHxPCaex8TzmHgeE89j4nlM6EXM
85h4HhPPY+J5TDyPiecx8TymnsfU85h6HlPPY+p5TD2Pqecx9TymnseU3kw9j6nnMfU8pp7H1POY
eh4zz2Pmecw8j5nnMfM8Zp7HzPOYeR4zz2PmeczoVd3zmHkeM89j5nnMPI/a86g9j9rzqD2P2vOo
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

------_=_NextPart_001_01C5A3F3.9D924E1E--
