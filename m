Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUJ3TJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUJ3TJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUJ3TJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:09:35 -0400
Received: from web51808.mail.yahoo.com ([206.190.38.239]:56155 "HELO
	web51808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261293AbUJ3TIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:08:54 -0400
Message-ID: <20041030190850.23015.qmail@web51808.mail.yahoo.com>
Date: Sat, 30 Oct 2004 12:08:50 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: md and multipathing
To: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20041030174802.GK32712@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars et all,

This what I am doing I believe.  Here is the command:

mdadm --create --force -lmp -n2 /dev/md0 /dev/sda
/dev/sdc

First controller is /dev/sda /dev/sdb (channel a and b
respective) and the second controller is /dev/sdc
/dev/sdd (again, channel a and b respecitve).

Here I am using multipath (enabled in kernel,
268,269,2610rc1) with the two paths to the FC volume.
I have found that it only drives one channel of the md
device as reported by vmstat.  More over, the traffic
appears to only go to the first device listed e.g. if
I change the ordering and use channel "b" first, than
all traffic to the md is driven on that channel.

Put another way, this is what I believe I have done:
device 0:0:0:0 + 1:0:0:0 = md0
device 0:0:0:1 + 1:0:0:1 = md1

scsi dev sda + sdc = md0
scsi dev sdb + sdd = md1

So have I done something wrong with the setup?  Am I
to question mdadm or md device?  

I get the exact same behavior as if I were to make the
device have a sprae path i.e. mdadm --create --force
-lmp -n1 -x1 /dev/md0 /dev/sda /dev/sdc,  but without
the failover device.  What I would want is to have
traffice be "exqually balanced" across both channels
(e.g. device paths /dev/sda /dev/sdc) with hopes that
this will improve my throughput.

Thanks!
Phy
--- Lars Marowsky-Bree <lmb@suse.de> wrote:

> On 2004-10-28T17:25:02, Phy Prabab
> <phyprabab@yahoo.com> wrote:
> 
> > I have a question concerning md driver: is there a
> way
> > to have a multipath md that is mulitplexed?
> 
> With 2.6, use the Device-Mapper multipath module.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX AG - A Novell company
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
