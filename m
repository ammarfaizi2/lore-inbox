Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263935AbTDNVNH (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTDNVNH (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:13:07 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:3205 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263935AbTDNVNF (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:13:05 -0400
Message-ID: <3E9B2716.6030503@nortelnetworks.com>
Date: Mon, 14 Apr 2003 17:24:38 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bryan Shumsky <bzs@via.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory mapped files question
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com>	 <004301c302bd$ed548680$fe64a8c0@webserver> <1050349977.26521.2.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2003-04-14 at 20:42, Bryan Shumsky wrote:
> 
>>Rewriting all of our code to manually handle the flushing is a MAJOR
>>undertaking, so I was hoping there might be some sneaky solution you could
>>come up with.  Any ideas?
>>
> 
> Create a thread that does msync's every so often. Its that simple

How do you deal with ensuring (or even trying to ensure) that the stuff *on 
disk* is sane?

If I understand correctly, msync() doesn't guarantee order of writes, so 
randomly firing off msync() calls doesn't help.

If I want to update an entry and then set a flag saying that the entry is 
correct, I need to have two msyncs, one for the entry data, and one for the 
flag.  I had hoped that I could avoid this by opening the file with O_SYNC, but 
hpa just disabused me of that notion...

Are the mmap semantics different for devices?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

