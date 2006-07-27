Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWG0OjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWG0OjJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWG0OjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:39:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:23025 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751455AbWG0OjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:39:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPXfAHT0aQ7kW/tDMj6KdcLIrfIb7H2D6EPAhBZRgTre8LTKELw8FFRWHhXXCy4XVCh9ubJIXeSbZ1N+4CJigp24QQRF457gpKbhI+MYMHZ9HCtJ2aV/gQaUvt9CIN5s6T+reMRFIGcyBFHuRf9eTOo0apvjT6clZrlHm5gbIrI=
Message-ID: <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
Date: Thu, 27 Jul 2006 17:39:06 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, vojtech@suse.cz,
       "Len Brown" <len.brown@intel.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
In-Reply-To: <20060727140539.GA10835@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727002035.GA2896@elf.ucw.cz>
	 <20060727140539.GA10835@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> This would also be useful for the OLPC project - it's unlikely that
> it'll use ACPI, but a more feature-rich interface than /proc/apm would
> be massively helpful. This is just a matter of speccing out what
> information is needed and what format it should be presented in, and
> then adding a new device class, right?

Can we really assume there's one driver providing all battery-related
attributes?

For example, on a ThinkPad you want the ACPI battery module loaded so
that handles hande battery-related ACPI events, but on ACPI can't
doesn't provide all available attributes. For example, ACPI reports
the equvialent of
  /sys/devices/platform/smapi/BAT0/power_avg (last minute average)
but not
  /sys/devices/platform/smapi/BAT0/power_now (instantaneous average)
or
  /sys/devices/platform/smapi/BAT0/cycle_count
or control functions like
  /sys/devices/platform/smapi/BAT0/force_discharge
(see http://thinkwiki.org/wiki/tp_smapi for detials).

In this particular case we could split the ACPI module into two, one
module for events and one module for the sysfs interface, and load
only the first one on ThinkPads. But that's only because tp_smapi
happens to reproduce all of ACPI's attributes; there are probably
other cases whether neither method dominates the other.

So, if we insist on a standard battery device class name, how do we
cope with multiple sources of information and control functions?

  Shem
