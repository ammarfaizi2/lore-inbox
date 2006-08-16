Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWHPR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWHPR4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWHPR4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:56:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51104 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932129AbWHPR4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:56:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: Re: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<1155666193191-git-send-email-ebiederm@xmission.com>
	<20060816193557.GA586@oleg> <20060816084313.2cffca66.akpm@osdl.org>
Date: Wed, 16 Aug 2006 11:55:52 -0600
In-Reply-To: <20060816084313.2cffca66.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 16 Aug 2006 08:43:13 -0700")
Message-ID: <m1r6zg1s5z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 16 Aug 2006 23:35:57 +0400
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
>> On 08/15, Eric W. Biederman wrote:
>> >
>> > diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
>> > index 28eff1a..d7e0187 100644
>> > --- a/drivers/char/vt_ioctl.c
>> > +++ b/drivers/char/vt_ioctl.c
>> > @@ -645,12 +645,13 @@ #endif
>> >  	 */
>> >  	case KDSIGACCEPT:
>> >  	{
>> > -		extern int spawnpid, spawnsig;
>> > +		struct pid *spawnpid;
>> 		^^^^^^^^^^^^^^^^^^^^
>> Should be "extern struct pid *spawnpid" ?
>> 
>
> It was updated thusly:  (the identifiers are a bit generic-sounding though)

I need to relook at this.  But I believe Oleg found an idiom bug in
f_getown that will also apply here.  Basically if the update is not
an atomic transaction then we need to hold a lock when updating the
struct pid pointer so updates and uses of the pointer don't race.

Assuming I need to address that.  I will place spawnpid, spawnsig,
and their lock into a structure and see if I can give it a little
bit better name.

My only defense.  I didn't change the name in the first place. :)

Eric
