Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUEMBuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUEMBuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 21:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUEMBuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 21:50:12 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:16621 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262063AbUEMBuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 21:50:07 -0400
Message-ID: <40A2D449.7090103@myrealbox.com>
Date: Wed, 12 May 2004 18:50:01 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@osdl.org, linux-kernel@vger.kernel.org, luto@myrealbox.com
Subject: Re: [PATCH 0/2] capabilities
References: <200405112024.22097.luto@myrealbox.com> <20040512164132.2d30dac2.akpm@osdl.org>
In-Reply-To: <20040512164132.2d30dac2.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andy Lutomirski <luto@myrealbox.com> wrote:
> 
>>This reintroduces useful capabilities.
>>
> 
> 
> What if there are existing applications which are deliberately or
> inadvertently relying upon the current behaviour?  That seems unlikely, but
> the consequences are gruesome.

Like something that turns KEEPCAPS on then setuid()s then executes an 
untrusted program?  It's obviously wrong, but it's secure currently 
since the exec wipes capabilities.  And no one would notice.  Ugh!

> 
> If I'm right in this concern, the fixed behaviour should be opt-in.  That
> could be via a new prctl() thingy but I think it would be better to do it
> via a kernel boot parameter.  Because long-term we should have the fixed
> semantics and we should not be making people change userspace for some
> transient 2.6-only kernel behaviour.

The prctl would defeat the purpose (imagine if bash forgot the prctl -- 
then the whole thing is pointless).  I'll cook up the boot parameter in 
the next couple days (probably with a config option and some kind of 
warning that the old behavior is deprecated).  Is it a problem if I make 
the changes to init's state unconditional?  (I still don't see why 
CAP_SETPCAP is dangerous for root to have...)

The only concern is that some new code relies on the new inheritable 
semantics.  That shouldn't be so bad, though, since that's just an extra 
precaution (if there are insecure setuid binaries around, you already 
have problems).


--Andy

