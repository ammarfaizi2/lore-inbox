Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWHPCn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWHPCn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWHPCn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:43:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:13408 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWHPCnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m1MeJ2UuQd3HaxLhqHzdoXKTycvaFe1Tnjb+1bW/9olUFe/84KF6nCJDCRxoS2N1Ey7XaYmCY7Ia8z1XN/dNsIhDh27ygt+IF6/egtNd/HyWr25PcxUrNqLti3gWjuSjex9Mln+5nScDhBpk+jV1xYxTf/nmAWYaLVp6OB6SHXw=
Message-ID: <787b0d920608151943k3d39b5b4v26f85cfbc527514c@mail.gmail.com>
Date: Tue, 15 Aug 2006 22:43:24 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: casey@schaufler-ca.com, serue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler writes:
> --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:

>> +    bprm->cap_effective = fscaps[0];
>> +    bprm->cap_inheritable = fscaps[1];
>> +    bprm->cap_permitted = fscaps[2];
>
> It does not appear that you're attempting
> to maintain the POSIX exec semantics for
> capability sets. (If you're doing it
> elsewhere in the code, nevermind) I don't
> know if this is intentional or not.

Stop right there. No such POSIX semantics exist.
There is no POSIX standard for this. Out in the
wild there are numerous dangerously incompatible
ideas about this concept:

a. SGI IRIX, and one draft of a failed POSIX proposal
b. Linux (half done), and a very different draft
c. DG-UX, which actually had a workable system
d. Solaris, which is workable and getting used

My rant from 4 years ago mostly applies today.
http://lkml.org/lkml/2003/10/22/135

(yes, we have a lame SGI-style set of bits with
a set of equations that is not compatible)

Something has changed though: people are actually
using this type of thing on Solaris. Probably the
sanest thing to do is to copy Solaris: equations,
tools, set of bits, #define names, API, etc. Just
let Sun be the standard, and semi-portable apps
will be able to use the feature. Cross-platform
admins will be very grateful for the consistency.
