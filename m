Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWIGSiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWIGSiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWIGSiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:38:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50051 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751687AbWIGSiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:38:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] proc: Remove the hard coded inode numbers.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
	<m1fyf5x8ny.fsf_-_@ebiederm.dsl.xmission.com>
	<20060907102214.4be99fff.akpm@osdl.org>
	<m1lkovr26o.fsf@ebiederm.dsl.xmission.com>
	<20060907110659.373d6f2b.akpm@osdl.org>
Date: Thu, 07 Sep 2006 12:37:32 -0600
In-Reply-To: <20060907110659.373d6f2b.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 7 Sep 2006 11:06:59 -0700")
Message-ID: <m1venzploz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 07 Sep 2006 11:55:59 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Hey, thanks for the review.
>> 
>> I don't think so but a comment or two might be in order.
>> 
>> Calling filldir with the filename is the important part,
>> and the only real error is if filldir fails.
>> 
>> The rest of the logic is about populating and querying the
>> dcache so we can find our real inode number, if every reasonable
>> attempt to perform a dcache lookup fails I simply set the inode
>> number to 1 and use that in filldir.  It's wrong but at least
>> I report the file is there.
>> 
>> If I can find the dentry I lookup the inode and the inode
>> number and file type, and the dput the dentry.
>> 
>> If I can't lookup the dentry I attempt to create it.
>> instantiate will return a dentry or NULL if the dentry I preallocate
>> for it is good enough.
>
> I suspected it was something like that.
>
>> Is there something specific you are not seeing?
>
> Code comments explaining this stuff ;)

Sure.  Not every looks at how this is done in filesystems like
smbfs, and fat.

When I get a moment I will see if I can cook up a big fat comment.

Eric





