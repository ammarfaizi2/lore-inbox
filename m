Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVJXSWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVJXSWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJXSWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:22:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:6834 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751236AbVJXSWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:22:43 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <435D2612.5070701@s5r6.in-berlin.de>
Date: Mon, 24 Oct 2005 20:21:06 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, bcollins@debian.org,
       Greg KH <greg@kroah.com>, scjody@steamballoon.com, gregkh@suse.de
Subject: Re: new PCI quirk for Toshiba Satellite?
References: <20051015185502.GA9940@plato.virtuousgeek.org> <200510211138.57847.jbarnes@virtuousgeek.org> <43594BD3.9070103@s5r6.in-berlin.de> <200510241045.08494.jbarnes@virtuousgeek.org>
In-Reply-To: <200510241045.08494.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.389) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Friday, October 21, 2005 1:13 pm, Stefan Richter wrote:
>>Jesse Barnes wrote:
>>>But then what about the dev->current_state = 4?  Is that necessary?
>>
>>It is necessary; at least if the workaround resides in ohci1394.
>>Otherwise the controller won't come back after a suspend/ resume
>>cycle. (See Rob's post from February,
>>http://marc.theaimsgroup.com/?m=110786495210243 ) Maybe there is
>>another way to do that if the workaround was moved to pci/quirks.c.
> 
> Having it all in the driver probably makes the most sense if we have to 
> have code there anyway.  Otherwise future users may have to check both 
> places if things break again in another configuration.

No, better move it to pci/quirks.c. I may be wrong (again) but I think
everything of the workaround can be done there.

>>Furthermore, everything which belongs to the workaround should IMO be
>>enclosed by #ifdef SOME_SENSIBLE_MACRO. This avoids kernel bloat for
>>any target which is surely not a Toshiba laptop. Rob used an #if
>>defined(__i386__).
> 
> Checks against the compiler defined arch are usually wrong since users 
> could be cross compiling, and I'd like to avoid an ifdef altogether.

Once the workaround is in pci/quirks.c, a single #ifdef would suffice
(if it is still of any benefit there).
-- 
Stefan Richter
-=====-=-=-= =-=- ==---
http://arcgraph.de/sr/
