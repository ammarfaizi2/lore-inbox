Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVAJJTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVAJJTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVAJJTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:19:55 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:60860
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S262167AbVAJJTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:19:45 -0500
Message-ID: <41E248AB.5020004@bio.ifi.lmu.de>
Date: Mon, 10 Jan 2005 10:19:39 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Jens Axboe <axboe@suse.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kblockd/1: page allocation failure in 2.6.9
References: <41C7D32D.2010809@bio.ifi.lmu.de>	 <41CAAB61.3030704@bio.ifi.lmu.de>	 <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua>	 <41CAEA62.4060903@bio.ifi.lmu.de>  <20041224132006.GC2528@suse.de>	 <1103916492.5448.27.camel@mulgrave>  <41CDEE8A.80407@bio.ifi.lmu.de> <1104076000.5268.18.camel@mulgrave> <41CF3BBC.9010304@bio.ifi.lmu.de>
In-Reply-To: <41CF3BBC.9010304@bio.ifi.lmu.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we can now reproduce the problem, but it looks like the problems are
not caused by the kblockd.

The problem on this host is that from time to time "ps -aux" just hangs
and starts eating up all memory. When it has taken enough, either some
kblockd message occurs, and/or the oom killer jumps in and starts killing
threads.
So, the ps -aux hangs *before* the kblockd messages occur, and is not
caused by it (like I assumed before). And since I don't get any disk
errors etc. after the kblockd messages, I guess everything is fine and
the scsi operation indeed recovers the way you said it should.

Now we just need to find out why ps -aux hangs. Seems to be a problem
with the nfsd, because it hangs when showing the [nfsd] entries and
works after restarting the nfs server. In case someone is interested
in this issue, I described it in more detail on the nfs list at 
http://marc.theaimsgroup.com/?l=linux-nfs&m=110509676609987&w=2

Thanks for your help!
cu,
Frank




-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
