Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbTC0KfS>; Thu, 27 Mar 2003 05:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbTC0KfS>; Thu, 27 Mar 2003 05:35:18 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:35457 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261903AbTC0KfR>;
	Thu, 27 Mar 2003 05:35:17 -0500
Message-ID: <3E82D678.9000807@portrix.net>
Date: Thu, 27 Mar 2003 11:46:16 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> True, but multi-valued files are not allowed in sysfs.  It's especially
> obnoxious that you have 3 value files when you read them, but only
> expect 2 values for writing.  The way I split up the values in the
> lm75.c driver shows a user exactly which values  are writable, and
> enforces this on the file system level.

Agreed, I never knew which of the three values had which functionality.
For via686a this would be inX, inX_min, inX_max, tempX, tempX_overshoot 
(over = overshoot = os ?), tempX_hyst, and so on.

> Entry	Values	Function
> -----	------	--------
> temp,
> temp[1-3]  3	Temperature max, min or hysteresis, and input value.
> 	       	Floating point values XXX.X or XXX.XX in degrees Celcius.

If we're restructuring it, I think we should also agree on _one_ common 
denominator for all values ie. mVolt and milli-Degree Celsius, so that 
no userspace program ever again has know how to convert them to 
user-readable values and every user can just cat the values and doesn't 
have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
or whatever.

Thanks,

Jan

