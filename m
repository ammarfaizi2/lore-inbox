Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268963AbUIMUnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268963AbUIMUnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUIMUnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 16:43:15 -0400
Received: from castle.comp.uvic.ca ([142.104.5.97]:37060 "EHLO
	castle.comp.uvic.ca") by vger.kernel.org with ESMTP id S268963AbUIMUnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 16:43:12 -0400
Message-ID: <4146062B.8040603@linuxboxen.org>
Date: Mon, 13 Sep 2004 13:42:19 -0700
From: David Bronaugh <dbronaugh@linuxboxen.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Deucher <alexdeucher@gmail.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>	 <1094853588.18235.12.camel@localhost.localdomain>	 <Pine.LNX.4.58.0409110137590.26651@skynet>	 <1094912726.21157.52.camel@localhost.localdomain>	 <Pine.LNX.4.58.0409122319550.20080@skynet>	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>	 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>	 <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>	 <Pine.LNX.4.58.0409130803340.2378@ppc970.osdl.org> <a728f9f9040913122160dd0134@mail.gmail.com>
In-Reply-To: <a728f9f9040913122160dd0134@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UVic-Virus-Scanned: OK - Passed virus scan by Sophos (sophie) on castle
X-UVic-Spam-Scan: castle.comp.uvic.ca Not_scanned_LOCAL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher wrote:

>How would any of these plans handle power management and ACPI events?
>I'd like to be able to suspect my laptop with the DRI enabled, or have
>the DDX (or whatever) handle acpi lid and button events or put the
>chip into various power modes.
>
>Alex
>  
>
Since I've been doing a little bit of ACPI hacking (and gained a bit of 
understanding of it), I think I should probably speak on this one.

With the current ACPI infrastructure, you don't have the DDX or whatever 
catching ACPI events -- acpid catches ACPI events, and does appropriate 
things via scripts. So lid and button events can do things, but -- X 
doesn't handle them. Scripts called by acpid do.

As to putting chips into various power modes -- wouldn't this be better 
off in kernel, not in X? My impression is that this wouldn't be a large 
amount of code. It could also abstract away some details of chip power 
management -- it could (potentially) not matter if it's done via ACPI or 
via a custom bit of code for a chip. And it could expose a file in sysfs 
to adjust power settings for the graphics chip. Then the system that 
exists for handling ACPI events can happily keep being how it is.

Yu, Luming has been doing a lot of work in the area of a generic ACPI 
"video features" driver -- such a driver could do such things as change 
which heads are enabled, set backlight power, and generally muck with 
graphics state. I suspect some possible nasty interaction could happen, 
since ACPI could affect graphics state in some pretty hairy ways. It 
might be a good idea to get in contact with him before the user emails 
show up...

David Bronaugh

ps: I kinda trimmed the CC: list on this
