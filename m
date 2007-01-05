Return-Path: <linux-kernel-owner+w=401wt.eu-S1030349AbXAEGIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbXAEGIe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbXAEGIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:08:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58235 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030349AbXAEGId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:08:33 -0500
Date: Thu, 4 Jan 2007 23:43:37 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 0/8] user ns: Introduction
Message-ID: <20070105054337.GB1412@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104200323.3b09f81a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104200323.3b09f81a.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Thu, 4 Jan 2007 12:06:35 -0600
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > This patchset adds a user namespace, which allows a process to
> > unshare its user_struct table,  allowing for separate accounting
> > per user namespace.
> 
> With these patches applied and with CONFIG_USER_NS=n, my selinux-enabled
> standard FC5 machine throws a complete fit:
> 
> [   12.323958] EDAC MC: Ver: 2.0.1 Jan  4 2007
> [   12.357476] TCP cubic registered
> [   12.360784] NET: Registered protocol family 1
> [   12.364125] NET: Registered protocol family 17
> [   12.367761] speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI config is deprecated.
> [   12.367763]  Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.
> [   12.374666] Using IPI Shortcut mode
> [   12.378222] Time: tsc clocksource has been installed.
> [   12.381987] Time: acpi_pm clocksource has been installed.
> [   12.386522] ACPI: (supports S0 S3 S4 S5)
> [    6.344000] Freeing unused kernel memory: 184k freed
> [    6.560000] input: PS/2 Mouse as /class/input/input1
> [    6.580000] input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
> [    6.760000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [    6.764000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> [    6.824000] EXT3-fs: INFO: recovery required on readonly filesystem.
> [    6.824000] EXT3-fs: write access will be enabled during recovery.
> [   10.832000] kjournald starting.  Commit interval 5 seconds
> [   10.836000] EXT3-fs: recovery complete.
> [   10.840000] EXT3-fs: mounted filesystem with ordered data mode.
> [   11.852000] audit(1167940353.844:2): enforcing=1 old_enforcing=0 auid=4294967295
> [   11.948000] security:  3 users, 6 roles, 1417 types, 151 bools, 1 sens, 256 cats
> [   11.952000] security:  57 classes, 41080 rules
> [   11.956000] security:  class key not defined in policy
> [   11.956000] security:  class context not defined in policy
> [   11.960000] security:  class dccp_socket not defined in policy
> [   11.964000] security:  permission dccp_recv in class node not defined in policy
> [   11.964000] security:  permission dccp_send in class node not defined in policy
> [   11.968000] security:  permission dccp_recv in class netif not defined in policy
> [   11.972000] security:  permission dccp_send in class netif not defined in policy
> [   11.972000] security:  permission setkeycreate in class process not defined in policy
> [   11.976000] security:  permission setsockcreate in class process not defined in policy
> [   11.980000] security:  permission polmatch in class association not defined in policy
> [   11.980000] SELinux:  Completing initialization.
> [   11.984000] SELinux:  Setting up existing superblocks.
> [   12.004000] SELinux: initialized (dev sda6, type ext3), uses xattr
> [   12.204000] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> [   12.208000] SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
> [   12.208000] SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
> [   12.212000] SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
> [   12.216000] SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
> [   12.216000] SELinux: initialized (dev devpts, type devpts), uses transition SIDs
> [   12.220000] SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
> [   12.224000] SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
> [   12.224000] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> [   12.228000] SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
> [   12.232000] SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
> [   12.232000] SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
> [   12.236000] SELinux: initialized (dev proc, type proc), uses genfs_contexts
> [   12.240000] SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
> [   12.240000] SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
> [   12.244000] SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> [   12.260000] audit(1167940354.256:3): policy loaded auid=4294967295
> [   12.944000] SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
> [   15.376000] audit(1167969158.994:4): avc:  denied  { audit_write } for  pid=386 comm="hwclock" capability=29 scontext=system_u:system_r:hwclock_t:s0 tcontext=system_u:system_r:hwclock_t:s0 tclass=capability
> [   33.936000] audit(1167969177.567:2292): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.940000] audit(1167969177.579:2293): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.952000] audit(1167969177.591:2294): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.956000] audit(1167969177.607:2295): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.960000] audit(1167969177.615:2296): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.964000] audit(1167969177.627:2297): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.968000] audit(1167969177.639:2298): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.972000] audit(1167969177.651:2299): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.976000] audit(1167969177.667:2300): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.980000] audit(1167969177.679:2301): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> [   33.984000] audit(1167969177.695:2302): avc:  denied  { search } for  pid=2141 comm="klogd" name="/" dev=tmpfs ino=1225 scontext=system_u:system_r:klogd_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> <ad infinitum>
> 
> 
> Setting CONFIG_USER_NS=y fixes this.

Ok, I see.  The CONFIG_USER_NS split is absolutely horrible.  Should
really get rid of the user_ns pointers altogether when !CONFIG_USER_NS.
I'll try to fix it up without putting ifdefs all over - planning to send
a patch tomorrow.

thanks,
-serge
