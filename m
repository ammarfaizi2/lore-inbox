Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264741AbUDWHqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbUDWHqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 03:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264748AbUDWHqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 03:46:24 -0400
Received: from smtpout.mac.com ([17.250.248.85]:19425 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S264741AbUDWHqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 03:46:23 -0400
Message-ID: <3858114.1082706381475.JavaMail.pwaechtler@mac.com>
Date: Fri, 23 Apr 2004 09:46:21 +0200
From: Peter Waechtler <pwaechtler@mac.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] coredump - as root not only if euid switched
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Thursday, April 22, 2004, at 09:53PM, Chris Wright <chrisw@osdl.org> wrote:

>* Peter W�chtler (pwaechtler@mac.com) wrote:
>> Am Do, 2004-04-22 um 11.56 schrieb Andrew Morton:
>> > Peter Waechtler <pwaechtler@mac.com> wrote:
>> > >
>> > >  >(why are you trying to unlink the old file anyway?)
>> > >  >
>> > > 
>> > >  For security measure :O
>> > >  I tried on solaris: touch the core file as user, open it and wait, dump core
>> > >  as root -> nope, couldn't read the damn core - it was unlinked and created!
>> > 
>> > hm, OK.  There's a window in which someone can come in and recreate the
>> > file, but the open is using O_EXCL|O_CREATE so that seems safe enough.
>> 
>> So here is the updated patch with an open coded call to sys_unlink
>
>This patch breaks various ptrace() checks.
>

I guess the mm->dumpable flag was misused then as something like mm->switchUid.
I can add this flag and make the ptrace paths use that.

