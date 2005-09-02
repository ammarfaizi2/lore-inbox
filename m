Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVIBI3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIBI3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 04:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVIBI3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 04:29:51 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:30639 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751120AbVIBI3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 04:29:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Date: Fri, 2 Sep 2005 10:30:06 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org> <200509012314.48434.rjw@sisk.pl> <20050901142813.47b349ed.akpm@osdl.org>
In-Reply-To: <20050901142813.47b349ed.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021030.06874.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 1 of September 2005 23:28, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > 
> > I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
> > command:
> > 
> > sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout
> > 
> > loops forever with almost 100% of the time spent in the kernel.
> > 
> > AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.
> 
> OK.  There are no notable firmware changes in there.  While it's stuck
> could you generate a kernel profile?    I do:
> 
> readprofile -r
> sleep 5
> readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

OK
I ran "rcpcmcia start" in one vt and the above in another.  The result was:

    20 *unknown*
ffffffff802417f0 __memset                                      1   0.0052
ffffffff80242850 _raw_spin_lock                                1   0.0031
ffffffff8026a44c acpi_ns_get_next_node                         1   0.0118
ffffffff802ed040 sock_kfree_s                                  1   0.0156
ffffffff8010eb38 sysret_check                                  2   0.0241
ffffffff8010eb33 ret_from_sys_call                             4   0.8000
ffffffff80240cc0 copy_user_generic                             5   0.0168
ffffffff80221870 dummy_file_permission                         7   0.4375
ffffffff8023f5e0 simple_strtol                                14   0.2917
ffffffff80240c90 copy_from_user                               15   0.3125
ffffffff802ac800 class_attr_store                             17   0.3542
ffffffff8017df70 rw_verify_area                               22   0.1719
ffffffff8023f500 simple_strtoul                               24   0.1071
ffffffff8017ead0 sys_write                                    41   0.2847
ffffffff80240dea copy_user_generic_c                          82   2.1579
ffffffff8017f1d0 fget_light                                  108   0.4500
ffffffff8010eab0 system_call                                 189   1.4427
ffffffff8017e890 vfs_write                                   220   0.5288
ffffffff801bfc40 sysfs_write_file                            308   0.8370
0000000000000000 total                                      1062   0.0004

After I had stopped the (looping) "rcpcmcia start", I got:

  1243 *unknown*
ffffffff80240dea copy_user_generic_c                           1   0.0263
ffffffff802417f0 __memset                                      1   0.0052
0000000000000000 total                                         2   0.0000

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
