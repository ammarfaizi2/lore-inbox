Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGMjo>; Wed, 7 Feb 2001 07:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRBGMje>; Wed, 7 Feb 2001 07:39:34 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:64776 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129027AbRBGMjV>; Wed, 7 Feb 2001 07:39:21 -0500
Message-ID: <3A813A63.EBD1B768@namesys.com>
Date: Wed, 07 Feb 2001 15:06:59 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <monstr@namesys.com>,
        "zag@zag.botik.ru" <zag@zag.botik.ru>,
        Alexander Zarochentcev <zam@namesys.com>,
        Yury Shevchuk <sizif@botik.ru>,
        Vladimir Demidov <vladimir_493451@mtu-net.ru>,
        Vitaly Fertman <vetal@namesys.com>,
        Edward Shushkin <edward@mail.infotel.ru>,
        Nikita Danilov <god@namesys.com>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        Alexander Lyamin <flx@msu.ru>,
        "Elena V. Gryaznova" <grev@uchcom.botik.ru>,
        Chris Mason <mason@suse.com>, "gawain@torque.com" <gawain@torque.com>,
        "ragnar@bigstorage.com" <ragnar@bigstorage.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Apparent instability of reiserfs on 2.4.1
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that our number of users has increased, but I doubt that the increase is
sufficient to match the marked increase in bug reports on reiserfs-list.  Please
be patient as we work on this.  We will issue a patch this week that will fix
some bugs (NFS i_generation count losing, and space leakage on crash due to
preallocated blocks being lost). 

We will also change the default for mkreiserfs to creating the new 2.4 only
format, as this (we have belatedly realized) is probably the cause of many users
reporting they can't create large files.

We have a bug affecting add_entry which we suspect is due to our rename not
being adequately atomic and leaving hidden directory entries in the filesystem,
and we are exploring how this might happen (improper journaling, we don't yet
know....)  Treat this description with the usual skepticism attached to any
explanation of a bug not fixed yet, our diagnosing continues....  This is the
most worrisome bug for us stability wise.  It seems ~ a user a day encounters
it.  

This patch for sure also won't fix the zeros getting added to syslog files bug
which we are desperate to learn how to reproduce at our site.  

Thank you for your patience.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
