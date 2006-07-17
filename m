Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWGQTHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWGQTHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWGQTHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:07:36 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:35257 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751157AbWGQTHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:07:35 -0400
Message-ID: <44BBDFFC.70601@namesys.com>
Date: Mon, 17 Jul 2006 12:07:40 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com> <44BBD942.3080908@suse.com>
In-Reply-To: <44BBD942.3080908@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
> >Jeff Mahoney wrote:
>
> >>Hans Reiser wrote:
> >>
> >>>I don't understand your patch and cannot support it as it is written.  
> >>>Perhaps you can call me and explain it on the phone.
> >>
> >>I seriously can't tell if you're deliberately trying to be difficult or
> >>not. It's a simple "replace / with ! before sending the name to procfs."
> >>
> >>Reiserfs requests that a procfs directory called
> >>/proc/fs/reiserfs/<blockdev> be created. Some block devices contain
> >>slashes, so with cciss/c123 it attempts to create a directory called
> >>/proc/fs/reiserfs/cciss/c123, but cciss/ doesn't exist, shouldn't, and
> >>never will.
>
> >Why not check to see if it does not exist, and create it if not,  as
> >needed,  and skip the !'s....?
>
>
> 1) Because then the behavior of /proc/fs/reiserfs/ would be
> inconsistent. Devices that contain slashes end up being one level deeper
> than other devices, which is silly and a userspace visible change. 

And you think translating / to ! is less work for user space? 

> Tools
> that wish to parse the information would then need added complexity to
> traverse into the next level to reach that information.
>
> 2) The block-device-as-path-name-component behavior is already defined
> by sysfs (/sys/block), and it should be consistent.

Translate that as, "I won't recompile my brain no matter what you do to
make me."

You blindly copied how someone else in a hurry did it without a thought
to whether it was done right, and now you don't want to change it.  You
should have asked me about it before coding it.

Replace block-device-as-path-name-component with
block-device-as-path-name-suffix, and everything is very consistent. 
And elegant.

Jeff, you are a programmer, not an architect, and when you disregard
architects we end up with things like the performance disaster that is
V3 acls.

Replacing / with ! is hideous.  Someone added a nifty elegance to block
device naming, and you are desecrating it.

Hans
