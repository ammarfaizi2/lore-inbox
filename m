Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbQLEAHA>; Mon, 4 Dec 2000 19:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbQLEAGk>; Mon, 4 Dec 2000 19:06:40 -0500
Received: from smtprch1.nortelnetworks.com ([192.135.215.14]:54737 "EHLO
	smtprch1.nortel.com") by vger.kernel.org with ESMTP
	id <S129547AbQLEAGI>; Mon, 4 Dec 2000 19:06:08 -0500
Message-ID: <3A2C29F8.D8D57F92@asiapacificm01.nt.com>
Date: Mon, 04 Dec 2000 23:34:16 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.16pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Boerner, Brian" <Brian_Boerner@adaptec.com>
CC: Keith Owens <kaos@ocs.com.au>,
        "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: Re: aacraid for 2.4.0
In-Reply-To: Your message of "Mon,
            04 Dec 2000 17:31:04 CDT." <E9EF680C48EAD311BDF400C04FA07B612D4D71@ntcexc02.ntc.adaptec.com> <1119.975970561@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 4 Dec 2000 17:31:04 -0500 ,
> "Boerner, Brian" <Brian_Boerner@adaptec.com> wrote:
> >The driver
> >is generating a segmentation fault and produces and oops. I have included
> >Code: 00 00 00 00 00 00 00 00 b8 00 00 00 83 ec 34 68 00 2c 82 c8
> 
> That code looks bad.  I suspect you are using an old modutils on
> current kernels.  modutils < 2.3.15 incorrectly load modules on recent
> kernels, you should be running modutils 2.3.21 for 2.4 kernels.

This can happen if you get your __devinit and __devinitdata declarations
tangled up.  If you have a table which is declared __devinit instead of
__devinitdata then subsequently declared functions end up with their
text being placed in the rodata section.  You only find out about this
because the assembler pads .align statements with nulls.  Hard to find.

So if the modutils upgrade doesn't help, remove all `init' thingies and
see if the problem goes away.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
