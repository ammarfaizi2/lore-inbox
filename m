Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWJESee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWJESee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJESee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:34:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:43432 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750748AbWJESed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:34:33 -0400
X-Authenticated: #31060655
Message-ID: <45255059.3040908@gmx.net>
Date: Thu, 05 Oct 2006 20:35:05 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 SUSE/1.0.5-1.1 SeaMonkey/1.0.5
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: Alex Owen <r.alex.owen@gmail.com>, linux-kernel@vger.kernel.org,
       aabdulla@nvidia.com, "H. Peter Anvin" <hpa@zytor.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com> <20061005144442.GB18408@tuxdriver.com>
In-Reply-To: <20061005144442.GB18408@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Wed, Oct 04, 2006 at 05:19:20PM +0100, Alex Owen wrote:
> 
>> The obvious fix for this is to try and read the MAC address from the
>> canonical location... ie where is the source of the address writen
>> into the controlers registers at power on? But do we know where that
>> may be?
> 
> This seems like The Right Thing (TM) to me, but we need someone from
> NVidia(?) to provide that information.  Ayaz?

The canonical location of the "original" MAC address is where we write
back the reversed MAC address. So that won't work.

>> The other solution would be unconditionally reset the controler to
>> it's power on state then use the current logic? can we reset the
>> controller via software?
> 
> This seems like a plausible alternative.

AFAIK there is no way to do that (except powering off the machine).

> The MAC address validation schemes suggested by others would probably
> "work", but they would be a bit fragile.  For example, every new vendor
> of forcedeth hardware would have a new OUI to be added to the list.

Nooooo! That would be a nightmare. Especially because some BIOSes
allow users to set the MAC address. All those setups would be broken
instantly by that solution. (Yes, you can probably be clever, but
then you don't have a chance to fix this generically.)


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
