Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTDEDYE (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 22:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTDEDYE (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 22:24:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40576 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261747AbTDEDYE (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 22:24:04 -0500
Date: Fri, 04 Apr 2003 19:35:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: andrea@suse.de, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <8090000.1049513712@[10.10.2.4]>
In-Reply-To: <20030404192201.75794957.akpm@digeo.com>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain><20030404105417.3a8c22cc.akpm@digeo.com><20030404214547.GB16293@dualathlon.random><20030404150744.7e213331.akpm@digeo.com><20030405000352.GF16293@dualathlon.random><20030404163154.77f19d9e.akpm@digeo.com><12880000.1049508832@flay> <20030404192201.75794957.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >   objrmap does not seem to help.  Page clustering might, but is unlikely to
>> >   be enabled on the machines which actually care about the overhead.
>> 
>> eh? Not sure what you mean by that. It helped massively ...
>> diffprofile from kernbench showed:
>> 
>>      -4666   -74.9% page_add_rmap
>>     -10666   -92.0% page_remove_rmap
>> 
>> I'd say that about an 85% reduction in cost is pretty damned fine ;-)
>> And that was about a 20% overall reduction in the system time for the
>> test too ... that was all for partial objrmap (file backed, not anon).
> 
> In the test I use (my patch management scripts, which is basically bash
> forking its brains out) objrmap reclaims only 30-50% of the rmap CPU
> overhead.
> 
> Maybe you had a very high sharing level.

Not especially, I was running "make -j 32" for that one, which seems like
a fairly small sharing load (though maybe a bit lighter than yours still).
Going to high numbers of tasks will show even more impressive improvements.
"make -j 256" actually looked reasonably similar.

M.

