Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbRGPSeD>; Mon, 16 Jul 2001 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbRGPSdm>; Mon, 16 Jul 2001 14:33:42 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:45384 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267623AbRGPSdh>;
	Mon, 16 Jul 2001 14:33:37 -0400
Message-ID: <3B533349.2070201@valinux.com>
Date: Mon, 16 Jul 2001 12:32:41 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
CC: John Cavan <johnc@damncats.org>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu> 	<3B532BB7.1050300@valinux.com> <995307155.32445.36.camel@nomade>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> On 16 Jul 2001 12:00:23 -0600, Jeff Hartmann wrote:
> [...]
> 
>> will do this.  This will make the 4.0 -> 4.1 have to be a compile time 
>> decision, but 4.1 -> 4.1.1 and higher will just coexist with each 
>> other.  I'm currently working out integrating this into the kernel 
>> build, and I should hopefully have a patch for Linus and Alan soon.
> 
> 
> I would have preferred if you were just versionning vs the API, not the
> X version (and keep the API rather stable).

The problem is that the API can't be completely stable because of the 3D 
client-side drivers, 2D ddx drivers, and the drm kernel modules have to 
be tightly coupled.  The drm kernel module has to provide a secure 
method of sending data to the card, but we also want it to be efficent.  
For example, the mesa-3.5 versions of the drm kernel modules can send 
multiple states inside one dma buffer, this greatly increases the 
efficency of the driver, but it costs API compatibility.  We do version 
the API, and will not attempt to use the drivers if their API versions 
are wrong.  However we want multiple versions of the API to coexist.  
Adding the version number to the module name will allow for all the 
versions to coexist.

>  I wouldn't like to update my
> kernel just to go from X 4.1.1 to X 4.1.1-pl1.

Well if there are changes to the drm kernel drivers, you have to update 
your kernel or compile the kernel modules by hand.  We could easily 
create a stable API if cards were secure, or we did not care about 
security.  Unfortunately neither one is the case, so the API is not 
completely static.

-Jeff

