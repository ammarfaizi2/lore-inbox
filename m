Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265262AbUFHRCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265262AbUFHRCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 13:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFHRCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 13:02:15 -0400
Received: from mail.tmr.com ([216.238.38.203]:50187 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265257AbUFHRCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 13:02:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.7-rc2
Date: Tue, 08 Jun 2004 13:02:42 -0400
Organization: TMR Associates, Inc
Message-ID: <ca4r6t$p16$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <1086187044.6179.8.camel@hostmaster.org> <200406041706.27716.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086713885 25638 192.168.12.100 (8 Jun 2004 16:58:05 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <200406041706.27716.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 02 June 2004 17:37, Thomas Zehetbauer wrote:
> 
>>http://bugzilla.kernel.org/show_bug.cgi?id=2819
>>
>>Make oldconfig silently disabled support for my CONFIG_TIGON3 NIC.
>>
>>It seems that it depends on CONFIG_NET_GIGE which in turn depends on
>>CONFIG_NET_ETHERNET which was not required in 2.6.6 kernel.
>>
>>Tom
> 
> 
> Many days ago I read on lkml that separating 10,100 and 1000 Mbit
> ethernet is not really justified. There are devices which have
> 100 and 1000 variants.
> 
> Just keeping all ethernet devices in one menu sounds sane to me.

There are other issues with the build process, when a driver supports a 
chipset used in several products there's no reasonable way to find out 
which driver should be used, and as you say the split of speed makes 
less and less sense, and will just get worse when 10Ge is more common.

The solution may be an external table, program, or whatever, since the 
situation changes as drivers are modified to support new models, 
chipsets move to new vendors, etc. But it would be *really nice* to find 
the 3c940 with 3COM drivers, instead of grepping driver source and 
looking at spec sheets to find out that the driver is called something 
like sk98lin, it's in an unobvious place and has a name unrelated to 3COM.

Here's a suggestion if someone wants to do something about this, like 
LDP. Produce a CSV list of vendor name, like 3c940, name used for config 
in the menu, module name and symbol in the .config file. Would let users 
find things a lot faster, and could be used with grep as well as some 
spreadsheet tool.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
