Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUJKMlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUJKMlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUJKMlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:41:02 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:4047 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268899AbUJKMjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:39:21 -0400
Message-ID: <416A7EE4.6060500@portrix.net>
Date: Mon, 11 Oct 2004 14:39:00 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <hermes@gibson.dropbear.id.au>
CC: Cal Peake <cp@absolutedigital.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net> <416A7484.1030703@portrix.net> <Pine.LNX.4.61.0410110819370.8480@linaeum.absolutedigital.net> <416A7CB3.9000003@portrix.net> <20041011123217.GC28100@zax>
In-Reply-To: <20041011123217.GC28100@zax>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Mon, Oct 11, 2004 at 02:29:39PM +0200, Jan Dittmer wrote:
> 
>>Cal Peake wrote:
>>
>>>On Mon, 11 Oct 2004, Jan Dittmer wrote:
>>>
>>>
>>>
>>>>Cal Peake wrote:
>>>>
>>>>
>>>>
>>>>>	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
>>>>>-	readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
>>>>>+	readw((void __iomem *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
>>>>>#define hermes_write_reg(hw, off, val) do { \
>>>>
>>>>Isn't the correct fix to declare iobase as (void __iomem *) ?
>>>
>>>
>>>iobase is an unsigned long, declaring it as a void pointer is prolly not 
>>>what we want to do here. The typecast seems proper. A lot of other drivers 
>>>do this as well thus it must be proper ;-)
>>
>>Why is iobase a unsigned long in the first place? Isn't this broken for 
>>64bit archs?
> 
> 
> Um, no.
> 

Yeah, just rememberd when sending the mail ;-). Still, most drivers seem 
to use (void __iomem *) in the declaration of their iobase.

Jan
