Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262925AbSJAWu0>; Tue, 1 Oct 2002 18:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262926AbSJAWu0>; Tue, 1 Oct 2002 18:50:26 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:42635 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S262925AbSJAWuZ>; Tue, 1 Oct 2002 18:50:25 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEEA@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>, Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
       cpufreq@www.linux.org.uk
Subject: RE: cpufreq patches for 2.5.39 follow
Date: Tue, 1 Oct 2002 15:55:38 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz] 
> How does it interact with ACPI? Ie. I do echo "100%100%foo", 
> but ACPI thermal
> managment decides to slow down?

How do you think it should be handled?

Will the ACPI thermal driver be able to use a standard cpufreq interface to
request that the CPU drop to a lower mhz/voltage?

Things get interesting on a system that implements ACPI 2.0-style processor
performance controls, instead of proprietary methods. Then you could have
ACPI thermal telling cpufreq to slow down, which in turn tells the ACPI
processor driver. IMHO this is the way it should work. There is a connection
right now between the ACPI thermal and processor driver, but that is just
there because cpufreq didn't exist. This dependency should be severed, and
cpufreq should go in the middle.

This was discussed on cpufreq a few months ago and I think Dominik even
whipped up some code, but it may have bit-rotted...

> > Support for mobile AMD K7 processors is still in development.
> 
> What about mobile celerons?

Mobile Celerons do not support voltage scaling.

Regards -- Andy
