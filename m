Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUE0F73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUE0F73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUE0F73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:59:29 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:58522 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261439AbUE0F72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:59:28 -0400
Message-ID: <40B583BC.7030706@yahoo.com.au>
Date: Thu, 27 May 2004 15:59:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <40B4667B.5040303@nodivisions.com> <40B46A57.4050209@yahoo.com.au> <20040526161127.A30461@animx.eu.org>
In-Reply-To: <20040526161127.A30461@animx.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
>>>Come on, that is quite an exaggeration.  It can happen in a span of 
>>>minutes -- after rsyncing a dir to a backup dir, for example, which 
>>>fills ram rather quickly with cache I'll never use again.  Or after 
>>>configuring and compiling a package, which does the same thing.
>>>
>>
>>rsync is something known to break the VM's use-once heuristics.
>>I'm looking at that.
> 
> 
> I have a question about that.  I keep a debian mirror on one of my machines. 
> there is over 70000 files.  If I run find on that tree while it's
> downloading the file list, it doesn't take as long.  I thought it would be
> nice if there was some way I could keep that in memory.  The box has 256mb
> ram no swap.  It is configured as diskless.
> 

You mean that if you prime the cache by running find on the tree,
your actual operation doesn't take as long?

I don't doubt this. Slab cache is shrunk aggressively compared to
page cache. Traditionally I think this has been due at least in
part to some failure cases in the balancing there resulting in slab
growing out of control with some systems.

These failure cases should be fixed now, and slab vs pagecache is
probably something that should be looked at again. I really need
to get my hands on a 2GB+ system before I'd be game to start
fiddling with too much stuff though.
