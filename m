Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUDFDBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 23:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbUDFDBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 23:01:34 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:44743 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263601AbUDFDBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 23:01:31 -0400
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: Catching SIGSEGV with signal() in 2.6
Date: Mon, 5 Apr 2004 23:01:27 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404052040.54301.kevin.hendricks@sympatico.ca> <4072101F.3010603@redhat.com>
In-Reply-To: <4072101F.3010603@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404052301.28021.kevin.hendricks@sympatico.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> If the code would be correct you'd see the expected behavior.
> Since you jump out of a signal handling you must use siglongmp
> And sigsetjmp(check_env, 1) here.

So the code has been wrong since the beginning and we were just "lucky" it 
worked in all pre-2.6 kernels?

I have no doubt you are right but forgiving my ignorance here, please explain 
why must we use siglongjmp when longjmping out of a signal handler given that 

1. before the next use of the handler we use signal again to properly set the 
signal handler (and the set of masked signals).

and 

2. the mask of blocked signals will include sigsegv upon entry to the signal 
handler and therefore it will be masked after the normal longjmp since a 
normal longjmp wil not change the set of masked symbols.

What am I missing that makes sigsetjmp and siglongjmp a requirement, or is 
this just part of some specification someplace?

Kevin

