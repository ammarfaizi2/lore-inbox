Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277413AbRJEP3H>; Fri, 5 Oct 2001 11:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277414AbRJEP2u>; Fri, 5 Oct 2001 11:28:50 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:33289 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S277418AbRJEP2c>; Fri, 5 Oct 2001 11:28:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [POT] Linux SAN?
Date: Fri, 5 Oct 2001 11:30:26 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200110051447.f95ElUj01488@localhost.localdomain>
In-Reply-To: <200110051447.f95ElUj01488@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15pWtS-0007kl-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 October 2001 10:47, you wrote:
> > The FC HBA driver put out by Qlogic works well but does a silly thing;
> > it  enumerates devices from 0, instead of by the actually loop ID.
> > This makes  it impossible to spec absolute paths to the device, as
> > everything will shift when devices are moved on the FC loop.
>
> There are several reasons why this is done:

Note that there is clear distiction between devices that are on the *local 
loop* and those you obtain from fabric login. My bitch, and my patch, fixes 
the logical issue that a local loop devices requesting a hard ID, should be 
accessable by *that ID* from userland if it is available. Very simple, and 
what the FC spec requires, and what the QLogic HBA BIOS does. However the 
Qlogic Linux driver attempts to present all devices as found from unit 0. 
This makes no sense because there are 2 assignment loops in the QLA source,
the second one for the purposes of login/softid resolution. I fixed the first 
loop. The second loop still starts from zero and will catch any conflicts 
from the first...
 
As for persistent binding, I just couldn't make it work with any of the 
QLA2x00 drivers I tried. Their parsing code is just fubar. 
Persistent binding is also not much fun to keep track of, and can run you out 
of cmdline space *really* quick if you try to spec devices at boot.
For a small SAN, devices (bays) with hard id's are usually much more 
desirable.

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
