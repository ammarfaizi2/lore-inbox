Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSCHXFK>; Fri, 8 Mar 2002 18:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSCHXFB>; Fri, 8 Mar 2002 18:05:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31695 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292150AbSCHXEv>; Fri, 8 Mar 2002 18:04:51 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
To: Chris Mason <mason@suse.com>
Cc: Hans Reiser <reiser@namesys.com>, Oliver.Schersand@BASF-IT-Services.com,
        Alessandro Suardi <alessandro.suardi@oracle.com>, use-oracle@suse.com,
        suse-linux-e@suse.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF2B363593.5EB4BFD2-ON88256B76.007E7246@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Fri, 8 Mar 2002 15:07:07 -0800
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/08/2002 04:04:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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



