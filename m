Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbULPQxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbULPQxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULPQxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:53:51 -0500
Received: from magic.adaptec.com ([216.52.22.17]:50855 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261514AbULPQve convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:51:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Thu, 16 Dec 2004 11:51:28 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458B87DC14@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to add/drop SCSI drives from within the driver?
Thread-Index: AcTjhldH90Z2Gs2gTfOrzNQ7bn8ObAABzKDQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Matt Domsch" <Matt_Domsch@dell.com>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, <brking@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>, <bunk@fs.tum.de>,
       "Andrew Morton" <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 
>On Iau, 2004-12-16 at 09:54, Arjan van de Ven wrote:
>> I'm strongly against adding this. The reason for that is that once an
>> ioctl is added, it realistically will and can never go away.
>> LSI is free to have their own fork and give that to dell; but they
>> should and could have known that it wasn't going to fly. (same I
guess
>> for adaptec ioctls). The companies who then commit to some schedule
>> realize they take a huge risk, but that is no reason to foul up the
>> kernel more. 
>
>I agree. I'd like to see an agreed standard interface for dropping and
>managing physical volumes and drives, as well as a standard interface
>for dropping/managing logical volumes.

Simple transactions, perhaps, but there are many checks, balances and
complexities associated with a full management application that do not
make sense to reside in the kernel.

Aacraid uses a FIB to communicate a wide variety of RAID management
commands.
Dpt_i2o uses an I2O private frame to communicate the RAID management
commands.

The remaining ioctls pick up driver or OS internal information as has
been discussed thus far. Moving these pieces of information to sysfs
does make some sense.

However, in order to add the ability to manage the arrays, especially if
they follow the complexity of the container arrangement, hotspare
assignments, the multitude of array types and their configuration needs
and various other RAID or Cache policies; one will find the code sucked
into the driver to be a lead weight. Adding a `translation' layer from
FIB, I2O and other frames to a common set is *not* going to be
lightweight and will not be full coverage. The recent efforts by HP to
push CSMI added 30% to the size of the driver (Adaptec Branched
version). Yuck (this is a scientific term) and only added `monitoring'
and 'drive passthrough' capabilities.

Array status monitoring is complicated enough to pull out into an
application (the recent dropping of the firmware print messages and
replacement with the aeventd application).

By all means, let's set a standard for rudimentary array manipulation,
but let's not loose sight of the complicated needs of the consumers of
RAID equipment. Sysfs does not look like it will scale well towards a
full up management interface.

Sincerely -- Mark Salyzyn
