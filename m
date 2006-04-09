Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWDIJ0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWDIJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWDIJ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 05:26:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24790 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750717AbWDIJ0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 05:26:19 -0400
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Sam Vilain <sam@vilain.net>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       "Serge E. Hallyn" <serue@us.ibm.com>, James Morris <jmorris@namei.org>
Subject: Re: [Devel] Re: [PATCH 3/7] uts namespaces: use init_utsname when
 appropriate
References: <20060407234815.849357768@sergelap>
	<20060408045206.EAA8E19B8FF@sergelap.hallyn.com>
	<m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
	<1144539879.11689.1.camel@localhost.localdomain>
	<4438518A.1040801@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 09 Apr 2006 03:25:04 -0600
In-Reply-To: <4438518A.1040801@openvz.org> (Kir Kolyshkin's message of "Sun,
 09 Apr 2006 04:12:58 +0400")
Message-ID: <m1acavje33.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kir Kolyshkin <kir@openvz.org> writes:

> Sam Vilain wrote:
>
>>On Sat, 2006-04-08 at 01:09 -0600, Eric W. Biederman wrote:
>>
>>
>>>>-#define ELF_PLATFORM  (system_utsname.machine)
>>>>+#define ELF_PLATFORM  (init_utsname()->machine)
>>>> #ifdef __KERNEL__
>>>> #define SET_PERSONALITY(ex, ibcs2) do { } while (0)
>>>>
>>>>
>>>I think this one needs to be utsname()->machine.
>>>Currently it doesn't matter.  But Herbert has expressed
>>>the desire to make a machine appear like an older one.
>>>
>>>
>>
>>This is extremely useful for faking it as "i386" on x86_64 systems, for
>>instance.
>>
>>
> Could 'setarch' be of any help here? Works fine for us. Or am I missing
> something?

For the specific case that is clearly the better solution,
as it already exists, and it handles the weird 32/64bit
logic.  The ELF_PLATFORM bit I was commenting on was 32bit
only.

I'm not ready to implement any new functionality at the moment,
but what I heard suggested and was it may be reasonable to allow
machine to be modified on a per uts namespace basis.  If that
kind of thing is ever to happen ELF_PLATFORM needs to be per
uts on x86.  Actually allowing modification of machine is
an entirely different conversation.

Eric
