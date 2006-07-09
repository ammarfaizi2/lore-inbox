Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWGIUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWGIUhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWGIUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:37:48 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47595 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161130AbWGIUhr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:37:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eoOdPIc5A1jX7xivXm4HMduGlY18S6x2HY+X+wl0RcrDQ5nCEEQnx0nAF5pwXnocc0TQWEoUyi/lHylx5WTpKhixTKn3Aeh4uk4olom7noBxKP4/AIeMump7RqwbhD5MtCYe9EDoHxwGJno3dYnj8bAWw+JxZ7k1c7icjo+ZKD0=
Message-ID: <e1e1d5f40607091337g12089f22pe1e675ebc6b65132@mail.gmail.com>
Date: Sun, 9 Jul 2006 16:37:46 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Diego Calleja" <diegocg@gmail.com>
Subject: Re: Automatic Kernel Bug Report
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060709222401.52168a58.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <20060709222401.52168a58.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Sun, 9 Jul 2006 16:01:58 -0400,
> "Daniel Bonekeeper" <thehazard@gmail.com> escribió:
>
> > Independent of wheter you think that this is useful or not, do you see
> > any cleaner way to send those reports, having in mind that the
> > userspace may not be responsive ?
>
> Kdump (http://lse.sourceforge.net/kdump/) would be useful for
> many cases.

I agree.

> WRT to the bugs where the system completely locks up and doesn't
> leaves any option for automatic bug reports: You don't really care
> about those, because they're _so_ annoying that people reports them
> manually.

Yeah, or they just switch the ethernet card, get it working and go out
for a coffee. =]
In those nasty cases, we really don't have much to do, since we can't
provide a mechanism on the kernel to run when we detect that it is not
responsive (can't we ?). A rapid mindstorm: A frozen system can't
preempt tasks. If we can keep track of the timestamp of the last time
the schedule ran, and we see that it was like 5 or 10 seconds ago, it
means that something is very wrong on the kernel side. We may have
several levels of fucked-up-ness in which, at a certain level,
interrupts are still called (and we can call our code here to check
the sanity of the system). If we see that we didn't schedule for a
long time, we can trigger the report system (then again, ideally we
don't need userspace to do that). Then we just pray, hoping that the
the report gets thru the networking. Of course there is no magic
solution, but this could help on a great deal of cases.


Daniel


-- 
What this world needs is a good five-dollar plasma weapon.
