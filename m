Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVCXXyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVCXXyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVCXXyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:54:44 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:44067 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261248AbVCXXyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:54:40 -0500
Date: Thu, 24 Mar 2005 15:54:39 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050324235439.GA27902@hexapodia.org>
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de> <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005032413145adaa283@mail.gmail.com> <d120d50005032413105950045c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 04:10:39PM -0500, Dmitry Torokhov wrote:
> If you do "ls /sys/bus/serio/devices" and see more than 3 ports you
> have MUX mode active.

Just serio0 and serio1.

On Thu, Mar 24, 2005 at 04:14:52PM -0500, Dmitry Torokhov wrote:
> On Thu, 24 Mar 2005 12:20:40 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> > (How can I verify that "nomux" was accepted?  It shows up on the "Kernel
> > command line" but there's no other mention of it in dmesg.)
> 
> Ignore my babbling, I just noticed in your dmesg that your KBC does
> not support MUX mode to begin with.

OK, anything else I should try?

Why does it only fail when I have *both* intel_agp and i8042 aux?

In the SysRq-T trace I see one interesting process: most things are
in D state in refrigerator(), but sh shows the following traceback:

wait_for_completion
call_usermodehelper
kobject_hotplug
kobject_del
class_device_del
class_device_unregister
mousedev_disconnect
input_unregister_device
alps_disconnect
psmouse_disconnect
serio_driver_remove
device_release_driver
serio_release_driver
serio_resume
resume_device
dpm_resume
device_resume
swsusp_write
pm_suspend_disk
enter_state
state_store
subsys_attr_store
flush_write_buffer
sysfs_write_file
...

That seems odd to me...

Also, khelper has the following trace:
io_schedule
sync_buffer
__wait_on_bit
out_of_line_wait_on_bit
ext3_find_entry
ext3_lookup
real_lookup
do_lookup
__link_path_walk
link_path_walk
path_lookup
open_exec
do_execve
...


-andy
