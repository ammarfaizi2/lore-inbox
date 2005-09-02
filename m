Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVIBIhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVIBIhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVIBIhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 04:37:04 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32943 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751129AbVIBIhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 04:37:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Date: Fri, 2 Sep 2005 10:37:16 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org> <20050901142813.47b349ed.akpm@osdl.org> <200509021030.06874.rjw@sisk.pl>
In-Reply-To: <200509021030.06874.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021037.16536.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2 of September 2005 10:30, Rafael J. Wysocki wrote:
> On Thursday, 1 of September 2005 23:28, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > > 
> > > I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
> > > command:
> > > 
> > > sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout
> > > 
> > > loops forever with almost 100% of the time spent in the kernel.
> > > 
> > > AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.
> > 
> > OK.  There are no notable firmware changes in there.  While it's stuck
> > could you generate a kernel profile?    I do:
> > 
> > readprofile -r
> > sleep 5
> > readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

]--snip--[

One more piece of information.  This is the one that loops:

echo 30 > /sys/class/firmware/timeout

and the related profile is:

    16 *unknown*
ffffffff8010eb38 sysret_check                                  1   0.0120
ffffffff80240b40 clear_page                                    1   0.0175
ffffffff80356397 bad_gs                                        1   0.0001
ffffffff80240cc0 copy_user_generic                             2   0.0067
ffffffff8010eb33 ret_from_sys_call                             6   1.2000
ffffffff80221870 dummy_file_permission                         7   0.4375
ffffffff80240c90 copy_from_user                                9   0.1875
ffffffff8023f5e0 simple_strtol                                11   0.2292
ffffffff8023f500 simple_strtoul                               17   0.0759
ffffffff802ac800 class_attr_store                             18   0.3750
ffffffff801bfc40 sysfs_write_file                             61   0.1658
ffffffff8017ead0 sys_write                                    78   0.5417
ffffffff8017df70 rw_verify_area                              143   1.1172
ffffffff80240dea copy_user_generic_c                         144   3.7895
ffffffff8010eab0 system_call                                 163   1.2443
ffffffff8017f1d0 fget_light                                  184   0.7667
ffffffff8017e890 vfs_write                                   209   0.5024
0000000000000000 total                                      1055   0.0004

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
