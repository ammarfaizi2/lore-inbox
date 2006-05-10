Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWEJKbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWEJKbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWEJKbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:31:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:2011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964904AbWEJKbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:31:48 -0400
X-Authenticated: #31060655
Message-ID: <4461C0CA.8080803@gmx.net>
Date: Wed, 10 May 2006 12:30:34 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de, Greg KH <gregkh@suse.de>
Subject: Re: [RFC] [PATCH] Execute PCI quirks on resume from suspend-to-RAM
References: <446139FF.205@gmx.net> <20060510093942.GA12259@elf.ucw.cz>
In-Reply-To: <20060510093942.GA12259@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> machines with the asus_hides_smbus "feature" have the problem
>> that the smbus is disabled again after suspend-to-RAM. This
>> causes all sorts of problems, the worst being a total fan
>> failure on my Samsung P35 notebook after STR and STD.
> 
> What happens if we disable hiding altogether? ASUS decided software
> should not see smbus, perhaps they had a reason?

IIRC this was introduced only to keep older ms-windows versions
from complaining about hardware for which no driver existed.
Newer ms-windows versions seem to unhide the smbus like we do.

> If we decide that we want to keep unhiding, redoing quirks after
> resume is probably neccessary...

Yes. Now the question is where exactly we want to execute these
quirks. Before or after restoring pci config space? If we do it
before restoring config space, it might cause some yet unknown
side effects. If we do it after restoring config space, it might
be worse because we would restore config space of a device not
existing anymore.

Thinking about it again, if we restored the full pci config space
on resume, this quirk handling would be completely unnecessary.
Any reasons why we don't do that?


>> References: Novell bugzilla #173420.
>>
>> This (totally ugly) patch fixes it.
>> Comments/criticism welcome.
>>
>> Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> 

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
