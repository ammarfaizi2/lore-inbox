Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWIIPN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWIIPN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964769AbWIIPN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:13:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:8352 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932259AbWIIPN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XoZV8z/l5edBAxPM2sPEwlsMvytQJIxbQLX1+YzFTIJtA37Pof6FfL1YW4mcvtiHxIEI+oT9exDq9i6eDpB4iNWubAa/RLSRj+aJRVWuG3QNwDgJ7u0sFi/1VsEf7smAiBLH7XpYlWc4aYJ1MUgcQVRdxp1WxJS6zkShtlvhFgo=
Message-ID: <4502DA2F.5050905@gmail.com>
Date: Sat, 09 Sep 2006 19:13:51 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [v4l-dvb-maintainer] DVB build fails without I2C
References: <45029DB0.5020300@garzik.org>
In-Reply-To: <45029DB0.5020300@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> In an effort to speed up my all-filesystems build, I disabled several
> things in my allyesconfig-generated .config.  As luck would have it, I
> wound up disabling I2C but did not disable DVB.
> 
> This led to a link failure at the end of the build, with the linker
> complaining that many I2C-related symbols were not present.
> 
> Recommended solution:  Add I2C as a dependency (or select) in DVB Kconfig.


DVB-CORE does not depend on I2C, since it does not rely on any I2C at
all. (DVB-CORE can use other methods) It is the PCI bridges that depend
on I2C. IIRC, we had a patch adding I2C dependencies for the Kconfig for
the relevant bridge chips. The frontends which are connected to the
bridges, depend on DVB-Core and I2C. So that dependency exists.

frontends foo
depends on DVB_CORE && I2C

pci bridges foo
depends on DVB_CORE && I2C && PCI

Maybe that patch has not made it yet to mainline.


Manu
