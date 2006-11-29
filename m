Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966629AbWK2JcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966629AbWK2JcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966640AbWK2JcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:32:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8754 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966629AbWK2JcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:32:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZx6l2at8TNXooe9+HoP2lHjFXVGb87YgFEP1ZX3QGgO9ea4fXqfgNfqHSnNOpn8oIdz6KBVxhreThY5lCzqH280TJAgkZbOvBclCS+D19jzwot8gowD+660gXjq/C+rtwEj6cYFaFppivq7T7luP97XnlpXc/50LveGHONp5VA=
Message-ID: <ac8af0be0611290132h2369b6b3m9592537c98489feb@mail.gmail.com>
Date: Wed, 29 Nov 2006 01:32:22 -0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: A commit between 2.6.16.4 and 2.6.16.5 failed crashme
Cc: "Andi Kleen" <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061129083310.GC11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ac8af0be0611290018y70c68a66r5a3199f08e6417d5@mail.gmail.com>
	 <20061129083310.GC11084@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Nov 29, 2006 at 12:18:18AM -0800, Zhao Forrest wrote:
> > On 11/28/06, Andi Kleen <ak@suse.de> wrote:
> > >
> > >> I first need to contact the author of test case if we could send the
> > >> test case to open source. The test case is called "crashme",
> > >
> > >Is that the classical crashme as found in LTP or an enhanced one?
> > >Do you run it in a special way? Is the crash reproducible?
> > >
> > >We normally run crashme regularly as part of LTP, Cerberus etc.
> > >so at least any obvious bugs should in theory be caught.
> > >
> >
> > Let me change the subject of this thread.
> > I just read our private version of crashme. It's based on crashme
> > version 2.4 and add some logging capability, no other enhancement. So
> > it should be the same as crashme in LTP.
> >
> > It is solidly reproducible within 3 minutes of running crashme.
> >
> > The current status is: we know it's a commit between 2.6.16.4 and
> > 2.6.16.5 that introduce this bug.
> >
> > Our network is very slow(only 5-6K/second). So we'll start the
> > git-bisect tomorrow after finishing downloading the 2.6.16 stable git
> > tree.
>
> Thanks for your report.
>
> A git-bisect might be a bit of overkill considering that there were only
> two patches applied beween 2.6.16.4 and 2.6.16.5:
>
> Andi Kleen (2):
>       x86_64: Clean up execve
>       x86_64: When user could have changed RIP always force IRET (CVE-2006-0744)
>
> I've attached both patches.
>
> Could you manually bisect first applying "x86_64: Clean up execve"
> (patch-2.6.16.4-5-1) against 2.6.16.4?
>

Hi Adrian

It's the second patch(x86_64: When user could have changed RIP always
force IRET (CVE-2006-0744)) that trigger this bug.
We have run crashme on a IBM server with 2 Intel dual-core CPU, a SUN
server with 2 AMD Opteron single-core CPU and a SUN server with 8 AMD
Opteron dual-core CPU.
Running crashme can trigger kernel panic on all platforms after the
second patch is applied to 2.6.16.4. And when kernel panic happens,
there's only "Kernel panic - not syncing: Attempted to kill init" on
the screen.

Please let me know if you need any further information.

Thanks,
Forrest
