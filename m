Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVJaPGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVJaPGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJaPGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:06:13 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:7096 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750917AbVJaPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:06:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Date: Mon, 31 Oct 2005 16:06:36 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311606.36615.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting some "scheduling while atomic" messages from 2.6.14-git3 on boot
and on suspend/resume, eg.:

NET: Registered protocol family 1
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xa, vid 0x2
scheduling while atomic: swapper/0x00000001/1

Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff80163576>{poison_obj+70}
       <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff80162989>{dbg_redzone1+25}
       <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff80163908>{cache_alloc_debugcheck_after+280}
       <ffffffff8011cf1b>{powernowk8_target+139} <ffffffff80162989>{dbg_redzone1+25}
       <ffffffff802e0830>{cpufreq_stat_notifier_policy+304}
       <ffffffff802dfdb4>{__cpufreq_driver_target+116} <ffffffff801be269>{sysfs_new_dirent+41}
       <ffffffff802e097e>{cpufreq_governor_performance+62}
       <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df3a8>{__cpufreq_set_policy+440}
       <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
       <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
       <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
       <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
       <ffffffff8010f54e>{child_rip+0} 
scheduling while atomic: swapper/0x00000001/1

Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff802e2453>{cpufreq_frequency_table_target+371}
       <ffffffff8011d60c>{powernowk8_target+1916} <ffffffff802dfdb4>{__cpufreq_driver_target+116}
       <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff802e097e>{cpufreq_governor_performance+62}
       <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df3a8>{__cpufreq_set_policy+440}
       <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
       <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
       <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
       <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
       <ffffffff8010f54e>{child_rip+0} 
input: AT Translated Set 2 keyboard//class/input as input1
scheduling while atomic: swapper/0x00000001/1

Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff802e2453>{cpufreq_frequency_table_target+371}
       <ffffffff8011cf1b>{powernowk8_target+139} <ffffffff802dfdb4>{__cpufreq_driver_target+116}
       <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff802e097e>{cpufreq_governor_performance+62}
       <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df417>{__cpufreq_set_policy+551}
       <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
       <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
       <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
       <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
       <ffffffff8010f54e>{child_rip+0} 
scheduling while atomic: swapper/0x00000001/1

Call Trace:<ffffffff8035014a>{schedule+122} <ffffffff802e2453>{cpufreq_frequency_table_target+371}
       <ffffffff8011d60c>{powernowk8_target+1916} <ffffffff802dfdb4>{__cpufreq_driver_target+116}
       <ffffffff801be269>{sysfs_new_dirent+41} <ffffffff802e097e>{cpufreq_governor_performance+62}
       <ffffffff802dec8d>{__cpufreq_governor+173} <ffffffff802df417>{__cpufreq_set_policy+551}
       <ffffffff802df5bf>{cpufreq_set_policy+79} <ffffffff802df946>{cpufreq_add_dev+806}
       <ffffffff802df540>{handle_update+0} <ffffffff802ae21a>{sysdev_driver_register+170}
       <ffffffff802df106>{cpufreq_register_driver+198} <ffffffff8010c122>{init+194}
       <ffffffff8010f556>{child_rip+8} <ffffffff8010c060>{init+0}
       <ffffffff8010f54e>{child_rip+0} 

Additionally there are some problems with freezing processes by swsusp.

Greetings,
Rafael

