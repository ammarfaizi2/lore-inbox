Return-Path: <linux-kernel-owner+w=401wt.eu-S1763128AbWLKVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763128AbWLKVco (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763120AbWLKVco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:32:44 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:34136 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763111AbWLKVcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:32:43 -0500
Message-ID: <457DCE1C.7010908@novell.com>
Date: Mon, 11 Dec 2006 13:31:08 -0800
From: Crispin Cowan <crispin@novell.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 0/2] file capabilities: two bugfixes
References: <20061208193657.GB18566@sergelap.austin.ibm.com> <20061209004346.GG21627@suse.de>
In-Reply-To: <20061209004346.GG21627@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Arnold wrote:
> On Fri, Dec 08, 2006 at 01:36:57PM -0600, Serge E. Hallyn wrote:
>   
>> The other is that root can lose capabilities by executing files with
>> only some capabilities set.  The next two patches change these
>> behaviors.
>>     
> I saw this in my code review and thought that this behaviour was
> intentional. :) It seemed like a good idea to me..
>   
It really depends on which threat you are trying to defend against.

Serge is correct that it does not prevent root from copying the file,
messing with the attributes, and running it anyway. However, I don't see
file capabilities as being intended to try to confine root.

Rather, it seems like it is intended to make it easier to manage what
capabilities should usually be present when the program is run. E.g. the
file has a limited capability set so that root can run it and not have
to think about overtly dropping privs or su'ing to a non-privileged user
to be able to run it safely.

So I'm with Seth; it sounds like a feature, not a bug.

Caveat: I have no clue what the POSIX.1e committee intended. But since
none of the POSIX-alike implementations are compatible with each other
anyway, I don't really care :)

Crispin

-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com
     Hacking is exploiting the gap between "intent" and "implementation"

