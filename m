Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWCOGDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWCOGDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWCOGDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:03:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40910 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932607AbWCOGDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:03:02 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Kirill Korotaev <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question: pid space semantics.
References: <1142282940.27590.17.camel@localhost.localdomain>
	<m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
	<20060314224037.GA1843@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 14 Mar 2006 23:01:51 -0700
In-Reply-To: <20060314224037.GA1843@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Tue, 14 Mar 2006 23:40:37 +0100")
Message-ID: <m1r754i6uo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Tue, Mar 14, 2006 at 11:43:38AM -0700, Eric W. Biederman wrote:
>> 
>> To retain any part of the existing unix process management
>> we need some processes that show up in multiple pid spaces.
>
> hmm ... not sure about that, what 'we' need is a way
> to move between pid spaces and to control processes
> in a child space from the parent process ...

The conditional was this is what it takes to reuse the existing
interfaces.

> nevertheless I don't think we have a problem with
> schizophrenic processes if they have a somewhat sane
> *G* interface/view into both spaces ...
>
>> To allow for migration it must be possible for the pids in 
>> those pid spaces to be different.
>
> I take that as migration of a 'container' from one
> system to another, not as 'migration' between spaces

Yes.

> I don't understand what you mean here, please elaborate

Basically that in the general case there can be no assumptions
that a pids in one pid space do not conflict with pids in another pids
space.

>> It is undesirable in the normal case of affairs to allocate more
>> than one pid per process.
>> 
>> Given the small range of pid values these constraints make an
>> efficient and general pid space solution challenging.
>> 
>> The question:
>>   If we could add additional pid values in different pid spaces 
>>   to a process with a syscall upon demand would that lead to an
>>   implementation everyone could use? 
>
> again, for what would I need a 'second' or 'third' pid
> value for a process either on demand or permanent for
> handling or migration?

Not for migration for things such a ptrace, ioprio, granting of
capabilities or any of the kernel's management operations 

Eric
