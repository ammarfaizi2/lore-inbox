Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDZISl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbTDZISk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 04:18:40 -0400
Received: from [81.80.245.157] ([81.80.245.157]:40409 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S262258AbTDZISi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 04:18:38 -0400
Date: Sat, 26 Apr 2003 10:29:57 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426082956.GB18917@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423204258.GB10567@vitel.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:42:58PM +0200, Stelian Pop wrote:

> > I haven't been able to figure out how to get the scsi
> > subsystem to remove devices in this condition:
> 
> Well, hopefully someone here will direct you towards the 
> correct solution before 2.4.21 gets final... Firewire devices
> tend to be plugged / unplugged quite often.

This was three days ago. Today, without *any* notice (like posting
a patch on lkml for example, as I already suggested it), I saw a
new IEEE1394 patch was checked in into Marcelo's tree.

As usual, the patch was quite big, in Ben's own words "virtualy
bloated [...] by format changes". Why he continues to submit patches
like that one in -rc stage is beyond my understanding.

And guess what ? The new patch broke (again) my setup. When I plug
in my iPod, the scsi layer does not see it anymore.

Since I reported issues about this 3 days ago, I would have appreciated
being CC:'ed on the patch mail, so I could have reported issues 
like this _before_ such a patch being applied. 

Is this so hard to get it right Ben ? From a Debian developer like you
I would have expected you to be a bit more organized and respectful
about the kernel community. And no, the long 2.4.21 release cycle
does not justify everything.

You're now one of those who slow down the final release. All this 
makes me think that the initial feeling I had, to completly backout
the ieee1394 changes until 2.4.22-pre, was correct...

Stelian.

PS: In case they are useful, various logs are included below:

dmesg (with #define CONFIG_IEEE1394_SBP2_DEBUG 2 activated):
	ieee1394: sbp2: sbp2_module_init
	ieee1394: sbp2: sbp2_add_host
	ieee1394: sbp2: sbp2scsi_detect
	scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2scsi_queuecommand
	ieee1394: sbp2: sbp2_probe
	ieee1394: sbp2: sbp2_start_device
	ieee1394: sbp2: sbp2_parse_unit_directory
	ieee1394: sbp2: sbp2_unit_characteristics = 1e08
	ieee1394: sbp2: sbp2_command_set_spec_id = 609e
	ieee1394: sbp2: sbp2_command_set = 104d8
	ieee1394: sbp2: sbp2_firmware_revision = a2700
	ieee1394: sbp2: sbp2_management_agent_addr = f0010000
	ieee1394: sbp2: sbp2_device_type_and_lun = e0000
	ieee1394: sbp2: New SBP-2 device inserted, SCSI ID = 0
	ieee1394: sbp2: sbp2_login_device
	ieee1394: sbp2: sbp2_login_device: password_hi/lo initialized
	ieee1394: sbp2: sbp2_login_device: login_response_hi/lo initialized
	ieee1394: sbp2: sbp2_login_device: lun_misc initialized
	ieee1394: sbp2: sbp2_login_device: passwd_resp_lengths initialized
	ieee1394: sbp2: sbp2_login_device: status FIFO initialized
	ieee1394: sbp2: sbp2_login_device: orb byte-swapped
	ieee1394: sbp2: sbp2_login_device: login_response/status FIFO memset
	ieee1394: sbp2: sbp2_login_device: prepared to write
	ieee1394: sbp2: sbp2_login_device: written
	ieee1394: sbp2: sbp2_handle_status_write
	ieee1394: sbp2: command_block_agent_hi = ffc1ffff
	ieee1394: sbp2: command_block_agent_lo = f0010020
	ieee1394: sbp2: Logged into SBP-2 device
	ieee1394: sbp2: sbp2_set_busy_timeout
	ieee1394: sbp2: sbp2_agent_reset
	ieee1394: sbp2: sbp2_max_speed_and_size
	ieee1394: sbp2: Node[01:1023]: Max speed [S400] - Max payload [2048]
/proc/scsi/scsi
	Attached devices: 
	Host: scsi0 Channel: 00 Id: 00 Lun: 00
	  Vendor: Sony     Model: MSC-U01N         Rev: 1.00
	  Type:   Direct-Access                    ANSI SCSI revision: 02

/proc/scsi/sbp2_0/1
	Host scsi1             : SBP-2 IEEE-1394 (ohci1394)
	Driver version         : $Rev: 906 $ James Goodwin <jamesg@filanet.com>
	
	Module options         :
	  max_speed            : S800
	  max_sectors          : 255
	  serialize_io         : no
	  exclusive_login      : yes
	
	Attached devices       : none
	
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
