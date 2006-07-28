Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752019AbWG1Pi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbWG1Pi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWG1Pi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:38:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24361 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752019AbWG1Pi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:38:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hB5Dsv8LXHmTdZBhax1/K5z9rKCam6zbklVi7/3fxs52HT5hP3I8njNdb2PBHDa6nvwugh1KbeEQtnIuP4Mr0+vS8V/PnzS9W+RtVzkrpId5YbBw3WzSHTKuHaqf1/i3QdZdOLlQEOfE1usUz86XAMcXSkAsPfbixeHGnQvcuds=
Message-ID: <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
Date: Fri, 28 Jul 2006 18:38:13 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060728134307.GD29217@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > I do not understand this. Any polling (in kernel or in userspace) will
> > wake the CPU, wasting power.
>
> The kernel, however, has all the gory details at hand, and can decide
> much better about the polling frequency, than the (hopefully) hardware
> agnostic userspace.
>
> Imagine your Zaurus: You don't need to poll very often when you are on
> the flat part of the LiIon discharge curve, you probably want more
> detailed info near the end.

Another example: on my ThinkPad, the readouts provided by the EC
change only every 2 seconds, regardless of how much you poll it.

Hence my proposal for a polling-based interface with kernel-side
caching. This way, the hardware query rate is the minimum of two
rates: what the application can use and what the kernel thinks is the
hardware's change rate.

This doesn't solve the timer interrupt (tickless kernel) issue. Sane
apps would never ask for battery updates at more than a few Hz, are we
likely to see tickless machines where this makes a difference
beyondnormal load?

  Shem
