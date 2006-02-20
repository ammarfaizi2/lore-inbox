Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWBTSMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWBTSMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWBTSMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:12:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63450 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161101AbWBTSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:12:35 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, B.Steinbrink@gmx.de,
       viro@ftp.linux.org.uk
Subject: Re: + daemonize-detach-from-current-namespace.patch added to -mm
 tree
References: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
	<1140425218.2979.14.camel@laptopd505.fenrus.org>
	<m1ek1ymmec.fsf@ebiederm.dsl.xmission.com>
	<20060220020943.1d9eac25.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Feb 2006 11:11:13 -0700
In-Reply-To: <20060220020943.1d9eac25.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 20 Feb 2006 02:09:43 -0800")
Message-ID: <m13bidnbni.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> I am beginning to suspect that we will want to fix kernel_thread so it
>>  creates copies of the init_task rather than copies of whatever random
>>  user space process we happen to be a member of at the time.  With an
>>  enhanced kernel_thread this problem could more easily avoided, as
>>  we add additional namespaces to the kernel.
>
> You wouldn't believe the problems we had with kernel_thread followed by
> call_usermodehelper() due to inheritance of random stuff from the userspace
> parent.
>
> A suitable solution is to stop using kernel_thread(), migrate to the
> kthread API - that way the threads are parented by keventd which is a known
> and good environment.

Thanks.  This sounds worth investigating.

On the other hand call_usermodehelper is the one case where we might
want to share some of the attributes with an existing process, at
least if we ever want it to run in a non-default namespace.

Eric

