Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUEQHTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUEQHTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUEQHTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 03:19:51 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:34957 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264920AbUEQHTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 03:19:49 -0400
Message-ID: <40A86789.6030006@myrealbox.com>
Date: Mon, 17 May 2004 00:19:37 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       Andy Lutomirski <luto@myrealbox.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
References: <fa.id6it11.41id3h@ifi.uio.no> <fa.gf5v6pu.c2mkrq@ifi.uio.no>
In-Reply-To: <fa.gf5v6pu.c2mkrq@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Olaf Dietsche (olaf+list.linux-kernel@olafdietsche.de) wrote:
> 
>>Andy Lutomirski <luto@myrealbox.com> writes:
>>
>>
>>>cap_2.6.6-mm2_4.patch: New stripped-back capabilities.
>>>
>>> fs/exec.c               |   15 ++++-
>>> include/linux/binfmts.h |    9 ++-
>>> security/commoncap.c    |  130 ++++++++++++++++++++++++++++++++++++++++++------
>>> 3 files changed, 136 insertions(+), 18 deletions(-)
>>
>>[patch]
>>
>>Why don't you provide this as a configurable andycap.c module?
>>I think, this is the whole point of LSM.
> 
> 
> I agree, if we can't find a clean way to do it.  However, note this
> includes changes to core.  And it's nice to fix this for the base case.

On the other hand, this version has minimal changes to core (it adds a new 
field to linux_binprm and makes fs/exec.c fill in some extra information). 
  These changes shouldn't break any existing code, as the current behavior 
is for bprm->cap_* to be undefined when bprm_set_security is called.  None 
of this is strictly necessary for my patch, but it makes it a lot cleaner.

So, if the core changes were merged, my caps semantics could be maintained 
as a (fairly simple) separate LSM.  That prevents it working with SELinux 
or other (non-stacking) LSMs loaded.

--Andy
