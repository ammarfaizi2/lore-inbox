Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULZWTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULZWTq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 17:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbULZWTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 17:19:46 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:48025
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261174AbULZWTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 17:19:43 -0500
Message-ID: <41CF3BBC.9010304@bio.ifi.lmu.de>
Date: Sun, 26 Dec 2004 23:31:24 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>, Jens Axboe <axboe@suse.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: kblockd/1: page allocation failure in 2.6.9
References: <41C7D32D.2010809@bio.ifi.lmu.de>	 <41CAAB61.3030704@bio.ifi.lmu.de>	 <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua>	 <41CAEA62.4060903@bio.ifi.lmu.de>  <20041224132006.GC2528@suse.de>	 <1103916492.5448.27.camel@mulgrave>  <41CDEE8A.80407@bio.ifi.lmu.de> <1104076000.5268.18.camel@mulgrave>
In-Reply-To: <1104076000.5268.18.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote

> The kblockd message is just a symptom of the machine running low on
> memory and starting to fail normal kernel memory allocations.  There's
> always a potential for hangs when something can't allocate memory:
> usually it's in the middle of a transaction and just forgets about it;
> what should happen (as we just verified SCSI does) is that the
> transaction should be rolled back and retried.

Ah, ok. Now at least I know what this messages mean! Indeed, as I wrote
in the first mail, 1.7GB of the 2GB memory of the machine were in use,
and that was "real" usage, i.e., without any buffers. But that was already
three hours after the failure occured. Unfortunately we didn't check what
process was using how much memory because we just rebooted as quick as
possible to get the server processes running again.
Might be a memory leak in some application, because neither the mysql
database nor the tomcat server should take more than a few hundred MB
of memory alltogether. I will ask the user to redo the mysql database
dump, maybe that was it and we can trigger the failure again. But that
will take two weeks until everyone is back in office :-)

> 
>>- there were no messages "around" the kblockd messages in /var/log/messages
>>   but the usual ones about remote ssh login, cron jobs etc., but the messages
>>   were all more than 10 minutes "away" before and after the kblockd happened.
> 
> That's unfortunate.  It means that whatever caused this left no trace.
> The best working theory is still a memory allocation failure somewhere.
> If it occurs again, could you get a full system process trace (<alt>-
> <sysrq>-t) and send that?  That might give a better clue as to what went
> on.

Yes, sure! If we can reproduce it, I will send the log and try to figure
out which process takes so much memory. Thanks for your help!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr 17            Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:              -4054
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
