Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272483AbTGaNk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272998AbTGaNk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:40:56 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:56252 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S272483AbTGaNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:40:52 -0400
Message-ID: <3F291A0F.1050406@pacbell.net>
Date: Thu, 31 Jul 2003 06:30:55 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094749.GB464@elf.ucw.cz>
In-Reply-To: <20030731094749.GB464@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>The "initiators" all talk to _both_ infrastructures, but they
>>don't talk to the driver model stuff in the same way.  For
>>example, on suspend:
>>
>> ...
> 
> Where does acpi call pm_*()? It seems like it does not and it seems
> like a bug to me.

Doesn't; it showed up in a 'grep' that I should have examined
more closely.  Sorry!  But both swsusp and APM have the "using
both registration schemes" issue (consistency matters here).

Why does it seem like a bug -- because it's using only the "new"
infrastructure, while there are still a few drivers that only
register to the old one?  I'd rather see those drivers (about
a dozen) have compile time #ifdef CONFIG_PM #warnings, and call
them the bug...

- Dave




