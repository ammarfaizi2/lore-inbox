Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCLKwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUCLKwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:52:23 -0500
Received: from ns.cohaesio.net ([212.97.129.16]:4793 "EHLO ns.cohaesio.net")
	by vger.kernel.org with ESMTP id S261410AbUCLKwV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:52:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.3 userspace freeze
Date: Fri, 12 Mar 2004 11:44:16 +0100
Message-ID: <222BE5975A4813449559163F8F8CF503458444@cohsrv1.cohaesio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.3 userspace freeze
Thread-Index: AcQIGgZDYBA+pesuToqxuSQSyRYWQAAAfjog
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: "Jan Kara" <jack@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Con Kolivas [mailto:kernel@kolivas.org] 
> Sent: Friday, March 12, 2004 11:09 AM
> To: Anders K. Pedersen
> Cc: Jan Kara; Andrew Morton; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.3 userspace freeze
> 
> 
> On Fri, 12 Mar 2004 07:47 pm, Anders K. Pedersen wrote:
> > To night I reproduced this issue with Linux 2.6.4 final - 
> I've attached
> > the dmesg and .config for this kernel.
> 
> > 23536 root      34  19  1664  720  1368 D N   6.0  0.0   0:00   1
> > updatedb
> 
> Each log you've shown so far shows you getting updatedb stuck 
> in D which 
> appears to be the common link. It could be your updatedb is 
> busy scanning 
> directories it probably shouldn't.
> Check your updatedb.conf (usually in /etc) and see that you 
> have at least 
> these entries in PRUNEFS
> 
> PRUNEFS="nfs,smbfs,ncpfs,proc,devpts,supermount,vfat,iso9660,u
> df,usbdevfs,devfs,usbfs,sysfs"

Thank you for the suggestion - I had the following in my updatedb.conf:

PRUNEFS="devpts NFS nfs afs proc smbfs autofs auto iso9660"

so I have just added:

PRUNEFS="$PRUNEFS ncpfs supermount vfat udf usbdevfs devfs usbfs sysfs"

Of these, the only active one is sysfs. I will give it another try with
these settings to night. However, while you're correct that top shows
updatedb in D state in the latest test (in the mail dated 2004-mar-12
09:47 - crashed at 04:02:21) as well as the first one I submitted (mail
dated 2004-mar-10 10:13 - crashed at 04:02:33), the one in between (mail
dated 2004-mar-11 01:46) doesn't as it crashed at 01:26:32, and updatedb
doesn't start until 04:02 as part of cron.daily. Also, when I originally
upgraded this server to 2.6.3 it rebooted four or five time during the
night, before we downgraded it to 2.4 again, and updatedb couldn't have
been the cause for more than one of these. One thing, I will try though,
is to run updatedb manually with and without the additions above to see
if it triggers the deadlock immediately.

Regards,
Anders K. Pedersen
