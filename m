Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTH0R2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTH0R2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:28:15 -0400
Received: from mxrelay.osnanet.de ([212.95.97.103]:11477 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S263668AbTH0R2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:28:07 -0400
Message-ID: <3F4CE96D.2060807@lilymarleen.de>
Date: Wed, 27 Aug 2003 19:25:01 +0200
From: LGW <large@lilymarleen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030711 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: porting driver to 2.6, partly solved
References: <3F4CB452.2060207@lilymarleen.de>	<20030827081312.7563d8f9.rddunlap@osdl.org>	<3F4CCF85.1020502@lilymarleen.de>	<1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>	<3F4CD937.10204@lilymarleen.de> <20030827092918.0981fa71.rddunlap@osdl.org>
In-Reply-To: <20030827092918.0981fa71.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Wed, 27 Aug 2003 18:15:51 +0200 LGW <large@lilymarleen.de> wrote:
>
>| Alan Cox wrote:
>| 
>| >On Mer, 2003-08-27 at 16:34, LGW wrote:
>| >  
>| >
>| >>The driver is mostly a wrapper around a generic driver released by the 
>| >>manufacturer, and that's written in C++. But it worked like this for the 
>| >>2.4.x kernel series, so I think it has something todo with the new 
>| >>module loader code. Possibly ld misses something when linking the object 
>| >>specific stuff like constructors?
>| >>    
>| >>
>| >
>| >The new module loader is kernel side, it may well not know some of the
>| >C++ specific relocation types. 
>| >
>| To you think it's possible to remove those relocations completely, so 
>| that the whole C++ stuff is linked "without" any more open relocations?
>
>Hopefully Rusty will see this and make some comments on it.
>
>You could try using objdump to look for the item(s) that have this
>relocation type (0).  That might help to see what is causing it.
>
>Or you could modify the module loader to ignore relocation type 0...
>and see what happens.
>  
>
Hm objdump -r snd-echoaudio.ko gives about six records (of course many 
others):
R_386_NONE    *ABS*

I'm not really sure what they refer to. Or, I don't even know. I think 
that the driver uses some system functions and they are linked like 
that, or so? I had a look and R_386_NONE means "no relocation" - so it 
should be safe to ignore them?

Modifying the kernel module loader like

switch (reloc_type) {
...
  case R_386_NONE:
    break;
...
}

did the trick, but this feels like a really really really UGLY trick.

Of course the best thing would be to rewrite the whole stuff, as it is 
more than hacked together, but I don't have time to do so, know. At 
least the soundcard device appears and plays sound now. I'll see what 
time brings.

Thanks for your support,
  Lars


