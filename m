Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbTC0Mym>; Thu, 27 Mar 2003 07:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbTC0Mym>; Thu, 27 Mar 2003 07:54:42 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:20100 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S262543AbTC0Myl>;
	Thu, 27 Mar 2003 07:54:41 -0500
Message-ID: <3E82F736.2000704@portrix.net>
Date: Thu, 27 Mar 2003 14:05:58 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Greg KH <greg@kroah.com>, Mark Studebaker <mds@paradyne.com>,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
References: <1048582394.4774.7.camel@workshop.saharact.lan>	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>	 <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com>	 <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>	 <3E82D678.9000807@portrix.net>	 <1048762244.4773.1258.camel@workshop.saharact.lan>	 <3E82EE25.3070308@portrix.net> <1048768432.4774.1263.camel@workshop.saharact.lan>
In-Reply-To: <1048768432.4774.1263.camel@workshop.saharact.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:

> For instance, what my bios say, and what the raw reading from 
> /proc is, is two different things.  I also had to slightly adjust
> things between some models of Asus boards I had.
> 
But why not return always the raw data then and don't do any conversion 
at all? I mean, if we already try to guess the real value in the driver, 
we should try to get it right.
Ah, and I don't want to do small corrections like 1 or 2 percent up or 
down, but things like this for lm80:
     compute in0 (24/14.7 + 1) * @ ,       @ / (24/14.7 + 1)
     compute in2 (22.1/30 + 1) * @ ,       @ / (22.1/30 + 1)
     compute in3 (2.8/1.9) * @,            @ * 1.9/2.8
     compute in4 (160/30.1 + 1) * @,       @ / (160/30.1 + 1)

These differ a lot. And as stated in the sensors.conf seem to be from 
the datasheet of the lm80 and not mainboard specific.
So that the sysfs values at least are near reality.

Thanks,

Jan


