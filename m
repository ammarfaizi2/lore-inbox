Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWGJRAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWGJRAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWGJRAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:00:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4998 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422699AbWGJRAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:00:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EkHYr/PSNVknbDpsKxoveff11sRJEAdD7jedoYrCyE6YYNk76X+Ff8zKVONte0UWQNIP+Z3JsSuWTnJUoEag9u26zD2+sRXsdvZgh6Scg25nbcDDS6o1Wic97RwoHSROrEckrOnLx1vohle3PGbiMZonmXBmsWWkjv/lpndTUrc=
Message-ID: <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
Date: Mon, 10 Jul 2006 10:00:37 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
In-Reply-To: <20060710034250.GA15138@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44B0FAD5.7050002@argo.co.il>
	 <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
	 <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com>
	 <20060710034250.GA15138@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So this would tend to confirm the rule of thumb: use of "volatile" in
> a userspace progam tends to indicate a bug.
>
>                                                 - Ted

No. vfork(), setjmp(), signal().

Yes, I use vfork. So far, the only way I have found for the parent to
know whether or not the child's exec() failed is this way:

volatile int failed;
pid_t pid;

failed = 0;
if (0 == (pid = vfork())) {
   execve(argv[0], argv, envp);
   failed = errno;
   _exit(0);
}
if (pid < 0) {
   /* can't fork */
}
if (failed) {
   /* wait for pid (clean up zombie) */
   errno = failed;
   /* can't exec: update state */
}
