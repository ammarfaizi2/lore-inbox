Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292763AbSBUUgR>; Thu, 21 Feb 2002 15:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292765AbSBUUgH>; Thu, 21 Feb 2002 15:36:07 -0500
Received: from imo-r08.mx.aol.com ([152.163.225.104]:33251 "EHLO
	imo-r08.mx.aol.com") by vger.kernel.org with ESMTP
	id <S292763AbSBUUft>; Thu, 21 Feb 2002 15:35:49 -0500
Message-ID: <3C755A8A.90000@netscape.net>
Date: Thu, 21 Feb 2002 15:37:30 -0500
From: Adam <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: driverfs question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How will the devices in the driverfs be arranged?
It seems to me that it could only be one of the following three methods.

Method 1:
All devices will be arranged according to type.  There will be a folder 
for video, sound, joysticks, etc.
Pros: - Easy to read and understand while browsing the driverfs.
Cons: - Similar interface already implemented in device fs.
       - arrangement shows no hierarchy and doesn't involve the buses.

Method 2:
Folders are created for each bus then devices are placed within them.
If a bus has another bus for a parent, like a pci USB controller,
it doesn't matter.  The bus still gets a root level folder.
Pros: - Useful and unique information to the user.
Cons: - Still doesn't truly represent devices by their actual connection
       - Makes root level device detection APIs more difficult to write

Method 3:
Devices are arranged by their true connection.  If a usb controller is a 
member of a pci bus, it's folder will be within the pci folder.  The 
root level bus will either be PnP BIOS, APIC device tables, or, for 
legacy computers, an emulation of some sort.
Pros: - Devices are arranged by their actual connection.
       - PnP and APIC will finally be truly integrated into the kernel.
Cons: - Legacy emulation could be challenging.

I tend to prefer method 3.  Not only does it provide a perfect interface 
for user level daemons but also it shows the devices in their true 
locations.  This is very important.  Perhaps all or some of these 
methods should be compile time options.

Sincerely,
Adam

