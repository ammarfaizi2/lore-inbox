Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWIFJgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIFJgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWIFJgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:36:21 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:2729 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750733AbWIFJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:36:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X5H+vnUpVpGtRbxNzsVNJ3mOlEuc6mYThuP7CyxDTN6wdyCkZwlQ3Cutu/WPPS5Qu97V1M+z3EYZ7qJAIoL8EteB4TXVDaq87PLyirALZhkhDuEp5KT4fDra8mTlmiSP4/sglIG2J0Y6S8cwkrGhpkFB32t9vBp9Wfyfit4uEAk=  ;
Message-ID: <44FE9690.7060008@yahoo.com.au>
Date: Wed, 06 Sep 2006 19:36:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com> <44FE6CD6.4040809@yahoo.com.au> <200609060936.19268.ak@suse.de>
In-Reply-To: <200609060936.19268.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>Silly question, why can't you do all this from stop_machine_run context (or
>>your SMI) that doesn't have to worry about other CPUs dirtying memory?
>>
>
>Because that would be too slow for continuous mirroring.
>
>You can't go through 10+GB of virtual memory (or more with shared 
>memory because the scan has to be virtual) in an interrupt.
>
>The only sane way is to do it continuously.
>

Presumably it is not continuous but there are checkpoints, and in the
worst case, enforcement of a checkpoint will require an SMI.

But OK, heuristically I'm sure it is much quicker to already have most
memory saved. I guess this is a requirement otherwise they would have
done it the obvious way... but my question is just about what exact
requirement does this satisfy that a stop_machine would not.

>
>>[*] Though if it gets included, it would not stop me lamenting the
>>proliferation of complexities to support *tiny* obscure userbases. Can
>>we wait until your hardware is smart enough to snoop the cc? :)
>>
>
>
>My guess is that if we had a generic memory mirror subsystem other people would
>find uses for it too. e.g. a lot of systems support spare DIMMs these days and mirroring
>some memory to it seems like a smart idea. That means normally the hardware
>does it, but perhaps some stuff can be done better by doing it in software.
>
>Or it is also a bit similar to the algorithms Xen uses for live migration.
>If that was implemented on the kernel level something like this might 
>be useful too. I think OpenVZ has some kind of migration support, but it's
>currently not live.
>

Yep, I'm not saying it couldn't be useful.

Send instant messages to your online friends http://au.messenger.yahoo.com 
