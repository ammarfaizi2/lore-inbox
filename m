Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWHBCjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWHBCjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHBCjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:39:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12225 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751083AbWHBCjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:39:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 11/33] i386 boot: Add an ELF header to bzImage
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<1154430236812-git-send-email-ebiederm@xmission.com>
	<44CFD148.9020300@goop.org>
Date: Tue, 01 Aug 2006 20:38:01 -0600
In-Reply-To: <44CFD148.9020300@goop.org> (Jeremy Fitzhardinge's message of
	"Tue, 01 Aug 2006 15:10:16 -0700")
Message-ID: <m1mzanx3p2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Eric W. Biederman wrote:
>> +.macro note name, type
>> +	.balign 4
>> +	.int	2f - 1f			# n_namesz
>> +	.int	4f - 3f			# n_descsz
>> +	.int	\type			# n_type
>> +	.balign 4
>> +1:	.asciz "\name"
>> +2:	.balign 4
>> +3:
>> +.endm
>> +.macro enote
>> +4:	.balign 4
>> +.endm
>>
>
> This is very similar to the macro I introduced in the Paravirt note segment
> patch.  Do think they should be made common?

Yes.  At the point of merging these two approaches I think the notes
should just be put into vmlinux and copied either into the ELF
header or more likely into a segment that build.c tacks onto
the kernel.

It is such a small piece of my overall picture I wasn't really looking
at that.

>> +/* Elf notes to help bootloaders identify what program they are booting.
>> + */
>> +
>> +/* Standardized Elf image notes for booting... The name for all of these is
> ELFBoot */
>> +#define ELF_NOTE_BOOT		"ELFBoot"
>>
>
> I wonder if this should be something to suggest its Linux-specific?  Or do you
> see this being used by a wider audience?

This note is used in etherboot and LinuxBIOS right now so it isn't terribly linux
specific.  And whatever the virtues of it's name it is actually in use.

I had a preliminary RFC for using these in a winder context at one point but I
ran out of energy for pushing it.

I think the information in those note headers is interesting beyond that I
really don't much care.

Eric

