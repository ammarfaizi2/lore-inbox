Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTAOQIE>; Wed, 15 Jan 2003 11:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266712AbTAOQIE>; Wed, 15 Jan 2003 11:08:04 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:16392
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S266702AbTAOQID>; Wed, 15 Jan 2003 11:08:03 -0500
Message-ID: <3E2588C6.4020906@Linux.ie>
Date: Wed, 15 Jan 2003 16:13:58 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos.Szeredi@eth.ericsson.se
CC: Larry.Sendlosky@storigen.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: VIA C3 and random SIGTRAP or segfault
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com> <3E257488.3000006@Linux.ie> <200301151556.h0FFupx12324@duna48.eth.ericsson.se>
In-Reply-To: <200301151556.h0FFupx12324@duna48.eth.ericsson.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos.Szeredi@eth.ericsson.se wrote:
>>segfault is what I saw. Something seems to be corrupted (by a cmov
>>SIGILL?) and from then the app will crash in the same
>>(arbitrary) place until the machine is restarted. Some apps
>>are more susceptible than others. Note a Samuel II would work fine?
> 
> Do you mean that after a cmov is encountered other applications will
> also randomly crash?  That would explain what I've been seeing.

Well I never got SIGILL as would be expected. I got SEGFAULTs
and I'm only speculating that a CMOV was encountered.
But yes that does seem to be what's happening, the
CMOV corrupts something global to many apps, and
"every now and then" SEGFAULT.

You could quickly check your system with something like:

find /bin -perm +111 -type f |
while read bin; do
     objdump --disassemble $bin 2>/dev/null |
     grep -q cmov && echo "$bin has cmov"
done

Pádraig.

