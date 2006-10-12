Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWJLWRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJLWRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWJLWRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:17:41 -0400
Received: from gw.goop.org ([64.81.55.164]:65435 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751194AbWJLWRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:17:41 -0400
Message-ID: <452EBF7C.3000409@goop.org>
Date: Thu, 12 Oct 2006 15:19:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
CC: acpi-devel@kernel.org, cpufreq@lists.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Strange entries in /proc/acpi/thermal_zone for Thinkpad X60
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Thinkpad X60 with an Intel Core Duo T2400.  In 
/proc/acpi/thermal_zone, I'm getting two subdirectories, each with their 
own set of files:

/proc/acpi/thermal_zone/THM0/cooling_mode:
<setting not supported>
cooling mode:   critical

/proc/acpi/thermal_zone/THM0/polling_frequency:
<polling disabled>

/proc/acpi/thermal_zone/THM0/state:
state:                   ok

/proc/acpi/thermal_zone/THM0/temperature:
temperature:             53 C

/proc/acpi/thermal_zone/THM0/trip_points:
critical (S5):           127 C


/proc/acpi/thermal_zone/THM1/cooling_mode:
<setting not supported>
cooling mode:   passive

/proc/acpi/thermal_zone/THM1/polling_frequency:
<polling disabled>

/proc/acpi/thermal_zone/THM1/state:
state:                   ok

/proc/acpi/thermal_zone/THM1/temperature:
temperature:             53 C

/proc/acpi/thermal_zone/THM1/trip_points:
critical (S5):           97 C
passive:                 93 C: tc1=5 tc2=4 tsp=600 devices=0xf7eaa264 0xf7eaa244 


The interesting thing is that the two sets of files are not consistent - 
sometimes they don't even show the same temperature.

The reason I'm interested in this is that I think it's behind some of my 
cpufreq problems.  Sometimes the kernel decides that I just can't raise 
the max frequency above 1GHz, because its been thermally limited (I've 
put printks in to confirm that its the ACPI thermal limit on the policy 
notifier chain which is limiting the max speed).  It seems to me that 
having a thermal zone for each core is a BIOS bug, since they're really 
the same chip, but the THM1 entries should be ignored.  I don't believe 
the CPU has ever approached either 97 C, let alone 127; while I put it 
under a fair amount of load, it is sitting on a desktop with no airflow 
obstructions, so if it really is overheating it suggests a serious 
design problem with the hardware.

But I'm just speculating; I'm not really sure what all this means.  Any 
clues?

Thanks,
    J
