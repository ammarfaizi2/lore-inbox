Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWJKTtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWJKTtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWJKTtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:49:04 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:61264 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932454AbWJKTtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:49:01 -0400
Message-ID: <452D4AA9.4030700@tls.msk.ru>
Date: Wed, 11 Oct 2006 23:48:57 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOT] GIT usage question
References: <452D3DFA.6010408@tls.msk.ru> <20061011182415.GE5050@1wt.eu>
In-Reply-To: <20061011182415.GE5050@1wt.eu>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Wed, Oct 11, 2006 at 10:54:50PM +0400, Michael Tokarev wrote:
[]
>>  o origin which points to Linus's 2.6.19-pre
>>  o libata, which is current libata tree
>>  o 2.6.18 release -- the kernel I'm running right now.
>>
>> I want to get changes *for libata subsystem* in origin or
>> libata (libata is just changes which are on the way to Linus,
>> and current difference is very minor), to apply against 2.6.18.
>> Ie, in short, changes which went to origin *from* libata.
>>
>> Is it possible?
> 
> If I understand what you want to do, you just have to do this :
> 
> $ git-checkout 2.6.18
> $ git-pull . libata
> 
> This will merge in 2.6.18 everything that's in libata. If you

It will merge everything wich is in current 2.6.19-pre, too.
Ie, it will be current 2.6.19 tree basically, or 'origin' in
my case.

(currently, the only 2 differences between origin and libata
is a tiny bugfix and winbond driver, so using libata or origin
here is basically the same thing).

But I wanted to _omit_ everything _but_ libata - stuff which
*come* to Linus's tree from libata) from the diff.

So it looks like the key idea is to find which commits are
relevant.  With libata as an example, it's relatively easy -
  git-diff 2.6.18..libata drivers/ata
(       or 2.6.18..origin drivers/ata -- as the two trees are
almost the same currently), plus some includes.

Ie, some other ways needs to be used to *identify* which parts
of the whole thing is needed, in this example it's easy as
everything is located in the same dir.

With more complex changes, things aren't that simple if at all
possible, BUT there's almost no chances that the resulting
"patched-2.6.18" will ever compile after trying to apply that
complex changes, anyway ;)

But thanks anyway ;)

/mjt
