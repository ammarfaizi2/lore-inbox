Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752177AbWIHEz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWIHEz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbWIHEz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:55:26 -0400
Received: from main.gmane.org ([80.91.229.2]:18873 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752177AbWIHEzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:55:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: re-reading the partition table on a "busy" drive
Date: Fri, 08 Sep 2006 07:55:12 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <450105C0.2010603@flower.upol.cz>
References: <45004707.4030703@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <45004707.4030703@tls.msk.ru>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Michael Tokarev wrote:
> Currently, the kernel refuses to re-read partition table
> from a drive which has usage count > 0.  Motivation for
> this is pretty clear ,
 >                        pretty annoying -- in order to change
> to reboot the machine.
> 
Yes, very interesting thing. While one will destroy its part.table, he can not 
see until reboot, heh. But there were days, when grub used to install itself on 
XFS partition (XFS isn't FAT-boot-record compatible) *silently*, but nothing 
was wrong to me : it's linux-gnu ;D

I would love just little kernel boot parameter to configure it, or sysctl in 
procfs.

> I wonder if it's possible to actually read the new partition
> table, compare it with previous, and apply changes IF they
> don't conflict with currently open partitions?  Say, if we
> have sda1 and sda2, sda1 is open/mounted, and new partition
> table does not have sda2, but sda1 is unchanged - it's pretty
> safe to apply new partition table, without affecting mounted
> sda1.  Ditto for adding new partitions.
> 
> Yes, a line should be drawn somewhere - say, if sda3 was
> mounted, and we removed unused sda2, but sda3 (which becomes
> sda2 with new table) is intact, we should not apply new
> table.
> 
> Is it possible to implement such a feature?  I mean, is it
> easy to know which *partitions* (subdevices?) of the whole
> device are currently in use, as opposed to the whole drive?
> 
IMHO you've wrote much more here, then just for not-so-useless-solution, that 
i've wrote above, unless you want another wind0s clever-heuristic with patches 
from happy users to lkml: <http://article.gmane.org/gmane.linux.kernel/437388>

> Thanks.
> 
> /mjt


-- 
-o--=O`C  /. .\   (+)
  #oo'L O      o    |
<___=E M    ^--    |  (you're barking up the wrong tree)

