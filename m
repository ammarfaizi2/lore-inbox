Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWDGTMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWDGTMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWDGTMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:12:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22465 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964894AbWDGTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:12:23 -0400
To: Andreas Schwab <schwab@suse.de>
Cc: Neil Brown <neilb@suse.de>, "Tony Luck" <tony.luck@gmail.com>,
       "Mike Hearn" <mike@plan99.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
References: <4431A93A.2010702@plan99.net>
	<m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
	<44343C25.2000306@plan99.net>
	<12c511ca0604061633p2fb1796axd5acad8373532834@mail.gmail.com>
	<17462.6689.821815.412458@cse.unsw.edu.au>
	<jeirplrbka.fsf@sykes.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 07 Apr 2006 13:10:26 -0600
In-Reply-To: <jeirplrbka.fsf@sykes.suse.de> (Andreas Schwab's message of
 "Fri, 07 Apr 2006 11:15:33 +0200")
Message-ID: <m1odzdmcbh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Neil Brown <neilb@suse.de> writes:
>
>> On Thursday April 6, tony.luck@gmail.com wrote:
>>> > > I have concerns about security policy ...
>>> >
>>> > I'm not sure I understand. Only if you run that program, and if you
>>> > don't have access to the intermediate directory, how do you run it?
>>> 
>>> It leaks information about the parts of the pathname below the
>>> directory that you otherwise would not be able to see.  E.g. if
>>> I have $HOME/top-secret-projects/secret-code-name1/binary
>>> where the top-secret-projects directory isn't readable by you,
>>> then you may find out secret-code-name1 by reading the
>>> /proc/{pid}/exedir symlink.
>>
>> But we already have /proc/{pid}/exe which is a symlink to the
>> executable, thus exposing all the directory names already.
>
> Neither of which should be readable by anyone but the owner of the
> process, which is the one who was able to read the secret directory in the
> first place.

In most cases.  It is possible you got the executable through
file descriptor passing and the like.

The security check in -mm allows anyone who may ptrace the
process to have read access.  In 2.6.17-rc1 the check is
still the owner of the process and anyone with CAP_DAC_ACCESS
may read or use the link.

Eric
