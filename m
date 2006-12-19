Return-Path: <linux-kernel-owner+w=401wt.eu-S932799AbWLSLs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbWLSLs3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWLSLs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:48:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:35364 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbWLSLs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:48:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender;
        b=lgE3rKziApPNG9vRBm+nFa7BwHOcudqI2ZAYze7+ybiO3N3obehZ5KdkZwEtZ1bhSXVOT7IWu+TK+Oa85gZUsRdX7dZxbnatVBIXXTQjfkhruz3L+XQPKLG8zPXr4vAB2dVB5m6nzYcteRFcuVjyJ+H3YqUIcIGSBjL7SqI0q1k=
From: David Wragg <david@wragg.org>
To: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
References: <87zm9k228f.fsf@wragg.org> <20061219063955.GN1104@kvack.org>
Date: Tue, 19 Dec 2006 11:47:06 +0000
In-Reply-To: <20061219063955.GN1104@kvack.org> (Benjamin LaHaise's message of
	"Tue\, 19 Dec 2006 01\:39\:55 -0500")
Message-ID: <87fybc9kg5.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:
> On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
>> This patch (against 2.6.19/2.6.19.1) adds the four context switch
>> values (voluntary context switches, involuntary context switches, and
>> the same values accumulated from terminated child processes) to the
>> end of /proc/*/stat, similarly to min_flt, maj_flt and the time used
>> values.
>
> Please put these into new files, as the stat files in /proc are 
> horribly overloaded and have always been somewhat problematic 
> when it comes to changing how things are reported due to internal 
> changes to the kernel.  Cheers,

The delay accounting value was added to the end of /proc/pid/stat back
in July without discussion, so I assumed this approach was still
considered satisfactory.

Putting just these four values into a new file would seem a little
odd, since they have a lot in common with the other getrusage values
that are already in /proc/pid/stat.  One possibility is to add
/proc/pid/rusage, mirroring the full struct rusage in text form, since
struct rusage is already part of the kernel ABI (though Linux doesn't
fill in half of the values).

Or perhaps it makes sense to reorganize all the values from
/proc/pid/stat and its siblings into a sysfs-like one-value-per-file
structure, though that might introduce atomicity and efficiency issues
(calculating some of the values involves iterating over the threads in
the process; with everything in one file, these loops are folded
together).

Any thoughts?


David
