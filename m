Return-Path: <linux-kernel-owner+w=401wt.eu-S1751287AbXAKRrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAKRrO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXAKRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:47:14 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:35106 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751287AbXAKRrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:47:13 -0500
Date: Thu, 11 Jan 2007 09:40:57 -0800 (PST)
From: David Lang <david.lang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Arnd Bergmann <arnd@arndb.de>
cc: kvm-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>,
       Avi Kivity <avi@qumranet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
In-Reply-To: <200701110834.43800.arnd@arndb.de>
Message-ID: <Pine.LNX.4.63.0701110935570.11166@qynat.qvtvafvgr.pbz>
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org>
 <200701110834.43800.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-701591430-1168537257=:11166"
X-Tablus-Inspected: yes
X-Tablus-Classifications: public
X-Tablus-Action: allow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-701591430-1168537257=:11166
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by blackbird.diginsite.com id l0BHlCFY012350

On Thu, 11 Jan 2007, Arnd Bergmann wrote:

> On Tuesday 09 January 2007 14:47, Jeff Garzik wrote:
>> Can we please avoid adding a ton of new ioctls? =A0ioctls inevitably
>> require 64-bit compat code for certain architectures, whereas
>> sysfs/procfs does not.
>
> For performance reasons, an ascii string based interface is not
> desireable here, some of these calls should be optimized to
> the point of counting cycles.

why is this? most of the API that is being discussed is run once when the=
 VM is=20
being setup.

there may be some calls that are performance sensitive, but for things li=
ke=20
seperating the page tables, the cost of doing the work will swamp any ASC=
II=20
conversion costs.

David Lang

> Sysfs also does not fit the use case at all, and procfs only
> makes sense if you really want to keep all information about the
> guest as part of the process directory it belongs to.
>
> I still think that in the long term, we should migrate to
> new system calls and a special file system for kvm, which
> might be non-mountable. Those will of course have the same
> 32 bit compat problems as the ioctl approach, but so far,
> Avi has kept a good watch on avoiding these problems.
>
> As long as we think the interface is likely to change (which it
> certainly is right now), I believe that ioctl is the right
> interface. We can think about retiring it when the interface has
> stabilized enough to be converted to syscalls.
>
> 	Arnd <><
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
--8323328-701591430-1168537257=:11166--
