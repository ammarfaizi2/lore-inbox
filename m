Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWE1Rqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWE1Rqf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWE1Rqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:46:35 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:407 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750825AbWE1Rqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:46:34 -0400
Message-ID: <4479E1F8.4030606@free.fr>
Date: Sun, 28 May 2006 19:46:32 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org,
       Nathan Laredo <laredo@gnu.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se>	<44799D24.7050301@gmail.com>	<m3slmui1cr.fsf@zoo.weinigel.se>	<4479D167.4020203@gmail.com> <m3odxihxvp.fsf@zoo.weinigel.se> <4479DF88.2040500@gmail.com>
In-Reply-To: <4479DF88.2040500@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Christer Weinigel napsal(a):
> 
>>Jiri Slaby <jirislaby@gmail.com> writes:
>>
>>
>>>Christer Weinigel napsal(a):
>>>
>>>>fixed in the driver.  If the card doesn't have a subvendor/subdevice,
>>>>is there some way of doing a sanity check on the board to see if it
>>>>actually is a stradis card and then release the board if it isn't?
>>>
>>>Unfortunately not.
>>
>>Why not?  There's an I2C bus with a bunch of devices on it.  Isn't it
>>possible to do an I2C scan and if it doesn't match what's supposed to
>>be on the card fail the probe and release the PCI resources?
> 
> This is an older method not used for device drivers, but only for searching for
> busses or i2c et al, of which drivers stands aside and controls the device.
> 
>>If there is no FPGA or the FPGA fails to respond, that should also be
>>a fairly good indicator that it is not a stradis board.
> 
> Yup, but pci probing doesn't have such mechanism.
Hum ?
The driver have to return an error (negative value) in the probbing 
function if it detect that the card fails to respond correctly.

Same happen for i2c.
If the driver didn't manage to find what it expect on the i2c bus, the 
driver won't be usefull for the device, so the driver should release the 
device.

Matthieu
