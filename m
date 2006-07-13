Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWGMFAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWGMFAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWGMFAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:00:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:61994 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932524AbWGMFAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:00:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EBfhjM0nanE6TUg9lJw+BXIzbuai4DhRU1ZZpcs9XZyq/06GncA/irmttgPI1Dp1ojKel6nHKVll94rOFDRdm8fI1pbDsECRxPEu6opyFh88dlW/kUgcV50dWcBNWC4j/Vw5tgHuXqhPbFVGSC1u1XrJKfv6SViFJTiqwlmnY6U=
Message-ID: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
Date: Thu, 13 Jul 2006 01:00:38 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: ak@suse.de, tytso@mit.edu, ebiederm@xmission.com, drepper@redhat.com,
       arjan@infradead.org, rdunlap@xenotime.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> On Thursday 13 July 2006 01:24, Theodore Tso wrote:

>> P.S.  I happen to be one those developers who think the binary
>> interface is not so bad, and for compared to reading from /proc/sys,
>> the sysctl syscall *is* faster.  But at the same there, there really
>> isn't anything where really does require that kind of speed, so that
>> point is moot.  But at the same time, what is the cost of leaving
>> sys_sysctl in the kernel for an extra 6-12 months, or even longer,
>> starting from now?
>
> The numerical namespace for sysctl is unsalvagable imho. e.g.
> distributions regularly break it because there is no central
> repository of numbers so it's not very usable anyways in practice.

Huh? How exactly is this different from system call numbers,
ioctl numbers, fcntl numbers, ptrace command numbers, and every
other part of the Linux ABI?

Normal sysctl works very well for FreeBSD. I'm jealous.
They also have a few related calls that are very nice.

Here we fight over a few CPU cycles in the syscall entry path,
then piss away performance by requiring open-read-close and
marshalling everything through decimal ASCII text. WTF? Let's
just have one system call (make_XML_SOAP_request) and be done.
