Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVCOUsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVCOUsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVCOUrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:47:03 -0500
Received: from smtp2.eldosales.com ([63.78.12.18]:57862 "EHLO
	tweeter.eldosales.com") by vger.kernel.org with ESMTP
	id S261850AbVCOUnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:43:50 -0500
Posted-Date: Tue, 15 Mar 2005 13:43:47 -0700
Subject: Re: qla2xxx fail over support
From: comsatcat <comsatcat@earthlink.net>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20050314231630.GB8548@plap.qlogic.org>
References: <1110838136.12171.4.camel@solaris.zataoh.com>
	 <20050314231630.GB8548@plap.qlogic.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 13:43:52 -0700
Message-Id: <1110919432.11160.6.camel@solaris.zataoh.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunantly all the beta drivers seem to have issues working with
mcdata switches.  I've tried about 10 different versions available from
qlogic's ftp and all of them give trace messages and "scheduling while
atomic" messages when detecting luns that are going through the mcdata
switch.  any suggestions would be appreciated (along with whom to
contact at qlogic regarding beta driver development).

<-- syslog snippit when loading drivers -->
Mar 15 13:39:35 src@fe-nntp-02 Call Trace:<ffffffff802f297c>{schedule
+126} <ffffffff802f35eb>{thread_return+56} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801f2ea4>{number+90}
<ffffffff802f2756>{__down+154} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff8012cbe8>{default_wake_function
+0} <ffffffff802f471d>{__down_failed+53} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88023089>{:qla2xxx:.text.lock.qla_mbx+15} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff8802181c>{:qla2xxx:qla2x00_mbx_sem_timeout+0} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff880222be>{:qla2xxx:qla2x00_issue_iocb+88} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88033027>{:qla2xxx:qla2x00_get_wwuln_from_device+298} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff8803415f>{:qla2xxx:qla2x00_combine_by_lunid+588} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff80152aa8>{buffered_rmqueue+581}
<ffffffff88034d70>{:qla2xxx:qla2x00_update_mp_device+77} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88035de8>{:qla2xxx:qla2x00_update_mp_host+141} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff880361e7>{:qla2xxx:qla2x00_cfg_path_discovery+192} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88036248>{:qla2xxx:qla2x00_cfg_remap+62}
<ffffffff8801aef1>{:qla2xxx:qla2x00_probe_one+4269} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801a352d>{sysfs_new_dirent+29}
<ffffffff801a35a8>{sysfs_make_dirent+41} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801fbb53>{pci_device_probe+133}
<ffffffff80240534>{driver_probe_device+78} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff80240640>{driver_attach+69}
<ffffffff802409cd>{bus_add_driver+151} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801fb86f>{pci_register_driver
+125} <ffffffff8014a57e>{sys_init_module+307} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff8010d412>{system_call+126} 
Mar 15 13:39:35 src@fe-nntp-02 scheduling while atomic:
modprobe/0x00000001/16112
Mar 15 13:39:35 src@fe-nntp-02 
Mar 15 13:39:35 src@fe-nntp-02 Call Trace:<ffffffff802f297c>{schedule
+126} <ffffffff802f2756>{__down+154} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff8012cbe8>{default_wake_function
+0} <ffffffff802f471d>{__down_failed+53} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88023089>{:qla2xxx:.text.lock.qla_mbx+15} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff8802181c>{:qla2xxx:qla2x00_mbx_sem_timeout+0} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff880222be>{:qla2xxx:qla2x00_issue_iocb+88} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff80242fc5>{dma_pool_free+263}
<ffffffff88032618>{:qla2xxx:qla2x00_test_active_lun+237} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff8803458f>{:qla2xxx:qla2x00_combine_by_lunid+1660} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff80152aa8>{buffered_rmqueue+581}
<ffffffff88034d70>{:qla2xxx:qla2x00_update_mp_device+77} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88035de8>{:qla2xxx:qla2x00_update_mp_host+141} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff880361e7>{:qla2xxx:qla2x00_cfg_path_discovery+192} 
Mar 15 13:39:35 src@fe-nntp-02
<ffffffff88036248>{:qla2xxx:qla2x00_cfg_remap+62}
<ffffffff8801aef1>{:qla2xxx:qla2x00_probe_one+4269} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801a352d>{sysfs_new_dirent+29}
<ffffffff801a35a8>{sysfs_make_dirent+41} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801fbb53>{pci_device_probe+133}
<ffffffff80240534>{driver_probe_device+78} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff80240640>{driver_attach+69}
<ffffffff802409cd>{bus_add_driver+151} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff801fb86f>{pci_register_driver
+125} <ffffffff8014a57e>{sys_init_module+307} 
Mar 15 13:39:35 src@fe-nntp-02 <ffffffff8010d412>{system_call+126} 
Mar 15 13:39:35 src@fe-nntp-02 scheduling while atomic:
modprobe/0x00000001/16112

<--- EOF --->


 On Mon, 2005-03-14 at 15:16 -0800, Andrew Vasquez wrote:
> On Mon, 14 Mar 2005, comsatcat wrote:
> 
> > 
> > Is the qla2xxx dirver not capable of fail over support?  under
> > Documentation/* for the qla2xxx release notes, it says in a earlier
> > revision that fail over was made optional.  Was the optional support
> > removed?  If it is capable of fail over, what are the means of
> > enable/accessing the ability?
> > 
> 
> Failover support for a variety of reasons has been removed from the
> embedded 2.6.x kernel driver.  If you are interested in continuing to
> use the failover functionality you will need to use one of the drivers
> in:
> 
> 	ftp://ftp.qlogic.com/outgoing/linux/beta/8.x/
> 
> more specifically:
> 
> 	ftp://ftp.qlogic.com/outgoing/linux/beta/8.x/qla2xxx-v8.00.02b10-dist.tgz
> 
> Regards,
> Andrew Vasquez
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

