Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281391AbRKPPrM>; Fri, 16 Nov 2001 10:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbRKPPrD>; Fri, 16 Nov 2001 10:47:03 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:2568 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S281391AbRKPPqw>; Fri, 16 Nov 2001 10:46:52 -0500
Message-Id: <200111152350.fAFNoDI08622@numbat.os2.ami.com.au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: summer@os2.ami.com.au, Linux kernel <linux-kernel@vger.kernel.org>,
        summer@numbat.os2.ami.com.au
Subject: Re: BOOTP and 2.4.14 
In-Reply-To: Message from Peter =?iso-8859-1?Q?W=E4chtler?= 
 <pwaechtler@loewe-komp.de>
   of "Thu, 15 Nov 2001 22:13:55 +0100." <3BF43013.30433D08@loewe-komp.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Nov 2001 07:50:13 +0800
From: summer@os2.ami.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> summer@os2.ami.com.au schrieb:
> > 
> > I'm trying to configure a system to boot with root on NFS. I have it
> > working, but there are problems.
> > 
> > The most serious are that the DNS domain name is set wrongly, and NIS
> > domain's not set at all.
> > 
> > The IP address offered and accepted in 192.168.1.20.
> > 
> > The DNS domain name being set is 168.1.20, and the host name 192.
> > 
> 
> 
> Uh, how about to specify a NAME.DOMAIN.COM instead of an 
> dotted IP. Check your bootp configuration.


The IP address being offered does not need to resolve; if I configure 
it to update my DNS, then at the time it's offered it will not resolve.

Here's the stanza from /etc/dhcpd.conf

                host banana
                        {
                                fixed-address 192.168.1.20;
                                option host-name "banana";
                        }


BUT the stanza's not required at all.

> 
> > I'm looking at the ipconfig.c source, around line 1324 where I see this
> > code:
> >                         case 4:
> >                                 if ((dp = strchr(ip, '.'))) {
> >                                         *dp++ = '\0';
> >                                         strncpy(system_utsname.domainname, dp, __NEW_UTS_LEN);
> >                                         system_utsname.domainname[__NEW_UTS_LEN] = '\0';
> >                                 }
> >                                 strncpy(system_utsname.nodename, ip, __NEW_UTS_LEN);
> >                                 system_utsname.nodename[__NEW_UTS_LEN] = '\0';
> >                                 ic_host_name_set = 1;
> >                                 break;
> > 
> > I can see how the dnsdomain name's being set, and it does not look
> > right to me.
> > 
> > If someone can prepare a patch for me, I'll be delighted to test it.
> >
> 

-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.



