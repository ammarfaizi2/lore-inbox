Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWBHAT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWBHAT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWBHAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:19:58 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:47716 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030307AbWBHAT5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:19:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MV8jVzP9Z/AZJoLFjHp4Rq3rAl0UkdCm512A4h3ZluMb4QZSm0IquA+GcNNkAOyfZrlbZg4FXWnm7zs8zGJyFroyDQegSxFPLZxCj/lwMCswZn1BNOeRR02J2K70TgadEM26/CEYz2YKDeYABUaBb7qmQ/snCZrLuWYDVuNFFBc=
Message-ID: <a36005b50602071619w379980a2se9d78131a8e2b7bd@mail.gmail.com>
Date: Tue, 7 Feb 2006 16:19:56 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: pid_t range question
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
	 <m1pslystkz.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> I know for certain that proc assumes it can fit pid in
> the upper bits of an ino_t taking the low 16bits for itself
> so that may the entire reason for the limit.

Is this still the case?  For the 100,000 threads tests Ingo and I were
running Ingo certainly came up with some patches to make /proc behave
better.  This was before we had subdirs for thread groups.

Anyway, I think we should put a reasonable top on the number of bits
for the PIDs.  One reason is that the current (and fastest) design for
more complex mutexes needs to encode more information than the PID in
an 'int'.  See the latest robust mutex patches for an example.  If the
limit could be, say, 28 bits that would still enable using more
processes and threads then anybody wants so far.  Who know, when we
hit this limit, maybe we have separate namespaces.  If not, we can
still fix the existing limits but this would come at a cost which is
why I think it's not worth doing now.
