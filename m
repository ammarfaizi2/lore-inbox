Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSG3R4r>; Tue, 30 Jul 2002 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSG3R4r>; Tue, 30 Jul 2002 13:56:47 -0400
Received: from imo-r04.mx.aol.com ([152.163.225.100]:7107 "EHLO
	imo-r04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S316585AbSG3R4p>; Tue, 30 Jul 2002 13:56:45 -0400
Message-ID: <3D469C86.3010305@netscape.net>
Date: Tue, 30 Jul 2002 14:02:46 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org
CC: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
References: <Pine.LNX.4.44.0207300902280.22697-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that a device without a mapping to a driver is a valid
> state.

Ok here's a new less devfs dependent idea.  Its sole goal is to 
acomplish the above.  Why not add a list to device like I did before 
only instead of using devfs handles to discover major and minor numbers 
I can store the major and minor numbers directly.  I could even use 
kdev_t.  This way it is not dependent on devfs and does not enforce any 
of its policies.  Then I'll create a quick interface for driverfs as 
well as a simple register and unregister function.  I'll name it dev 
like before and it can display information in the following format: 
 MAJOR, MINOR.  It will print one line per dev.  Finally I can use one 
of devfs's find functions to generate the path although I may just 
forget devfs entirely.  This interface is necessary because user level 
programs can determine which driverfs entries correspond to which 
entries in their dev directory.  I think this will be useful for hotplug 
as well as some of my own projects.  If you support this I'll get to 
work on a patch.  Also I had a driver model related question.  Should a 
driver be able to belong to more than one bus?  Also are you going to 
create an interface that exports drivers directly instead of only 
through bus and device class?
Thanks,
Adam

