Return-Path: <linux-kernel-owner+w=401wt.eu-S932983AbWLTFlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbWLTFlA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 00:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932981AbWLTFlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 00:41:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbWLTFk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 00:40:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=C9IgrUFdxE3LxU2Q+MTmBPzE8DENsSvt/pGAw0z+w/7qAQhMuWow7apenKdCMvLC1qlYlfu0Dpop1VbAc2c1m5RE6uc0jw2Cpv/HNPLccgE6SLRPrqzusDBX49A9PnH9jq0TlHn9bspv8BJH9r3AaJ0GDUtkTvgbFIsLie9KkK0=
Message-ID: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
Date: Wed, 20 Dec 2006 00:40:57 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: david@wragg.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wragg writes:
> Benjamin LaHaise <bcrl@kvack.org> writes:
>> On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:

>>> This patch (against 2.6.19/2.6.19.1) adds the four context
>>> switch values (voluntary context switches, involuntary
>>> context switches, and the same values accumulated from
>>> terminated child processes) to the end of /proc/*/stat,
>>> similarly to min_flt, maj_flt and the time used values.

Hmmm, OK, do people have a use for these values?

>> Please put these into new files, as the stat files in /proc are
>> horribly overloaded and have always been somewhat problematic
>> when it comes to changing how things are reported due to internal
>> changes to the kernel.  Cheers,

No thanks. Yours truly, the maintainer of "ps", "top", "vmstat", etc.

> The delay accounting value was added to the end of /proc/pid/stat back
> in July without discussion, so I assumed this approach was still
> considered satisfactory.

/proc/*/stat is the very best place in /proc for any per-process
data that will be commonly needed. Unlike /proc/*/status, few
people are tempted to screw with the formatting and/or spelling.
Unlike the /sys crap, it doesn't take 3 syscalls PER VALUE to
get at the data.

The things to ask are of course: will this really be used, and
does it really belong in /proc at all?

> Putting just these four values into a new file would seem a little
> odd, since they have a lot in common with the other getrusage values
> that are already in /proc/pid/stat.  One possibility is to add
> /proc/pid/rusage, mirroring the full struct rusage in text form, since
> struct rusage is already part of the kernel ABI (though Linux doesn't
> fill in half of the values).

Since we already have a struct defined and all...

sys_get_rusage(int pid)

> Or perhaps it makes sense to reorganize all the values from
> /proc/pid/stat and its siblings into a sysfs-like one-value-per-file
> structure, though that might introduce atomicity and efficiency issues
> (calculating some of the values involves iterating over the threads in
> the process; with everything in one file, these loops are folded
> together).

Yeah, big time. Things are quite bad in /proc, but /sys is a joke.
