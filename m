Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTIZHrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIZHrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:47:06 -0400
Received: from mail.aex.nl ([212.153.234.107]:37129 "HELO mail.aex.nl")
	by vger.kernel.org with SMTP id S261979AbTIZHrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:47:01 -0400
Message-ID: <3F73EE77.3000906@euronext.nl>
Date: Fri, 26 Sep 2003 09:44:55 +0200
From: Jan Evert van Grootheest <j.grootheest@euronext.nl>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Jeff Garzik <jgarzik@pobox.com>, marcelo@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: HT not working by default since 2.4.22
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

I think you're missing Jeffs point.
He's really saying that the user want to select features. The user 
doesn't really care how it is implemented. And there is no requirement 
(I think) that some source files match one on one with a configuration 
option.

As a user I like Jeffs proposal very much. It allows me to indicate what 
I want without bothering about the implementation.
I think it would be wise to indicate in the help that HT does include 
parts of ACPI.

As a programmer, I can understand your point too. But perhaps you should 
do something like this (in the Makefile):
if CONFIG_HT
	include part of ACPI needed for HT
endif
if CONFIG_ACPI
	include all of acpi
endif
And let make fix things up.

-- Jan Evert

Brown, Len wrote:
>>Now that I've thought of it (aren't I humble), I rather like 
>>CONFIG_HT.
>>It's simple and it's effects should be obvious to both developer and
>>user:
>>
>>	CONFIG_HT, CONFIG_ACPI == ACPI
>>	!CONFIG_HT, CONFIG_ACPI == ACPI
>>	CONFIG_HT, !CONFIG_ACPI == HT-only ACPI
>>	!CONFIG_HT, !CONFIG_ACPI == no ACPI
>>
>>Following the "autoconf model", what we really want to be testing with
>>CONFIG_xxx is _features_, where possible. "hyperthreading: yes/no" is
>>IMO more clear than "do I want ht-only ACPI or full ACPI", 
>>while at the
>>same time being more fine-grained and future-proof.
> 
> 
> I like positive logic too.
> I went so far as to try to implement this back when I deleted "noht".
> 
> The problem is that "!CONFIG_HT" is meaningless.  It implies that
> you can have CONFIG_ACPI but still "config-out" HT, which you can't.
> 
> Ie. The 2nd row above says to give me ACPI w/o HT.
> If you delete that row and reverse the polarity you get:
> 
> !CONFIG_ACPI_HT_ONLY, CONFIG_ACPI == ACPI
> CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == HT-only ACPI
> !CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == no ACPI
> 
> Here we can use config to emphasize that it is not possible to select
> CONFIG_ACPI and CONFIG_ACPI_HT_ONLY at the same time.
> 
> Cheers,
> -Len
> 
> Ps. Note that in 2.6 CONFIG_X86_HT exists and covers the sibling code.
> It depends on CONFIG_SMP, and CONFIG_ACPI_HT_ONLY depends on it. (in the
> ACPI patch)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

