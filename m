Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbQKDHkH>; Sat, 4 Nov 2000 02:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbQKDHj4>; Sat, 4 Nov 2000 02:39:56 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:32662 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S132500AbQKDHjy>; Sat, 4 Nov 2000 02:39:54 -0500
Message-ID: <3A03BD47.4FBD876B@oracle.com>
Date: Fri, 03 Nov 2000 23:39:52 -0800
From: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Organization: Linux Strategic Business Unit, Oracle Corporation
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
In-Reply-To: <3A030EE2.92DC3F2@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------FE57304BDD6A055B3A678586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FE57304BDD6A055B3A678586
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Additional follow up.

The idea of modifying this variable is to increase the amount of memory that a
process can use.  A database like Oracle can benefit from this because it allows
Oracle to create a bigger data buffer.

An obvious side effect of allocating more physical memory to a process is that there
is less available for other things like the kernel buffer cache.  This brings up a
question.  Would a write of a data block from the Oracle data buffer incur a "read
penalty" if the block is not in the buffer cache?

For example, a data block is read by Oracle into its buffer.  Since it is read
through the file system, this block is now present in the buffer cache too.  After a
while, and since we have allocated most of the memory to Oracle, that block is
removed/replaced from the cache.

Now a transaction modifies that block in Oracle's buffer and Oracle writes it to
disk.  Does the kernel firsts reads that block into the buffer cache, "read
penalty", and then writes it to disk? Or does it just write through the buffer cache
now placing the block in the kernel buffer cache?

Regards,

--
=======================================================================
  Josue Emmanuel Amaro                         Josue.Amaro@oracle.com
  Linux Products Manager                       Phone:   650.506.1239
  Intel and Linux Technologies Group           Fax:     650.413.0167
=======================================================================


--------------FE57304BDD6A055B3A678586
Content-Type: text/x-vcard; charset=us-ascii;
 name="Josue.Amaro.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Josue Emmanuel Amaro
Content-Disposition: attachment;
 filename="Josue.Amaro.vcf"

begin:vcard 
n:Amaro;Josue Emmanuel
tel;cell:650-245-5131
tel;fax:650-413-0167
tel;work:650-506-1239
x-mozilla-html:FALSE
url:http://www.oracle.com
org:Intel and Linux Technologies
version:2.1
email;internet:Josue.Amaro@oracle.com
title:Sr.Product Manager - Linux
adr;quoted-printable:;;500 Oracle Parkway=0D=0AMS1ip4;Redwood Shores;CA;94065;United States
fn:Josue Emmanuel Amaro
end:vcard

--------------FE57304BDD6A055B3A678586--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
