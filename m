Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHHVBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHHVBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUHHVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:01:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:48831 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266292AbUHHVBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:01:35 -0400
Message-ID: <41169546.5000308@colorfullife.com>
Date: Sun, 08 Aug 2004 23:04:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [2/3] via-rhine: de-isolate PHY
References: <411684D5.8020302@colorfullife.com> <20040808200532.GA19170@k3.hellgate.ch>
In-Reply-To: <20040808200532.GA19170@k3.hellgate.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:

>  
>
>>I know that PHYs go into isolate mode if the startup id is wired to 0, 
>>    
>>
>
>Wouldn't that be s/go/can go/ ?
>
>  
>
I don't have the MII standard, my knowledge is from the DP83840A specs:
The pin description contains a section about the phy ids:
During power up five pins are latched to determine the initial phy address.
Then the following sentence in bold: "An address selection of all zeros 
(00000) will result in a PHY isolation condition".

I've reread the DP specs and I now think that your current patch is 
sufficient:
The isolate state is independant from the phy address - a non-zero phy 
can be in isolate mode and the phy zero can be non-isolated. The phy id 
just sets the power-up value of the isolate bit: 0 means start isolated, 
non-zero means start non-isolated.

If this is really true then handling phy 0 is trivial:
First scan 1-31. If nothing found: try 0. If a phy is found: clear the 
isolate bit and then use phy 0.

--
    Manfred
