Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267586AbRGPUUF>; Mon, 16 Jul 2001 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbRGPUTz>; Mon, 16 Jul 2001 16:19:55 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:64598 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S267586AbRGPUTi>;
	Mon, 16 Jul 2001 16:19:38 -0400
Message-ID: <3B534C1F.8080100@valinux.com>
Date: Mon, 16 Jul 2001 14:18:39 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu>	<3B532BB7.1050300@valinux.com> <3B533578.A4B6C25F@damncats.org> 	<3B53413A.6060501@valinux.com> <995312089.987.8.camel@nomade>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> On 16 Jul 2001 13:32:10 -0600, Jeff Hartmann wrote:
> 
>>> 
>> No, because the 2D ddx module is the one doing all the versioning.  It 
>> doesn't tell the kernel its version number etc., but the ddx module gets 
>> the version from the kernel, and fails if its the wrong one.  If the 
>> kernel was the one doing the checking, then your suggestiong would be a 
>> nice way of handling it.
> 
> 
> Well ... you're gonna change the API anyway, so you could add that in
> the protocol.
> Still, I'm a bit disappointed with this ever-changing API. A bit
> un-linux if you ask me.
> 
> Xav

You have to remember this isn't an API that users program to, it is an 
API that a specific driver uses.  Each driver is different, and has a 
different API (at least a subset of it.)  The cards are so different 
that they can't have the same interfaces and remain competitive.  Each 
3D client side driver packages up state and vertex data in a form that 
only that video card can understand.  Each new drm kernel driver 
requires a new device specific portion of the API.

Basically it boils down to this:
If we want to be secure, we have to have an interface which can remain 
competitive with insecure drivers.  To accomplish this we have to 
tightly couple our 3D client side drivers with our drm kernel modules.  
We are bound to develop more efficent ways of doing this over time, and 
the interface will have to change under most circumstances.

If we were NOT secure we could probably have a pretty static API (send 
this area of dma commands to the card), however this is unacceptable.  
Especially since most graphics cards can DMA to ANYWHERE in system 
memory.  Our DRI drivers must be secure, thus we introduce alot of 
issues to 3D driver writing, one of which is API incompatibility.

-Jeff

