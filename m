Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbWJ2WN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWJ2WN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 17:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWJ2WN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 17:13:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:53795 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030376AbWJ2WN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 17:13:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+m/VzeM1CvwR7ePOeAWWtd+Gr3mDt8JOuFWzxBKz2pHVrdCFXJDQBvBUiVt0rrY4dcBkp9JeQPidmIf1BYgyp75zYJlllsdOHpLXP5V6VFan8XmUG3bx9E67SOuTq/XRkkfxovVG8lNMklpGh7pkGPOvEeXDaSTAW8V7yYD0/c=
Message-ID: <74d0deb30610291413r5b651d17o12d3ccce3b212ee8@mail.gmail.com>
Date: Sun, 29 Oct 2006 23:13:53 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc[123]: Oops in __wake_up_common during htc magician resume.
In-Reply-To: <74d0deb30610250346u1f444a5brbc2c32b4ab83d3e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <74d0deb30610250346u1f444a5brbc2c32b4ab83d3e2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved, I am sorry for the noise.

On 10/25/06, pHilipp Zabel <philipp.zabel@gmail.com> wrote:
> Hi!
>
> When I switched from 2.6.18 to 2.6.19-rc1 processes started to get killed
> during resume due to an oops in __wake_up_common on my arm
> pxa272 device (htc magician). The patches I used are at
> http://userpage.fu-berlin.de/~zabel/magician/magician-patches-2.6.19-rc3-20061025.tar.bz2
>
> Is there any information in those reports that could help me find the issue?
> I have no idea how to debug this, so I'd appreciate any hint.

The issue was that I had a device_driver on the platform bus.
In a git bisect this error somehow didn't show up until
[386415d88b1ae50304f9c61aa3e0db082fa90428] PM: platform_bus and
late_suspend/early_resume
After turning the offending device_driver into a platform_driver,
everything works as expected.

regards
Philipp
