Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293637AbSCKIOo>; Mon, 11 Mar 2002 03:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293638AbSCKIOf>; Mon, 11 Mar 2002 03:14:35 -0500
Received: from basfegw1.basf-ag.de ([141.6.1.21]:19923 "EHLO
	basfegw1.basf-ag.de") by vger.kernel.org with ESMTP
	id <S293637AbSCKIO1>; Mon, 11 Mar 2002 03:14:27 -0500
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
To: mason@suse.com
Cc: reiser@namesys.com, alessandro.suardi@oracle.com, suse-oracle@suse.com,
        linux-kernel@vger.kernel.org, gehringg@de.ibm.com,
        Bjoern.Macdonald@BASF-IT-Services.com
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OF070BECE8.C0D4D94E-ONC1256B79.002A45CA@bcs.de>
From: Oliver.Schersand@BASF-IT-Services.com
Date: Mon, 11 Mar 2002 09:16:04 +0100
X-MIMETrack: Serialize by Router on EUROPE-Gw03/EUROPE/BASF(Release 5.0.8 |June 18, 2001) at
 11/03/2002 09:14:18
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have switch to kernel 2.2.19. But after about 5 day's ( Friday )  i had a
the same hang on the system. which leads me to the
diagnostic that we have a possible hardware problem or a problem in the
compaq smart array or compaq 5300 Raid Array controller
driver. On 2.2.19 i have cpqarray 1.0.12 and cciss 1.0.4. On the 2.4.16
kernel i have the cpqarray 2.4.5 and the cciss 2.4.6.

Kinds Regards

Oliver Schersand

---------------------- Weitergeleitet von Oliver Schersand/BCS/BASF am
11.03.2002 08:43 ---------------------------


"James Washer" <washer@us.ibm.com> am 09.03.2002 00:07:07

An:    Chris Mason <mason@suse.com>
Kopie: Hans Reiser <reiser@namesys.com>, Oliver Schersand/BCS/BASF@EUROPE,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       use-oracle@suse.com, suse-linux-e@suse.com,
       linux-kernel@vger.kernel.org
Thema: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie
       TSM




Chris,

I just took a look at what little information I have available on this
situation.. Namely the 'block-o-oops' from many ps processes..

I'm not sure I agree with you that it is a race in proc code. There are
several ps processes that oops'd over a period of 58 seconds. My guess is
that there is (was)  a process out there that has a corrupt  p->sig (==
0x00003296).  Hence, each time the user runs ps, the new ps trips over the
same corrupt task.

What really confuses me is what any of this has to do with the original
complaint about the system hanging.. Has that behaviour gone away?

 - jim

Chris Mason <mason@suse.com>@vger.kernel.org on 03/05/2002 09:06:43 AM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    Hans Reiser <reiser@namesys.com>,
       Oliver.Schersand@BASF-IT-Services.com
cc:    Alessandro Suardi <alessandro.suardi@oracle.com>,
       use-oracle@suse.com, suse-linux-e@suse.com,
       linux-kernel@vger.kernel.org
Subject:    Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and
       Tivolie TSM





On Monday, March 04, 2002 06:07:19 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:


> Wasn't 2.4.16 the known unstable vm release of 2.4?  Why do you go to
> such effort to stick with a bad kernel?  Go to 2.4.18.

I'm not sure exactly which vm problems you mean, but He's running the
suse 2.4.16, which is heavily patched. When your running big production
databases, upgrading to the kernel of the week isn't an option.

I think we've found the bug, it looks like a race in the proc code.

Oliver, someone will contact you a little later with instructions on
getting a kernel with the fix.  If you only see this oops during backups,
make sure you aren't trying to backup /proc.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/






